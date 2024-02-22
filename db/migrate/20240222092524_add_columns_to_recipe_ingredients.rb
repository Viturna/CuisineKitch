class AddColumnsToRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipe_ingredients, :recipe, null: false, foreign_key: true
    add_reference :recipe_ingredients, :ingredient, null: false, foreign_key: true
  end
end
