class DropCategoriesRecipes < ActiveRecord::Migration[7.1]
  def change
    drop_table :categories_recipes
  end
end
