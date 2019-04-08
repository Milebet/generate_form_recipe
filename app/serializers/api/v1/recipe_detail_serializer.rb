class Api::V1::RecipeDetailSerializer < ActiveModel::Serializer
  attributes(*RecipeDetail.attribute_names.map(&:to_sym))
end