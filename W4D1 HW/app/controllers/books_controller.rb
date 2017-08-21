class BooksController < ApplicationController
  def index
    @books = Book.all

    # your code here
  end

  def new
    render :new
  end

  def create
    book = Book.new(book_params)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to book_url
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end
