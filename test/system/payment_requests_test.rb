require "application_system_test_case"

class PaymentRequestsTest < ApplicationSystemTestCase
  setup do
    @payment_request = payment_requests(:one)
  end

  test "visiting the index" do
    visit payment_requests_url
    assert_selector "h1", text: "Payment Requests"
  end

  test "creating a Payment request" do
    visit payment_requests_url
    click_on "New Payment Request"

    fill_in "Comment", with: @payment_request.comment
    fill_in "Status", with: @payment_request.status
    fill_in "User", with: @payment_request.user_id
    click_on "Create Payment request"

    assert_text "Payment request was successfully created"
    click_on "Back"
  end

  test "updating a Payment request" do
    visit payment_requests_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @payment_request.comment
    fill_in "Status", with: @payment_request.status
    fill_in "User", with: @payment_request.user_id
    click_on "Update Payment request"

    assert_text "Payment request was successfully updated"
    click_on "Back"
  end

  test "destroying a Payment request" do
    visit payment_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payment request was successfully destroyed"
  end
end
