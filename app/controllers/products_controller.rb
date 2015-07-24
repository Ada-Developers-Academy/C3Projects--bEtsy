class ProductsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update]

  def index
    @products = Product.active
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.create(create_params[:product])
    @product.user_id = session[:user_id]

    if @product.save
        redirect_to dashboard_path(session[:user_id])
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
    if session[:user_id] != @product.user_id
      redirect_to product_path(@product)
    end
  end

  def update
    @product = Product.find(params[:id])
    @product.update(create_params[:product])

    redirect_to dashboard_path(session[:user_id])
  end

  private

  def create_params
    params.permit(product: [:name, :description, :price, :stock, :photo_url, :user_id, :status, {:category_ids => [] }])

  end
end
