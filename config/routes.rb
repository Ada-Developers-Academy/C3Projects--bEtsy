Rails.application.routes.draw do
  root "welcome#index"

  resources :categories, except: :destroy
  resources :sellers, only: [:index, :show]

  get 'products', to: 'products#index'
  get 'products/:id', to: 'products#show', as: 'product'

  scope :cart do
    get "/", to: "orders#cart", as: "cart"
    get "checkout", to: "orders#checkout"
    post "checkout", to: "orders#verify"
    get "receipt", to: "orders#receipt"
  end

  # adding an item to the cart
  post "/products/:id/add", to: "products#add_to_cart", as: "add_item"

  # adjusting the quantity of an item in the cart
  patch "/cart/item/:id/more" => "order_items#more", as: "more_item"
  patch "/cart/item/:id/less" => "order_items#less", as: "less_item"

  # removing an item from the cart
  delete "/cart/item/:id" => "order_items#destroy", as: "kill_item"
end
