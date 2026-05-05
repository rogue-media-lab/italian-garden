class Cart
  attr_reader :items, :meal_deals

  def initialize(session)
    @session = session
    @session[:cart] ||= {}
    @session[:meal_deals] ||= []
    @items = @session[:cart]
    @meal_deals = @session[:meal_deals]
  end

  def add(menu_item_id, quantity = 1)
    id = menu_item_id.to_s
    @items[id] = (@items[id] || 0) + quantity
    save
  end

  def add_meal(deal_id, drink_item_id = nil)
    deal = MealDeal.find(deal_id)
    drink_id = drink_item_id || deal.default_drink_id
    @meal_deals << {
      "deal_id" => deal.id,
      "main_id" => deal.main_item_id,
      "side_id" => deal.default_side_id,
      "drink_id" => drink_id.to_i,
      "price" => deal.price.to_f
    }
    save
  end

  def remove_meal(index)
    @meal_deals.delete_at(index)
    save
  end

  def swap_drink(meal_index, new_drink_id)
    if @meal_deals[meal_index]
      @meal_deals[meal_index]["drink_id"] = new_drink_id.to_i
      save
    end
  end

  def remove(menu_item_id)
    @items.delete(menu_item_id.to_s)
    save
  end

  def update_quantity(menu_item_id, quantity)
    id = menu_item_id.to_s
    if quantity <= 0
      @items.delete(id)
    else
      @items[id] = quantity
    end
    save
  end

  def clear
    @items = {}
    @meal_deals = []
    @session[:cart] = @items
    @session[:meal_deals] = @meal_deals
  end

  def empty?
    @items.empty? && @meal_deals.empty?
  end

  def count
    @items.values.sum + @meal_deals.size
  end

  def menu_items
    all_ids = @items.keys.map(&:to_i) + @meal_deals.flat_map { |m| [ m["main_id"], m["side_id"], m["drink_id"] ] }
    MenuItem.where(id: all_ids.uniq).index_by(&:id)
  end

  def meal_deal_objects
    MealDeal.where(id: @meal_deals.map { |m| m["deal_id"] }).index_by(&:id)
  end

  def drink_options
    MenuItem.joins(:menu_category).where(menu_categories: { name: [ "Drinks", "Beverages" ] }).active.ordered
  end

  def total
    items = menu_items
    item_total = @items.sum { |id, qty| (items[id.to_i]&.price || 0) * qty }
    meal_total = @meal_deals.sum { |m| m["price"] }
    item_total + meal_total
  end

  def formatted_total
    "$#{'%.2f' % total}"
  end

  private

  def save
    @session[:cart] = @items
    @session[:meal_deals] = @meal_deals
  end
end
