class BookCommentsController < ApplicationController
before_action :is_matching_login_user, only: [:destroy]
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if comment.save
    redirect_back(fallback_location: root_path)
    flash[:notice] = "comment was successfully created."
    else
      @books = Book.all
    redirect_back(fallback_location: root_path)
    end


  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def is_matching_login_user
    book_comment = BookComment.find(params[:id])
    unless book_comment.user.id == current_user.id
    @books = Book.all
      redirect_to '/books'
    end
  end
end
