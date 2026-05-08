module FoodPhotos
  PHOTOS = {
    "Chicken Parmigiana" => "chicken-parm.webp",
    "Special Pizza" => "special-pitza.webp",
    "Gyro Plate" => "gyro.webp"
  }.freeze

  def self.for(item_name)
    PHOTOS[item_name]
  end
end
