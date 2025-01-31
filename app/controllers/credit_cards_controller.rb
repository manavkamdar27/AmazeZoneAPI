class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: %i[ show update destroy ]
  before_action :authenticate_request

  # GET /credit_cards
  def index
    @credit_cards = current_user.credit_cards

    render json: @credit_cards
  end

  # GET /credit_cards/1
  def show
    if @credit_card.user == current_user
      render json: @credit_card
    else
      render json: { error: 'Access Denied' }, status: :forbidden
    end
  end

  # POST /credit_cards
  def create
    @credit_card = CreditCard.new(credit_card_params)
    @credit_card.user = current_user

    if @credit_card.save
      render json: @credit_card, status: :created, location: @credit_card
    else
      render json: @credit_card.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /credit_cards/1
  def update
    if @credit_card.user == current_user
      if @credit_card.update(credit_card_params)
        render json: @credit_card
      else
        render json: @credit_card.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Access denied' }, status: :forbidden
    end
  end


  # DELETE /credit_cards/1
  def destroy
    if @credit_card.user == current_user
      @credit_card.destroy
    else
      render json: { error: 'Access denied' }, status: :forbidden
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = CreditCard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def credit_card_params
      params.require(:credit_card).permit(:name, :card_number, :expiration_date, :cvv, :user_id)
    end
end
