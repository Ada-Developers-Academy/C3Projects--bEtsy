class OrdersController < ApplicationController
  before_action :set_order, only: [:cart, :checkout, :add_to_cart, :update, :receipt]
  before_action :set_product, only: [:add_to_cart]

  def cart; end

  def checkout; end

  def add_to_cart # OPTIMIZE: consider moving this elsewhere, i.e. ProductsController or OrderItemsController.
    order_item = OrderItem.new(product_id: @product.id, order_id: @order.id, quantity_ordered: 1)
    if order_item.save
      flash[:messages] = "The item has been added to your cart!"
    else
      flash[:errors] = order_item.errors
    end

    redirect_to product_path(@product)
  end

  def update
    @order.status = "paid" # OPTIMIZE: it might make sense to make these be model methods.
    if @order.update(checkout_params)
      redirect_to receipt_path
    else
      flash[:errors] = @order.errors
      @order.status = "pending"
      redirect_to checkout_path # TODO: might want to change this so that inputted data remains?
    end
  end

  def receipt
    if @order.status == "paid"
      render :receipt
      session[:order_id] = nil
    else
      redirect_to root_path
    end
  end

  private
    def checkout_params
      params.permit(order: [:buyer_name, :buyer_email, :buyer_address, :buyer_card_short, :buyer_card_expiration])[:order]
    end

    def set_order
      if session[:order_id] && Order.find_by(id: session[:order_id])
        @order = Order.find(session[:order_id])
      else
        @order = Order.create
        session[:order_id] = @order.id
      end
    end

    def set_product
      @product = Product.find(params[:id])
    end
end
