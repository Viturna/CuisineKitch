class AddStep10ToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :step10, :text
  end
end
