class BooksController < ApplicationController

  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
  	@books = Book.all
  	@book = Book.new
    @user = current_user
  end

  def show
  	@book = Book.find(params[:id])
    @book_new = Book.new
    @user = current_user
  end

  def new
  	@book = Book.new
  end

  def create
    @books = Book.all
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path
      flash[:notice] = "successfully"
    else
      render 'index'
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @books = Book.all
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = "successfully"
    else
      render 'index'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def ensure_correct_user
       @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to books_path
    end
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
 