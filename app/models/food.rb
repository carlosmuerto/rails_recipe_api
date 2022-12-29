class Food < ApplicationRecord
  has_many :recipe_food
  has_many :recipes, through: :recipe_food, source: :recipe

  has_many :user_food
  has_many :users, through: :user_food, source: :user

  validates :name, presence: true
  validates :unit, presence: true, inclusion: { in: %w[g Kg lts ml piece] }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
