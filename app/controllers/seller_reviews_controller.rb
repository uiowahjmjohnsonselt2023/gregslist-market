class SellerReviewsController < ApplicationController
  def show
    @review = SellerReview.find(params[:id])
  end

  def new
    @review = SellerReview.new
    @user = current_user
    @seller_id = params[:seller_id]
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
    @review = SellerReview.new(seller_review_params)
    @review.user_id ||= current_user
    if @review.save
      redirect_to @review
      puts 'SAVED'
    else
      puts 'NEW'
      render 'new'
    end
  end

  private

  def seller_review_params
    params.require(:seller_review).permit(:seller_id, :user_id, :rating, :text)
  end
end
