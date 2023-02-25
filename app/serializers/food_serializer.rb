class FoodSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :unit, :price_per_unit
end
