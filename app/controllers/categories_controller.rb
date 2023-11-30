class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories
    # @total_budget = total_purchase_amount
  end
     
  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Category created successfully.'
    else
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @category.destroy
    redirect_to categories_path, notice: 'Category deleted successfully.'
  end

  # def total_purchase_amount(categories)
  #   categories.each do |cat|
  #   cat.purchases.sum(:amount)
     
  # end
  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
  