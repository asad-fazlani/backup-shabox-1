require "application_system_test_case"

class MailServicesTest < ApplicationSystemTestCase
  setup do
    @mail_service = mail_services(:one)
  end

  test "visiting the index" do
    visit mail_services_url
    assert_selector "h1", text: "Mail Services"
  end

  test "creating a Mail service" do
    visit mail_services_url
    click_on "New Mail Service"

    fill_in "Body", with: @mail_service.body
    fill_in "Titile", with: @mail_service.titile
    click_on "Create Mail service"

    assert_text "Mail service was successfully created"
    click_on "Back"
  end

  test "updating a Mail service" do
    visit mail_services_url
    click_on "Edit", match: :first

    fill_in "Body", with: @mail_service.body
    fill_in "Titile", with: @mail_service.titile
    click_on "Update Mail service"

    assert_text "Mail service was successfully updated"
    click_on "Back"
  end

  test "destroying a Mail service" do
    visit mail_services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mail service was successfully destroyed"
  end
end
