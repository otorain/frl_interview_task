class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]

  def index
    @products = Product.order("id DESC")
  end

  def show
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      render turbo_stream: turbo_stream.update("new_product_error", "Failed to save! #{@product.errors.full_messages.join(", ")}" )
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:title, :brand, :price, :landing_image, :description, :url, images: [])
  end
end
