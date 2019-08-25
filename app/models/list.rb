class List < ApplicationRecord
    validates :name ,presence: {message: "Você não pode criar listas sem nome"}
    validates :name , uniqueness: { message: "Você não pode criar duas listas com nomes iguais",scope: :user_id }
    belongs_to :user
    
    has_many :recipe_lists
    has_many :recipes, through: :recipe_lists
end
