class OrderItemsController < ApplicationController


  def index
    @order_items = OrderItem.all
  end

  def new
    @item = OrderItem.new
    @product = Product.find(params[:product_id])
  end

  def create
    @item = OrderItem.create(create_params[:order_item])

    if session[:order_id]
      @item.order_id = session[:order_id]
      render 'new'
    else
      new_order
    end
  end

  def destroy
    @item = OrderItem.find(params[:id])
    @item.destroy

    redirect_to cart_path
  end

  private

  def create_params
    params.permit(order_item: [:quantity, :order_id, :product_id])
  end

end


