class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show update destroy ]
  # This was created from scratch
  # GET /transactions
  def index
    @transactions = Transaction.all

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.transaction_number = Array.new(10){[*"A".."Z", *"0".."9"].sample}.join
    @product = Product.find(params[:transaction][:product_id])
    @transaction.user_id = current_user.id
    @product.quantity = @product.quantity - @transaction.quantity
    @product.save

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:transaction_number, :quantity, :total_cost, :user_id, :credit_card_id, :product_id)
    end
end
