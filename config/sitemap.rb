SitemapGenerator::Sitemap.default_host = "http://www.shadbox.com"
SitemapGenerator::Sitemap.create do
  add root_path
  add new_contact_u_path
  add home_index_path
  add home_privacy_policy_path
  add new_user_session_path
  add new_user_password_path
  add edit_user_password_path
  add new_user_registration_path
  add new_user_confirmation_path
  add about_path
  add faq_path
  add privacy_policy_path
  add quizzes_path
  add new_blog_path
  add blogs_path
  Category.find_each do |category|
  	add category_path(category), :changefreq => 'daily', :lastmod => Time.now
  end
  Blog.find_each do |blog|
  	add blog_path(blog), :changefreq => 'daily', :lastmod => blog.updated_at
  end
end