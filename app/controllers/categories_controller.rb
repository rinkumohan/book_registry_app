class CategoriesController < ApplicationController
  before_action :find_category, only: [:edit, :update, :destroy]
  before_action :find_all_categories, only: [:index]

  def index
    if !params[:sort_on].blank? || !params[:sort_by].blank?
      @categories = @categories.reorder("#{params[:sort_on]} #{params[:sort_by]}")
    else
      @categories.order(:id)
    end
    respond_to do |format|
      format.html
      format.json { render json: { message: "Successful", categories: @categories, status: 200 } }
    end
  end

  def new
    @category = Category.new
  end

  def edit

  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Successfully Created Category"
      respond_to do |format|
        format.html {redirect_to categories_path}
        format.json { render json: { message: 'Successfully Created Category', category: @category, status: 200 } }
      end
    else
      flash[:error] = @category.errors.full_messages.uniq.join(', ')
      respond_to do |format|
        format.html {redirect_to new_category_path}
        format.json {  render json: {message: 'Unable to create category', error: @category.errors.full_messages, status: 401} }
      end
    end
  end

  def update
    category = @category.update_attributes(category_params)
    if category
      flash[:success] = "Successfully Updated Category"
      respond_to do |format|
        format.html {redirect_to categories_path}
        format.json { render json: { message: 'Successfully Updated Category', category: @category, status: 200 } }
      end
    else
      flash[:error] = @category.errors.full_messages.uniq.join(', ')
      respond_to do |format|
        format.html {redirect_to edit_category_path}
        format.json {  render json: {message: 'Unable to update category', error: category.errors.full_messages, status: 401} }
      end
    end
  end

  def destroy
    category = @category.destroy
    if category
      flash[:success] = "Successfully Deleted Category"
      respond_to do |format|
        format.html {redirect_to categories_path}
        format.json { render json: { message: 'Successfully deleted Category', status: 200 } }
      end
    else
      flash[:error] = @category.errors.full_messages.uniq.join(', ') if !category
      respond_to do |format|
        format.html {redirect_to categories_path}
        format.json { render json: { message: 'Unable to delete Category', category: category.errors.full_messages, status: 401 } }
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_all_categories
    @categories = Category.all
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
