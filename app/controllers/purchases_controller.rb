class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.find(params[:category_id])
    @top_purchases = @category.purchases.order(created_at: :desc).limit(5)
  end

  def new
    @purchase = current_user.purchases.build
    @category = Category.find(params[:category_id])
  end

  def create
    @purchase = current_user.purchases.build(purchase_params)

    if @purchase.category_ids.empty?
      flash.now[:alert] = 'Please select at least one category.'
      @category = Category.where(user: current_user)
      render :new
    elsif @purchase.save
      redirect_to category_purchases_path, notice: 'Purchase created successfully.'
    else
      render :new
    end
  end

  def destroy
    @purchase = current_user.purchases.find(params[:id])
    @purchase.destroy
    redirect_to category_purchases_path, notice: 'Purchase deleted successfully.'
  end

  private

  def purchase_params
    params.require(:purchase).permit(:name, :amount, category_ids: [])
  end
end
