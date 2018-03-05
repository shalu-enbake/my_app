class BooksController < ApplicationController
  before_action :authenticate_user!, :only => :index
   before_action :check_authentication, :only => [:edit,:destroy]


  def index  
    # byebug
    if params[:search].present?
      begin
        Date.parse(params[:search])
        @books = Book.where("(created_at BETWEEN ? AND ?)", params[:search].to_datetime, (params[:search].to_datetime + 1.day) )
      rescue ArgumentError
         # handle invalid date
        @books = Book.where("LOWER(auther) LIKE ?","%#{params[:search].downcase}%")
      end
    else
	    @books = Book.all
    end
    respond_to do |format| 
     format.html    { render :index }
     format.js  
    end
  end

  def new
  	@books = current_user.books.new  
  end

  def create
    
    @books = current_user.books.create(books_params)
    if @books.save
    	UsermailerMailer.welcome_email(current_user).deliver_now
    	redirect_to books_path
    else
    	redirect_to new_book_path 
    end 
  end

  def edit
  	@books = Book.find(params[:id])
  end

  def update
  	@books = Book.find(params[:id])
  	if @books.update(books_params)
  		redirect_to books_path
  	else
  		 render 'edit'
  	end
  end

  def destroy
  	@books = Book.find(params[:id])
  	@books.destroy

  	redirect_to books_path
  end

  private

  def check_authentication
    @books = Book.find(params[:id])

    if current_user.id != @books.user_id
      flash[:alert] = "You must be logged in to access this section"
      redirect_to books_path
    end
  end
  
  private
  
  def books_params
  	params.require(:book).permit(:title, :auther, :user_id, :attachment)
  
  end

end
