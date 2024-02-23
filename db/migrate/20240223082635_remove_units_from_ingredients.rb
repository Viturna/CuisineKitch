class RemoveUnitsFromIngredients < ActiveRecord::Migration[7.1]
  def change
    remove_column :ingredients, :units, :string
  end
end
