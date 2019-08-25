class RecipeList < ApplicationRecord
  belongs_to :list
  belongs_to :recipe

  validates :list, uniqueness: {scope: :recipe}
end
