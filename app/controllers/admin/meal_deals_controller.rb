module Admin
  class MealDealsController < BaseController
    before_action :set_deal, only: [ :edit, :update, :destroy ]

    def index
      @deals = MealDeal.ordered.includes(:main_item, :default_side, :default_drink)
    end

    def new
      @deal = MealDeal.new
      load_options
    end

    def create
      @deal = MealDeal.new(deal_params)
      if @deal.save
        redirect_to admin_meal_deals_path, notice: "Meal deal created."
      else
        load_options
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      load_options
    end

    def update
      if @deal.update(deal_params)
        redirect_to admin_meal_deals_path, notice: "Meal deal updated."
      else
        load_options
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @deal.destroy
      redirect_to admin_meal_deals_path, notice: "Meal deal deleted."
    end

    private

    def set_deal
      @deal = MealDeal.find(params[:id])
    end

    def deal_params
      params.require(:meal_deal).permit(:name, :description, :price, :featured, :active, :main_item_id, :default_side_id, :default_drink_id, :photo)
    end

    def load_options
      @main_items = MenuItem.active.ordered.includes(:menu_category)
      @sides = MenuItem.joins(:menu_category).where(menu_categories: { name: [ "Wings & Sides", "Side Orders" ] }).active.ordered
      @drinks = MenuItem.joins(:menu_category).where(menu_categories: { name: [ "Drinks", "Beverages" ] }).active.ordered
    end
  end
end
