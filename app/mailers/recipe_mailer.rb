class RecipeMailer < ApplicationMailer

	def welcome_doctor(resource,generated_password)
		@resource = resource
		@generated_password = generated_password
		mail(to: resource.email, subject: 'Bienvenido a Medline Recetas')
	end

	def new_recipe(recipe)
		@recipe = recipe 
		@doctor = recipe.doctor 
		@medicines = recipe.recipe_details
		mail(to: ["milebet.tacuri@gmail.com","christian24091992@gmail.com"], subject: "Se ha generado una nueva receta")
	end
end
