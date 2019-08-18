class RecipeType < ApplicationRecord
    validates :name,presence: {message: "Tipo de receita não pode conter campos vazios"},uniqueness: {message: "Tipo de receita já existente"}
    has_many :recipes
end
