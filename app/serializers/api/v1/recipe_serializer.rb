class Api::V1::RecipeSerializer < ActiveModel::Serializer
  attributes(*Recipe.attribute_names.map(&:to_sym) << :recipe_details)

  def recipe_details
    object.recipe_details.map do |recipe|
      Api::V1::RecipeDetailSerializer.new(recipe, scope: scope, root: false, event: object)
    end
  end
end