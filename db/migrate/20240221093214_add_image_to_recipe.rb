class AddImageToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :image, :text
  end
end
