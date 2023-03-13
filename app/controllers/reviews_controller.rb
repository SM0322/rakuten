class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end
  
  def create
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.new(reviews_params)
    @review.book_id = @book.id
    if @review.save!
      redirect_to book_path(@book)
    else
      redirect_to books_path
    end 
  end 
  
  private
  
  def reviews_params
    params.require(:review).permit(:impression)
  end
end
