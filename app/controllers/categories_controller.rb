class CategoriesController < ApplicationController
  def index
    if params[:seller_id].present? || session[:seller_id].present?
      session[:seller_id] = params[:seller_id] if params[:seller_id].present?
      @seller = Seller.find_by(id: session[:seller_id])

      
      
      if @seller.nil?
        redirect_to root_path, alert: 'Seller not found'
        return
      end
    else
      redirect_to root_path, alert: 'Seller ID not provided'
      return
    end

    @categories = Category.all
    # Render the appropriate view, e.g., render 'categories/index'
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
