require "test_helper"

class CreditCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @credit_card = credit_cards(:one)
  end

  test "should get index" do
    get credit_cards_url, as: :json
    assert_response :success
  end

  test "should create credit_card" do
    assert_difference("CreditCard.count") do
      post credit_cards_url, params: { credit_card: { card_number: @credit_card.card_number, cvv: @credit_card.cvv, expiration_date: @credit_card.expiration_date, name: @credit_card.name, user_id: @credit_card.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show credit_card" do
    get credit_card_url(@credit_card), as: :json
    assert_response :success
  end

  test "should update credit_card" do
    patch credit_card_url(@credit_card), params: { credit_card: { card_number: @credit_card.card_number, cvv: @credit_card.cvv, expiration_date: @credit_card.expiration_date, name: @credit_card.name, user_id: @credit_card.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy credit_card" do
    assert_difference("CreditCard.count", -1) do
      delete credit_card_url(@credit_card), as: :json
    end

    assert_response :no_content
  end
end
