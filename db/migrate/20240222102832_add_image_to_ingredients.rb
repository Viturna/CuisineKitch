class AddImageToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :image, :string
  end
end
