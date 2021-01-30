class BookCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      redirect_to request.referer
    else
      @book_new = Book.new
      @book_comments = @book.comments
      redirect_to new_book_path
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:book_comment).permit(:book_comment)
  end
end
