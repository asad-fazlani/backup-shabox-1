require "test_helper"

class MailServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mail_service = mail_services(:one)
  end

  test "should get index" do
    get mail_services_url
    assert_response :success
  end

  test "should get new" do
    get new_mail_service_url
    assert_response :success
  end

  test "should create mail_service" do
    assert_difference('MailService.count') do
      post mail_services_url, params: { mail_service: { body: @mail_service.body, titile: @mail_service.titile } }
    end

    assert_redirected_to mail_service_url(MailService.last)
  end

  test "should show mail_service" do
    get mail_service_url(@mail_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_mail_service_url(@mail_service)
    assert_response :success
  end

  test "should update mail_service" do
    patch mail_service_url(@mail_service), params: { mail_service: { body: @mail_service.body, titile: @mail_service.titile } }
    assert_redirected_to mail_service_url(@mail_service)
  end

  test "should destroy mail_service" do
    assert_difference('MailService.count', -1) do
      delete mail_service_url(@mail_service)
    end

    assert_redirected_to mail_services_url
  end
end
