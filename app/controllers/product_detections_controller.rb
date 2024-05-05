class ProductDetectionsController < ApplicationController
  def create
    @url = params[:url]
    return render_link_invalid_message unless helpers.is_amazon_link?(@url)
    @product = Product.new
    @result = AmazonProductLinkParser.new(@url).parse
  end

  def render_link_invalid_message
    render turbo_stream: turbo_stream.update("product_link_error", "amazon link support only.")
  end
end
