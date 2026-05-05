module Admin
  class MenuItemsController < BaseController
    before_action :set_item, only: [ :edit, :update, :destroy ]

    def index
      @items = MenuItem.includes(:menu_category).ordered
      @items = @items.where(menu_category_id: params[:category]) if params[:category].present?
      @items = @items.where(featured: true) if params[:featured] == "1"
    end

    def new
      @item = MenuItem.new
      @categories = MenuCategory.ordered
    end

    def create
      @item = MenuItem.new(item_params)
      if @item.save
        redirect_to admin_menu_items_path, notice: "Menu item created."
      else
        @categories = MenuCategory.ordered
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @categories = MenuCategory.ordered
    end

    def update
      if @item.update(item_params)
        redirect_to admin_menu_items_path, notice: "Menu item updated."
      else
        @categories = MenuCategory.ordered
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @item.destroy
      redirect_to admin_menu_items_path, notice: "Menu item deleted."
    end

    private

    def set_item
      @item = MenuItem.find(params[:id])
    end

    def item_params
      params.require(:menu_item).permit(:name, :description, :price, :featured, :active, :menu_category_id, :photo)
    end
  end
end
