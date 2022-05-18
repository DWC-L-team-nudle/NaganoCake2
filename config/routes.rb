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
root to: 'homes#top'
resources :customers, only: [:index,:show,:edit,:update]
resources :items, except: [:destroy]
resources :genres, except: [:new, :show, :destroy]
resources :orders, only: [:index, :show]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 root to: 'public/homes#top'
 get 'about' =>'public/homes#about'


# 任意のURIへのルーティング変更は後日行います（大場）
# 退会ビューへのリンクは未実装です。コメントアウトを消すとエラーが出ます
  scope module: :public do
    resources :addresses
    #get "/customers/mypage" => "customers#show"
    #get "/customers/edit" => "customers#edit"
    resources :customers #, except: [:show]
    # 退会確認画面
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'comfirm' => 'orders#comfirm'
        get 'complete' => 'orders#complete'
      end
    end
    resources :cart_items, only: [:index, :create, :destroy, :update,] do
      collection do
        delete 'destroy_all' => 'cart_items#destroy_all'
      end
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end