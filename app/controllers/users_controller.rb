class UsersController < ApplicationController
  def show
    @user = current_user
    @books = @user.books
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @user = User.new
    @users = User.all
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
