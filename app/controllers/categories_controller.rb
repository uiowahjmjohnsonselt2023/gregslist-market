class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def create
    @seller = Seller.find_by(id: session[:seller_id])
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def new
    @seller = Seller.find_by(id: session[:seller_id])
    @category = Category.new
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
