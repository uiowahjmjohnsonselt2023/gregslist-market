class SellerReviewsController < ApplicationController
  def show
    @review = SellerReview.find(params[:id])
  end

  def new
    @review = SellerReview.new
    @user = current_user
    @seller_id = params[:seller_id]
  end

  def create_or_edit
    @user = current_user
    @seller_id = params[:seller_id]
    @existing_review = SellerReview.where(seller_id: @seller_id, user_id: @user_id)
    if @existing_review.blank?
      redirect_to new_seller_review_path, seller_id: params[:seller_id]
    else
      redirect_to edit_seller_review_path, seller_id: @existing_review.id
    end
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
      render 'new', seller_id: @review.seller_id
    end
  end

  private

  def seller_review_params
    params.require(:seller_review).permit(:seller_id, :user_id, :rating, :text)
  end
end
