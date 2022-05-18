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

namespace :admin do
resources :customers, only: [:index,:show,:edit,:update]
end

 root to: 'public/homes#top'
 get 'about' =>'public/homes#about'

# 任意のURIへのルーティング変更は後日行います（大場）
  scope module: :public do
    resources :addresses
    resources :cart_items
    resources :items
    #get "/customers/mypage" => "customers#show"
    #get "/customers/edit" => "customers#edit"
    resources :customers #, except: [:show]
    # 退会確認画面
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    resources :items
    resources :orders
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end