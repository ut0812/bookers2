class BooksController < ApplicationController
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
    flash[:notice1] = "Book was successfully destroyed"
    end
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @books = @user.books

  end

  def update
    @user = current_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id)
    flash[:notice2] = "Book was successfully updated."
    else
      @books = Book.all
      render :edit
    end
  end

  def book_params
    params.require(:book).permit(:title, :body,)
  end

end
