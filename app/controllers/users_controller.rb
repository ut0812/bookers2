class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @book = Book.new
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:notice] = "You have updated user successfully."
    else
    @book = Book.new
    @users = User.all
    render :edit
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all

  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end
