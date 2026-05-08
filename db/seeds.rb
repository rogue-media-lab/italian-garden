# Create admin user
admin = User.find_or_create_by!(email: "admin@italiangarden.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
end
puts "Admin user: #{admin.email}"

# Menu Categories
categories = {
  "Italian Dinners" => 1,
  "Hot Oven Subs" => 2,
  "Wings & Sides" => 3,
  "Salads" => 4,
  "Desserts" => 5,
  "Drinks" => 6
}

cat_records = {}
categories.each_with_index do |(name, sort_order), i|
  cat_records[name] = MenuCategory.find_or_create_by!(name: name) do |c|
    c.sort_order = sort_order
    c.active = true
  end
end
puts "Menu categories: #{MenuCategory.count}"

# Italian Dinners
italian_dinners = [
  { name: "Spaghetti with Meat Sauce", description: "Classic spaghetti topped with our rich, slow-simmered meat sauce.", price: 10.99 },
  { name: "Spaghetti with Meatballs", description: "Spaghetti with house-made meatballs and marinara.", price: 11.99 },
  { name: "Spaghetti with Mushrooms", description: "Spaghetti tossed with sautéed mushrooms in marinara.", price: 10.99 },
  { name: "Chicken Fettuccine Alfredo", description: "Creamy, rich Alfredo sauce over fettuccine with grilled chicken.", price: 13.99 },
  { name: "Mushroom Alfredo", description: "Fettuccine in creamy Alfredo with sautéed mushrooms.", price: 12.99 },
  { name: "Oven Baked Spaghetti", description: "Spaghetti baked with melted cheese until golden and bubbly.", price: 11.99 },
  { name: "Manicotti", description: "Pasta tubes stuffed with ricotta, baked in marinara with mozzarella.", price: 12.99 },
  { name: "Cheese Ravioli", description: "Cheese-filled ravioli in your choice of marinara or Alfredo.", price: 11.99 },
  { name: "Homemade Lasagna", description: "Layers of pasta, meat sauce, ricotta, and mozzarella — baked to perfection.", price: 12.99 },
  { name: "Chicken Parmigiana", description: "Breaded chicken breast baked with marinara and melted mozzarella.", price: 13.99 },
  { name: "Eggplant Parmigiana", description: "Breaded eggplant baked with marinara and melted mozzarella.", price: 12.99 },
  { name: "Veal Parmigiana", description: "Tender breaded veal baked with marinara and mozzarella.", price: 14.99 }
]

italian_dinners.each do |item|
  MenuItem.find_or_create_by!(name: item[:name], menu_category: cat_records["Italian Dinners"]) do |m|
    m.description = item[:description]
    m.price = item[:price]
    m.active = true
  end
end

# Hot Oven Subs
subs = [
  { name: "Cheese Steak", description: "Shaved steak with melted cheese on a toasted sub roll.", price: 9.99 },
  { name: "Chicken Parmigiana Sub", description: "Breaded chicken, marinara, and melted mozzarella.", price: 10.99 },
  { name: "Meatball Sub", description: "House-made meatballs in marinara with melted cheese.", price: 9.99 },
  { name: "Pizza Sub", description: "Pepperoni, sauce, and mozzarella on a toasted roll.", price: 9.49 },
  { name: "Turkey Sub", description: "Sliced turkey with your choice of toppings.", price: 9.49 },
  { name: "Steak Combo", description: "Shaved steak with peppers, onions, mushrooms, and cheese.", price: 10.99 },
  { name: "Veal Parmigiana Sub", description: "Breaded veal with marinara and melted mozzarella.", price: 10.99 },
  { name: "Eggplant Parmigiana Sub", description: "Breaded eggplant with marinara and melted mozzarella.", price: 10.99 },
  { name: "Chicken Strip Sub", description: "Crispy chicken strips with lettuce, tomato, and mayo.", price: 9.99 },
  { name: "Roast Beef Sub", description: "Sliced roast beef with your choice of toppings.", price: 9.99 }
]

subs.each do |item|
  MenuItem.find_or_create_by!(name: item[:name], menu_category: cat_records["Hot Oven Subs"]) do |m|
    m.description = item[:description]
    m.price = item[:price]
    m.active = true
  end
end

# Wings & Sides
sides = [
  { name: "Buffalo Wings", description: "Crispy, bold, and generously sized — our signature wings.", price: 8.99 },
  { name: "Garlic Bread", description: "Toasted bread with garlic butter.", price: 3.49 },
  { name: "Cheese Bread", description: "Toasted bread with melted mozzarella and garlic butter.", price: 5.49 },
  { name: "Greek Fries", description: "Crispy fries topped with feta and seasoning.", price: 4.99 },
  { name: "Meatballs (3)", description: "Three house-made meatballs in marinara.", price: 4.99 },
  { name: "Side Salad", description: "Fresh greens with your choice of dressing.", price: 4.49 },
  { name: "Pita Bread", description: "Warm, soft pita bread.", price: 2.49 },
  { name: "Cheese Bread", description: "Toasted with mozzarella and garlic butter.", price: 5.49 },
  { name: "French Fries", description: "Crispy golden fries.", price: 3.99 }
]

sides.each do |item|
  MenuItem.find_or_create_by!(name: item[:name], menu_category: cat_records["Wings & Sides"]) do |m|
    m.description = item[:description]
    m.price = item[:price]
    m.active = true
  end
end

# Salads
salads = [
  { name: "Tossed Salad", description: "Fresh greens, tomato, cucumber, and your choice of dressing.", price: 5.99 },
  { name: "Greek Salad", description: "Romaine, feta, olives, tomatoes, onion, and Greek dressing.", price: 7.99 },
  { name: "Grilled Chicken Salad", description: "Grilled chicken over fresh greens with your choice of dressing.", price: 9.99 },
  { name: "Antipasto", description: "Mixed greens, ham, salami, provolone, olives, and peppers.", price: 8.99 },
  { name: "House Special Salad", description: "Our signature salad with all the fixings.", price: 8.99 }
]

salads.each do |item|
  MenuItem.find_or_create_by!(name: item[:name], menu_category: cat_records["Salads"]) do |m|
    m.description = item[:description]
    m.price = item[:price]
    m.active = true
  end
end

# Desserts
desserts = [
  { name: "Turtle Cheesecake", description: "Rich cheesecake topped with caramel, chocolate, and pecans.", price: 5.99 },
  { name: "Strawberry Cheesecake", description: "Classic cheesecake with strawberry topping.", price: 5.99 },
  { name: "Cheesecake", description: "New York style cheesecake — creamy and classic.", price: 4.99 },
  { name: "Baklava", description: "Layers of phyllo, nuts, and honey syrup.", price: 3.99 }
]

desserts.each do |item|
  MenuItem.find_or_create_by!(name: item[:name], menu_category: cat_records["Desserts"]) do |m|
    m.description = item[:description]
    m.price = item[:price]
    m.active = true
  end
end

# Drinks
drinks = [
  { name: "Coke", description: "", price: 2.49 },
  { name: "Sprite", description: "", price: 2.49 },
  { name: "Dr. Pepper", description: "", price: 2.49 },
  { name: "Iced Tea", description: "", price: 2.49 },
  { name: "Hi-C Pink Lemonade", description: "", price: 2.49 },
  { name: "Wild Cherry", description: "", price: 2.49 }
]

drinks.each do |item|
  MenuItem.find_or_create_by!(name: item[:name], menu_category: cat_records["Drinks"]) do |m|
    m.description = item[:description]
    m.price = item[:price]
    m.active = true
  end
end

puts "Menu items: #{MenuItem.count}"

# Hours
hours_data = [
  { day_of_week: 0, open_time: "12:00", close_time: "21:00", closed: false },  # Sunday
  { day_of_week: 1, open_time: "10:30", close_time: "21:00", closed: false },  # Monday
  { day_of_week: 2, open_time: "10:30", close_time: "21:00", closed: false },  # Tuesday
  { day_of_week: 3, open_time: "10:30", close_time: "21:00", closed: false },  # Wednesday
  { day_of_week: 4, open_time: "10:30", close_time: "21:00", closed: false },  # Thursday
  { day_of_week: 5, open_time: "10:30", close_time: "22:00", closed: false },  # Friday
  { day_of_week: 6, open_time: "10:30", close_time: "22:00", closed: false }   # Saturday
]

hours_data.each do |h|
  Hour.find_or_create_by!(day_of_week: h[:day_of_week]) do |hour|
    hour.open_time = h[:open_time]
    hour.close_time = h[:close_time]
    hour.closed = h[:closed]
  end
end
puts "Hours: #{Hour.count}"

# Testimonials
testimonials = [
  { customer_name: "Donna G.", quote: "The chicken fettuccine Alfredo is the best I've ever had. Creamy, rich, and the portions are huge. This place feels like eating at a friend's house.", stars: 5, featured: true },
  { customer_name: "Will B.", quote: "Best wings in York, hands down. Crispy, bold flavor, and they don't skimp on the size. The pizza is incredible too — perfect crust every time.", stars: 5, featured: true },
  { customer_name: "Angel M.", quote: "Family-owned and you can feel it. The staff treats you like family, the food is always on point, and the prices are very fair for what you get.", stars: 5, featured: true },
  { customer_name: "Sekari F.", quote: "The gyro plates are amazing — flavorful and perfectly cooked. Great leftovers too! Always a solid meal.", stars: 5, featured: false },
  { customer_name: "Lucky C.", quote: "Cozy atmosphere, friendly staff, and the baked spaghetti with meatballs is comfort food at its finest. We come here every week.", stars: 5, featured: false }
]

testimonials.each do |t|
  Testimonial.find_or_create_by!(customer_name: t[:customer_name]) do |test|
    test.quote = t[:quote]
    test.stars = t[:stars]
    test.featured = t[:featured]
    test.active = true
  end
end
puts "Testimonials: #{Testimonial.count}"

# Site Settings
settings = {
  "hero_heading" => "Authentic Italian Comfort, Made With Heart",
  "hero_subheading" => "Creamy fettuccine Alfredo. Crispy golden wings. Handcrafted pizza with the perfect crust. Generous portions, warm smiles, and flavors that keep you coming back.",
  "about_heading" => "A Family Place in the Heart of York",
  "about_body" => "Italian Garden Restaurant is a family-owned gem on East Liberty Street — a place where generous portions, warm smiles, and real Italian-American cooking come together. From our crispy wings and handcrafted pizza to creamy fettuccine Alfredo and homemade lasagna, every dish is made with the same care we'd put on our own family table.",
  "address" => "502 E Liberty St, York, SC 29745",
  "phone" => "(803) 628-0270",
  "email" => "italiangardenrestaurant.shop@gmail.com"
}

settings.each do |key, value|
  SiteSetting.set(key, value)
end
puts "Site settings: #{SiteSetting.count}"

# Attach photos to featured items
photos = {
  "Chicken Parmigiana" => "chicken-parm.webp",
  "Special Pizza" => "special-pitza.webp",
  "Gyro Plate" => "gyro.webp"
}

photos.each do |item_name, filename|
  item = MenuItem.find_by(name: item_name)
  next unless item
  path = Rails.root.join("app/assets/images", filename)
  next unless File.exist?(path)
  item.photo.attach(
    io: File.open(path),
    filename: filename,
    content_type: "image/#{filename.split('.').last}"
  )
  puts "Attached photo to: #{item_name}"
end

puts "\nSeed complete!"
