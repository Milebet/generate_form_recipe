class RecipePolicy < ApplicationPolicy

	def my_recipes?
		return false if !doctor.present?
		return true if record.first.doctor.id == doctor.id
	end

	def show?
		return false if !doctor.present?
		return true if doctor.present? && record.doctor.id == doctor.id
	end

	def new?
		return false if !doctor.present?
		return true if doctor.present?
	end

	def create?
		return false if !doctor.present?
		return true if doctor.present? && record.doctor.id == doctor.id
	end
end