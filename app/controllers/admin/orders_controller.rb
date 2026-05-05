module Admin
  class OrdersController < BaseController
    before_action :set_order, only: [ :update, :destroy ]

    def index
      @orders = Order.ordered.includes(order_items: :menu_item)
      @orders = @orders.where(status: params[:status]) if params[:status].present?
    end

    def update
      if @order.update(order_params)
        redirect_to admin_orders_path, notice: "Order #{@order.status}."
      else
        redirect_to admin_orders_path, alert: "Could not update order."
      end
    end

    def destroy
      @order.destroy
      redirect_to admin_orders_path, notice: "Order deleted."
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:status)
    end
  end
end
