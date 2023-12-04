class BooksController < ApplicationController
  before_action :find_book, only: [:edit,:update,:destroy,:publish_or_unpublish]
  before_action :find_all_books, only: [:index]

  def index
    if !params[:sort_on].blank? || !params[:sort_by].blank?
      @books = @books.reorder("#{params[:sort_on]} #{params[:sort_by]}")
    else
      @books.order(:id)
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params.merge(:user_id => current_user.id))
    if @book.save
      flash[:success] = "Successfully Created Book"
      redirect_to books_path
    else
      flash[:error] = @book.errors.full_messages.uniq.join(', ')
      redirect_to new_book_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:book_name,:author,:isbn,:price,:category_id,:publish_status,:user_id)
  end

  def find_book
    @book = Book.find_by_id(params[:id])
  end

  def find_all_books
    @books = params[:search].blank? ? Book.all.order("book_name ASC") : Book.search(params[:search]).order("book_name ASC")
  end
end
