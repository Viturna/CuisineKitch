class RenameTypeColumnInIngredients < ActiveRecord::Migration[6.0]
  def change
    rename_column :ingredients, :type, :ingredient_type
  end
end
