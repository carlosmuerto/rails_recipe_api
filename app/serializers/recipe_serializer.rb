class RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :public, :preparation_time, :cooking_time
  attribute :author do |recipe|
    UserSerializer.new(recipe.author).serializable_hash[:data][:attributes]
  end
  attribute :foods do |recipe|
    recipe.recipe_food.map do |rc_fd|
      {
        food: FoodSerializer.new(rc_fd.food).serializable_hash[:data][:attributes],
        quantity: rc_fd.quantity
      }
    end
  end
end
