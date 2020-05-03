class BooksController < ApplicationController
  def index
  	@books = Book.all
  	@book = Book.new
  end

  def show
  	@book = Book.find(params[:id])
  end

  def new
  	@book = Book.new
  end

  def create
  	book = Book.new(params[book_params])
    book.save
    redirect_to books_path
  end
  
  def edit
  end

  private
  def book_params
  	params.require(:book).premit(:title, :body)
  end

end
