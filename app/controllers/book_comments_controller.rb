class BookCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.save
    @comments = @book.book_comments
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
  end

  private

  def comment_params
    params.require(:book_comment).permit(:book_comment)
  end
end
