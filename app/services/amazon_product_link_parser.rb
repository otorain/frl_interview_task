# require "net/http"
require "selenium-webdriver"

class AmazonProductLinkParser
  RateLimitedError = Class.new(StandardError)

  attr_reader :driver, :url

  def initialize(url, headless: true)
    @url = url
    @driver = init_chrome_webdriver(headless:)
  end

  def parse
    driver.navigate.to url

    # to load all product images
    driver.find_elements(css: ".imageThumbnail").each(&:click)


    raise RateLimitedError if rate_limited?

    { title:, description:, brand:, price:, landing_image:, images: }
  end

  private

  def title
    title_selector = "#productTitle"
    driver.find_element(css: title_selector).text
  rescue Selenium::WebDriver::Error::NoSuchElementError
    ""
  end

  def landing_image
    landing_image_selector = "#main-image-container .image.itemNo0 img"
    driver.find_element(css: landing_image_selector)["src"]
  rescue Selenium::WebDriver::Error::NoSuchElementError
    ""
  end

  def images
    images_selector = "#main-image-container .image img"
    driver.find_elements(css: images_selector).map do |img|
      img['src']
    end
  rescue Selenium::WebDriver::Error::NoSuchElementError
    []
  end

  def price
    symbol = driver.find_element(css: ".a-price-symbol").text
    amount = driver.find_element(css: ".a-price-whole").text
    fraction = driver.find_element(css: ".a-price-fraction").text

    ["#{symbol}#{amount}", "#{fraction}"].join(".")
  rescue Selenium::WebDriver::Error::NoSuchElementError
    ""
  end

  def brand
    brand_selector = ".po-brand .po-break-word"
    driver.find_element(css: brand_selector).text
  rescue Selenium::WebDriver::Error::NoSuchElementError
    ""
  end

  def description
    descriptions_selector = "#productDescription span"
    driver.find_elements(css: descriptions_selector).map(&:text).join("\n")
  rescue Selenium::WebDriver::Error::NoSuchElementError
    ""
  end


  def init_chrome_webdriver(headless:)
    options = init_chrome_webdriver_options
    options.add_argument("--headless") if headless

    user_agent = Rails.configuration.user_agents.sample
    options.add_argument("--user-agent=#{user_agent}")

    Selenium::WebDriver.for(:chrome, options: options) do |driver|
      # Changing the property of the navigator value for webdriver to undefined
      driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
    end
  end

  def init_chrome_webdriver_options
    Selenium::WebDriver::Chrome::Options.new.tap do |options|
      # Adding argument to disable the AutomationControlled flag
      options.add_argument("--disable-blink-features=AutomationControlled")

      # Exclude the collection of enable-automation switches
      options.exclude_switches << "enable-automation"
    end
  end

  def rate_limited?
    driver.find_element(css: "body").text.include?("Enter the characters you see below")
  end
end