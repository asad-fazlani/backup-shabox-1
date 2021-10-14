require "test_helper"

class PaymentRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment_request = payment_requests(:one)
  end

  test "should get index" do
    get payment_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_payment_request_url
    assert_response :success
  end

  test "should create payment_request" do
    assert_difference('PaymentRequest.count') do
      post payment_requests_url, params: { payment_request: { comment: @payment_request.comment, status: @payment_request.status, user_id: @payment_request.user_id } }
    end

    assert_redirected_to payment_request_url(PaymentRequest.last)
  end

  test "should show payment_request" do
    get payment_request_url(@payment_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_request_url(@payment_request)
    assert_response :success
  end

  test "should update payment_request" do
    patch payment_request_url(@payment_request), params: { payment_request: { comment: @payment_request.comment, status: @payment_request.status, user_id: @payment_request.user_id } }
    assert_redirected_to payment_request_url(@payment_request)
  end

  test "should destroy payment_request" do
    assert_difference('PaymentRequest.count', -1) do
      delete payment_request_url(@payment_request)
    end

    assert_redirected_to payment_requests_url
  end
end
