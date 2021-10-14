require "application_system_test_case"

class ContactUsTest < ApplicationSystemTestCase
  setup do
    @contact_u = contact_us(:one)
  end

  test "visiting the index" do
    visit contact_us_url
    assert_selector "h1", text: "Contact Us"
  end

  test "creating a Contact u" do
    visit contact_us_url
    click_on "New Contact U"

    fill_in "Body", with: @contact_u.body
    fill_in "Email", with: @contact_u.email
    fill_in "Mobile number", with: @contact_u.mobile_number
    fill_in "Name", with: @contact_u.name
    fill_in "Subject", with: @contact_u.subject
    click_on "Create Contact u"

    assert_text "Contact u was successfully created"
    click_on "Back"
  end

  test "updating a Contact u" do
    visit contact_us_url
    click_on "Edit", match: :first

    fill_in "Body", with: @contact_u.body
    fill_in "Email", with: @contact_u.email
    fill_in "Mobile number", with: @contact_u.mobile_number
    fill_in "Name", with: @contact_u.name
    fill_in "Subject", with: @contact_u.subject
    click_on "Update Contact u"

    assert_text "Contact u was successfully updated"
    click_on "Back"
  end

  test "destroying a Contact u" do
    visit contact_us_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contact u was successfully destroyed"
  end
end
