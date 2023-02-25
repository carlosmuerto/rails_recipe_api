class UserFoodSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user, :food, :quantity
end
