class BooksController < ApplicationController
  before_action :find_book, only: [:edit,:update,:destroy,:publish_book, :unpublish_book,
                                   :calculate_book_price]
  before_action :find_all_books, only: [:index]
  skip_before_action :verify_authenticity_token, only: [:calculate_book_price]

  def index
    if !params[:sort_on].blank? || !params[:sort_by].blank?
      @books = @books.reorder("#{params[:sort_on]} #{params[:sort_by]}")
    else
      @books.order(:id)
    end
    respond_to do |format|
      format.html
      format.js
      format.json { render json: { message: "Successful", books: @books, status:200 } }
    end
  end

  def new
    @book = Book.new
  end

  def edit

  end

  def create
    @book = Book.new(book_params.merge(:user_id => current_user.id))
    if @book.save
      flash[:success] = "Successfully Created Book"
      respond_to do |format|
        format.html {redirect_to books_path}
        format.json { render json: { message: 'Successfully Created Book', book: @book, status: 200 } }
      end
    else
      flash[:error] = @book.errors.full_messages.uniq.join(', ')
      respond_to do |format|
        format.html {redirect_to new_book_path}
        format.json {  render json: {message: 'Unable to crate book', error: @book.errors.full_messages, status: 401} }
      end
    end
  end

  def update
    book = @book.update_attributes(book_params)
    if book
      flash[:success] = "Successfully Updated Book"
      respond_to do |format|
        format.html {redirect_to books_path}
        format.json { render json: { message: 'Successfully Updated Book', book: @book, status: 200 } }
      end
    else
      flash[:error] = @book.errors.full_messages.uniq.join(', ')
      respond_to do |format|
        format.html {redirect_to edit_book_path}
        format.json {  render json: {message: 'Unable to update book', error: book.errors.full_messages, status: 401} }
      end
    end
  end

  def destroy
    book = @book.destroy
    if book
      flash[:success] = "Successfully Deleted Book"
      respond_to do |format|
        format.html {redirect_to books_path}
        format.json { render json: { message: 'Successfully deleted Book', status: 200 } }
      end
    else
      flash[:error] = @book.errors.full_messages.uniq.join(', ') if !book
      respond_to do |format|
        format.html {redirect_to books_path}
        format.json { render json: { message: 'Unable to delete Book', book: book.errors.full_messages, status: 401 } }
      end
    end
  end

  def publish_book
    unless @book.publish_status
      @book.publish_book
      flash[:success] = "Successfully published Book"
      respond_to do |format|
        format.html {redirect_to books_path}
        format.json { render json: { message: 'Successfully published Book', book: @book, status: 200 } }
      end
    else
      flash[:error] = "Book is already published"
      respond_to do |format|
        format.html {redirect_to books_path}
        format.json { render json: { message: 'Book is already published', book: book, status: 401 } }
      end
    end
  end

  def unpublish_book
    if @book.publish_status
      @book.unpublish_book
      flash[:success] = "Successfully unpublished Book"
      respond_to do |format|
        format.html {redirect_to books_path}
        format.json { render json: { message: 'Successfully unpublished Book', book: @book, status: 200 } }
      end
    else
      flash[:error] = "Book is already unpublished"
      respond_to do |format|
        format.html {redirect_to books_path}
        format.json { render json: { message: 'Book is already unpublished', book: book, status: 401 } }
      end
    end
  end

  def calculate_book_price
    @price_details = @book.calculate_price
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Successfully calculated book price', price_details: price_details, status: 200 } }
    end
  end

  private

  def book_params
    params.require(:book).permit(:book_name, :author, :isbn, :price, :category_id,
                                 :publish_status, :user_id, :available_count)
  end

  def find_book
    @book = Book.find_by_id(params[:id])
  end

  def find_all_books
    @books = params[:search].blank? ? Book.all : Book.search(params[:search])
    @books.order("book_name ASC")
  end
end
