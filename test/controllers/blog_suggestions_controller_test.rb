require "test_helper"

class BlogSuggestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog_suggestion = blog_suggestions(:one)
  end

  test "should get index" do
    get blog_suggestions_url
    assert_response :success
  end

  test "should get new" do
    get new_blog_suggestion_url
    assert_response :success
  end

  test "should create blog_suggestion" do
    assert_difference('BlogSuggestion.count') do
      post blog_suggestions_url, params: { blog_suggestion: { description: @blog_suggestion.description, status: @blog_suggestion.status, title: @blog_suggestion.title } }
    end

    assert_redirected_to blog_suggestion_url(BlogSuggestion.last)
  end

  test "should show blog_suggestion" do
    get blog_suggestion_url(@blog_suggestion)
    assert_response :success
  end

  test "should get edit" do
    get edit_blog_suggestion_url(@blog_suggestion)
    assert_response :success
  end

  test "should update blog_suggestion" do
    patch blog_suggestion_url(@blog_suggestion), params: { blog_suggestion: { description: @blog_suggestion.description, status: @blog_suggestion.status, title: @blog_suggestion.title } }
    assert_redirected_to blog_suggestion_url(@blog_suggestion)
  end

  test "should destroy blog_suggestion" do
    assert_difference('BlogSuggestion.count', -1) do
      delete blog_suggestion_url(@blog_suggestion)
    end

    assert_redirected_to blog_suggestions_url
  end
end
