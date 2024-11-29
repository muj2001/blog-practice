class CategoriesController < ApplicationController
  include Authorization

  before_action :authorize_admin, only: [ :new, :create, :update, :destroy, :edit ]

  def index
    @categories = Category.all
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      redirect_to categories_path, alert: "Could not make new category."
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @category = Category.find(params[:id])
    name = @category.name
    if @category.destroy
      redirect_to categories_path, alert: "Category \'#{name}\' deleted"
    end
  end

  private

  def category_params
    p params
    params.require(:category).permit(:name)
  end
end
