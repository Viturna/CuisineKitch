class AddStep9ToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :step9, :text
  end
end
