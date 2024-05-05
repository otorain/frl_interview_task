module ApplicationHelper
  def is_amazon_link?(url)
    URI(url).host&.start_with? "www.amazon"
  end
end
