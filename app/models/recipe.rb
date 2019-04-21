class Recipe < ApplicationRecord
	belongs_to :doctor
	has_many :recipe_details, inverse_of: :recipe

	accepts_nested_attributes_for :recipe_details,
		:allow_destroy => true,
	    :reject_if     => :all_blank

	validates :full_name, :email, :document_type, :document, :presence => true
end
