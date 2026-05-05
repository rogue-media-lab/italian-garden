class PagesController < ApplicationController
  def home
    @featured_items = MenuItem.featured.active.includes(:menu_category).limit(3)
    @featured_deals = MealDeal.featured.active.includes(:main_item, :default_side, :default_drink, photo_attachment: :blob).limit(3)
    @categories = MenuCategory.active.ordered.includes(menu_items: { photo_attachment: :blob })
    @testimonials = Testimonial.featured.active.ordered.limit(3)
    @hours = Hour.ordered
    @hero_heading = SiteSetting.get("hero_heading")
    @hero_subheading = SiteSetting.get("hero_subheading")
    @about_heading = SiteSetting.get("about_heading")
    @about_body = SiteSetting.get("about_body")
    @address = SiteSetting.get("address")
    @phone = SiteSetting.get("phone")
    @email = SiteSetting.get("email")
    @storefront_image = "storefront.jpg"
    @google_reviews = GoogleReviewsService.fetch
    @drinks = MenuItem.joins(:menu_category).where(menu_categories: { name: [ "Drinks", "Beverages" ] }).active.ordered
  end

  def about
    @about_heading = SiteSetting.get("about_heading")
    @about_body = SiteSetting.get("about_body")
    @storefront_image = "storefront.jpg"
  end
end
