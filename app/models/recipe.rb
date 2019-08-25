class Recipe < ApplicationRecord
  has_one_attached :recipe_img

  belongs_to :recipe_type
  belongs_to :user
  
  has_many :recipe_lists
  has_many :lists, through: :recipe_lists

  validates :title,:cuisine,:difficulty,:cook_time,:ingredients,:cook_method, presence: true

  def cook_time_min
    "#{cook_time} minutos"
  end
end
