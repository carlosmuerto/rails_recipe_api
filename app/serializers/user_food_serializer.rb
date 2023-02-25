class UserFoodSerializer
  include FastJsonapi::ObjectSerializer
  attributes :food, :quantity
end
