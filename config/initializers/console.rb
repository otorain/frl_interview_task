
Rails.application.console do
  def sample_url
    "https://www.amazon.com/HP-Display-GeForce-Backlit-Keyboard/dp/B0CFSBT85B/ref=sr_1_2?crid=12NGSCVKSNOXL&dib=eyJ2IjoiMSJ9.e4ZJ_alIKHxWz64_XAm8gaaDtrJq7lMPXgMk7z1eSvd3gN-qGA4_kn7aq04Bg5fAuulv_zvzy_JzRCUHFc5vtzxGO4kQKSMERFw6IOM1xbc2cVCN_c1jCSJZsUnGov6FL_ZigtYhGssEkR08LWnb-O-4SZw0_J8PoxIxL56kjN0ho3ee_Dck9WANrSUrHpYWVyt8jRAIQ_h8K7qQn4p4aBWDrA-bdElIA66YasOYIi4.56ZtNWpoO7pOpTGms24EIXXrlfUE-rZjOvY3yvOAZQQ&dib_tag=se&keywords=gaming%2Blaptop&qid=1714640583&sprefix=%2Caps%2C843&sr=8-2&th=1"
  end

  def sample_product
    @sample_product ||= AmazonProductLinkParser.new(sample_url).parse
  end
end