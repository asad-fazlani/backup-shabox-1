Rails.application.routes.draw do



  resources :wallets
  resources :payment_requests
  resources :competitions
  post '/upload_image' => 'froala#upload_image', :as => :froala_upload_image
  post '/upload_image_jpeg' => 'froala#upload_image_jpeg', :as => :froala_upload_image_jpeg
  post '/upload_image_resize' => 'froala#upload_image_resize', :as => :froala_upload_image_resize
  post '/upload_image_validation' => 'froala#upload_image_validation', :as => :froala_upload_image_validation
  post '/delete_image' => 'froala#delete_image', :as => :froala_delete_image

  post '/upload_file' => 'froala#upload_file', :as => :froala_upload_file
  post '/upload_file_validation' => 'froala#upload_file_validation', :as => :froala_upload_file_validation
  post '/delete_file' => 'froala#delete_file', :as => :froala_delete_file

  post '/upload_video' => 'froala#upload_video', :as => :froala_upload_video

  get '/uploads/:name' => 'froala#access_file', :as => :froala_upload_access_file, :name => /.*/
  get '/load_images' => 'froala#load_images', :as => :froala_load_images


  resources :articles
  resources :blog_suggestions
  resources :follows
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :mail_services
  resources :contact_us
  resources :services
  get '/all_services' => 'services#all_services'


  get 'home/index'

  get 'home/chats'

  get 'home/privacy_policy'

  post '/rate' => 'rater#create', :as => 'rate'
  
  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }

  resources :users
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"

  get '/followings', to: "users#followings", as: "followings"
  get '/followers', to: "users#followers", as: "followers"
  get '/users/:id/earning', to: "users#earning", as: "earning"
  get '/users/:id/verify_mobile', to: "users#verify_mobile", as: "verify_mobile"

  get 'about' => 'pages#about'

  get 'faq' => 'pages#faq'

  get 'privacy_policy' => 'home#privacy_policy'

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'
  
  resources:quizzes

  resources:questions

  resources:options

  resources:categories

  resources:submissions

  get 'signup', to: 'users#new'

  resources:users, except:[:new]

  post '/purchase' => 'quizzes#update_payment'

  # get 'quizz/update_payment' => 'quizzes#update_payment' 

  get 'result' => 'quizzes#result' 

  get 'question/edit' => 'quizzes#editQuestion'

  get 'option/edit' => 'quizzes#editOption'

  get 'editPassword' => 'users#editPassword'

  post 'editPassword' => 'users#updatePassword'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  mount SimpleDiscussion::Engine => "/forum"
  mount Ckeditor::Engine => '/ckeditor'
  
  resources :blogs
  get 'tags/:tag', to: 'blogs#index', as: :tag
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :blogs do
    resources :comments
  end

  resources :comments do
    resources :comments
  end
  
  get '/draft' , to: 'blogs#draft'

  get '/my_blogs' , to: 'blogs#my_blogs'

  get '/users_show' , to: 'blogs#users_show'


  get 'autocomplete_blog_title', to: 'blogs#autocomplete_blog_title'
  get 'autocomplete_blog_content', to: 'blogs#autocomplete_blog_content'
  
  resources :blogs, only: :index do
    member do
      post 'update_blog_status', to: "blogs#update_blog_status"
      post 'toggle_favorite', to: "blogs#toggle_favorite"
    end
  end

  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end

  authenticate :user, lambda { |u| u.admin == true } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

end
