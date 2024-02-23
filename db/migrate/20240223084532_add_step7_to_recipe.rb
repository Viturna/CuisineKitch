class AddStep7ToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :step7, :text
  end
end
