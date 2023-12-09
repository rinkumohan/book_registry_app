class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_all_books, only: [:index]

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

  private

  def find_all_books
    @books = params[:search].blank? ? Book.published : Book.published.search(params[:search])
    @books.order("book_name ASC")
  end
end
