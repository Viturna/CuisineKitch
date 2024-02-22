class AddPriceToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :price, :string
  end
end
