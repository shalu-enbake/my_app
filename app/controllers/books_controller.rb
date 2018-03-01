class BooksController < ApplicationController
  before_action :authenticate_user!, :only => :index

  def index  
    if params[:search].present?
      @books = Book.where("auther LIKE ?", "%#{params[:search]}%")
      
    else
	    @books = Book.all
    end
    respond_to do |format| 
     format.html    { render :index }
     format.js  
    end
  end

  def new
  	@books = Book.new   
  end

  def create
    
    @books = Book.new(books_params)
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
  
  def books_params
  	params.require(:book).permit(:title, :auther, :attachment)
  
  end

end
