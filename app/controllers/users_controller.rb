class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,]
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = current_user
    if params[:id].to_i == current_user.id
      render action: :edit
    else
     redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render action: :edit
    end
  end

  def following
      @user  = User.find(params[:id])
      @users = @user.relationships
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.reverse_of_relationships
    render 'show_follower'
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
