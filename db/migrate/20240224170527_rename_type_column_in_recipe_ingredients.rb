class RenameTypeColumnInRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    rename_column :recipe_ingredients, :type, :ingredient_type
  end
end
