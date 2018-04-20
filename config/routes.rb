Rails.application.routes.draw do


  scope :module => 'buttercms' do
    get '/categories/:slug' => 'categories#show', :as => :buttercms_category
    get '/author/:slug' => 'authors#show', :as => :buttercms_author

    get '/blog/rss' => 'feeds#rss', :format => 'rss', :as => :buttercms_blog_rss
    get '/blog/atom' => 'feeds#atom', :format => 'atom', :as => :buttercms_blog_atom
    get '/blog/sitemap.xml' => 'feeds#sitemap', :format => 'xml', :as => :buttercms_blog_sitemap

    get '/blog(/page/:page)' => 'posts#index', :defaults => {:page => 1}, :as => :buttercms_blog
    get '/blog/:slug' => 'posts#show', :as => :buttercms_post
  end


  resources :practices, except: [:destroy]

  get 'auth/:provider/callback', to: 'users#calendar_auth'
  post 'stripe/create', to: 'stripe_accounts#create'
  post 'stripe/update', to: 'stripe_accounts#update', as: "stripe_update"

  mount StripeEvent::Engine => '/stripe'

  get 'blog', to: 'posts#index'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'days/check'
  get 'days/check_end'

  post 'sync_cal', to: "appointments#calendar_sync"

  get 'invitation/new'

  get 'invitation/create'

   get 'conversations/index'

   get 'conversations/create'

  get 'comments/index'

  get 'comments/new'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'marketplaces/index'

  get 'invoices/index'

  resources :appointment_settings

  get 'resources/index'

  get 'practices/booking_complete/:appointment_id', to: 'practices#booking_complete', as: "booking_complete"
  get '/messages', to: 'messages#index'
  get '/messages/new', to: "messages#new"
  resources :days
  resources :subscriptions
  resources :bank_accounts
  get 'conversations/reply', to: 'conversations#reply'
  resources :conversations, :defaults => { :format => :json } do
    resources :messages
  end
  get 'sessions/new'

  get 'connection', to: 'reminders#new'

  root 'static_pages#home'
  get 'privacy', to: 'static_pages#privacy'
  resources :users do
    resources :comments
    resources :profiles
    resources :todo_lists do
      resources :todo_items
    end
    member do
      get :patients, :doctors
    end
  end
  resources :appointments do
    resources :comments
  end
  resources :user_complaints
  get '/relationships/reconfirm', to: 'relationships#reconfirm_relationship'
  get '/relationships/confirm/', to: 'relationships#confirm_relationship'
  get '/relationships/add_patient/', to: 'relationships#confirm'
  get '/relationships/add_patient/(:relationship_token)', to: 'relationships#confirm'
  post '/relationships/patient_decision/', to: 'relationships#patient_decision'
  get '/days/check', to: 'days#check'
  get '/days/check_end', to: 'days#check_end'

  get '/users/check_billing/:doctor_id', to: 'users#check_billing', defaults: {format: :json}

  resource :calendar, only: [:show]
  resource :dashboard, only: [:show]
  resource :invoice, only: [:index]
  resources :relationships,       only: [:new,:create, :destroy, :update]
  get  '/signup/(:invitation_token)',  to: 'users#new'
  get  '/search/users',  to: 'users#search'
  post '/signup',  to: 'users#create'
  resources :leads, has_many: :inquiries
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :invitations, only: [:new, :create]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  get 'documents/' => 'documents#index'
  get 'documents/new' => 'documents#new', as: :new_document
  get 'documents/:id' => 'documents#show', as: :document
  post 'documents/' => 'documents#create'
  get 'documents/:id/edit' => 'documents#edit', as: :edit_document
  patch 'documents/:id' => 'documents#update'
  delete 'documents/:id' => 'documents#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
