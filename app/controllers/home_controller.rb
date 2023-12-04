class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @books = Book.published.order(:id)
  end
end
