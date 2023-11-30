class OlderTransactionsController < ApplicationController
    before_action :authenticate_user! 
  
    def index
      @category = Category.find(params[:category_id])
      @older_transactions = older_transactions_for_category(@category)
    end
  
    def destroy
      @category = Category.find(params[:category_id])
      @transaction = @category.purchases.find(params[:id])
      @transaction.destroy
      redirect_to older_transactions_path(category_id: @category.id), notice: 'Transaction was successfully destroyed.'
    end
  
    private
  
    def older_transactions_for_category(category)
      category.purchases.order(created_at: :desc).offset(5)
    end
  end
  