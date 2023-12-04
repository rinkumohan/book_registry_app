class HomeController < ApplicationController

  def index
    @books = Book.published.order(:id)
  end
end
