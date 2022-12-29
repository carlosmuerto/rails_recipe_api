class Recipe < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :recipe_food
  has_many :foods, through: :recipe_food, source: :food

  validates :foods, length: { minimum: 1 }
  validates :name, presence: true
  validates :preparation_time_seconds, presence: true, numericality: { greater_than: 0 }
  validates :cooking_time_seconds, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
end
