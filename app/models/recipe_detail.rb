class RecipeDetail < ApplicationRecord
	belongs_to :recipe
	validates :medicine_name, :quantity, :indications, :presence => true
end
