class AddUnitsToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :units, :string
  end
end
