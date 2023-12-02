class SellerReviewsController < ApplicationController
  def show
    @review = SellerReview.find(params[:id])
  end

  def new
    @review = SellerReview.new
  end

  def edit
    @review = SellerReview.find(params[:id].keys[0])
  end

  def update
    @review = SellerReview.find(params[:review][:id])
    if @review.update({ rating: params[:review][:rating], text: params[:review][:text] })
      flash[:notice] = 'Review updated'
    end
    redirect_to seller_path
  end

  def create
    @review = SellerReview.new(seller_params)
    @review.users << current_user
    if @review.save
      redirect_to @review
      puts 'SAVED'
    else
      puts 'NEW'
      render 'new'
    end
  end

  def select
    @valid_sellers = current_user.seller
    render 'select'
  end

  private

  def seller_params
    params.require(:seller).permit(:name, :description, :address)
  end
end
