class UsersController < ApplicationController


  def index
    @users = User.all
    @book_new = Book.new
    @user = current_user
  end

  def show
  	@user = User.find(params[:id])
    @books = Book.where(user_id: current_user.id)
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(@user.id)
  end


  private
    def user_params
    	params.require(:user).permit(:name, :profile_image, :introduction)
    end
  end
