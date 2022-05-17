Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 root to: 'public/homes#top'
 get 'about' =>'public/homes#about'

  scope module: :public do
    resources :addresses
    resources :cart_items
    resources :items
    #get "/customers/mypage" => "customers#show"
    #get "/customers/edit" => "customers#edit"
    resources :customers #, except: [:show]
    resources :items
    resources :orders

  end

end
