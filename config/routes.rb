Dyskretna::Application.routes.draw do

  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations"}

  mount API::Base => '/api'

  get 'spa' => 'spa#index'
  resources :subjects do
    resources :card_categories do
      collection do
        get 'all_cards'
      end
      resources :cards do
        collection do
          get 'start'
          get 'end'
        end
        member do
          get 'correct_answer'
          get 'wrong_answer'
        end
      end
    end
    resources :categories do
      resources :lists do
        resources :tasks do
          resources :solutions
            member do
              get 'im_done'
              get 'im_sure_done'
              get 'im_done_cancel'
              get 'too_hard'
              get 'too_hard_cancel'
            end
        end
      end
    end
  end

  namespace :user do
    resources :subjects do
      resources :no_progresses
      resources :progresses
      resources :card_categories do
        resources :cards
      end
      resources :categories do
        resources :lists do
          resources :tasks do
            resources :solutions
          end
        end
      end
    end
    get '/' => "user#index"
  end

  root 'subjects#index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
