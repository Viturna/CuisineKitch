class RemoveUnityFromRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipe_ingredients, :unity, :string
  end
end
