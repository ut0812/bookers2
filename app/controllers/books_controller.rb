class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id)
    flash[:notice] = "Book was successfully created."
    else
      @books = Book.all
      render :index
    end
  end

  def destroy
    @user = current_user
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    if book.destroy  # データ（レコード）を削除
    flash[:notice] = "Book was successfully destroyed"
    end
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  def show
    @booknew = Book.new#変数を新規作成
    @book = Book.find(params[:id])
    @user = @book.user


  end

  def update
    @user = current_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id)
    flash[:notice] = "Book was successfully updated."
    else
      @books = Book.all
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
    @books = Book.all
      redirect_to '/books'
    end
  end

end
