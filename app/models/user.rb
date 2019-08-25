class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes
  has_many :lists

  def recipe_owner?(recipe)
    if recipe.nil?
      return false
    end
    self == recipe.user
  end
end
