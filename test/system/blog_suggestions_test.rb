require "application_system_test_case"

class BlogSuggestionsTest < ApplicationSystemTestCase
  setup do
    @blog_suggestion = blog_suggestions(:one)
  end

  test "visiting the index" do
    visit blog_suggestions_url
    assert_selector "h1", text: "Blog Suggestions"
  end

  test "creating a Blog suggestion" do
    visit blog_suggestions_url
    click_on "New Blog Suggestion"

    fill_in "Description", with: @blog_suggestion.description
    fill_in "Status", with: @blog_suggestion.status
    fill_in "Title", with: @blog_suggestion.title
    click_on "Create Blog suggestion"

    assert_text "Blog suggestion was successfully created"
    click_on "Back"
  end

  test "updating a Blog suggestion" do
    visit blog_suggestions_url
    click_on "Edit", match: :first

    fill_in "Description", with: @blog_suggestion.description
    fill_in "Status", with: @blog_suggestion.status
    fill_in "Title", with: @blog_suggestion.title
    click_on "Update Blog suggestion"

    assert_text "Blog suggestion was successfully updated"
    click_on "Back"
  end

  test "destroying a Blog suggestion" do
    visit blog_suggestions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blog suggestion was successfully destroyed"
  end
end
