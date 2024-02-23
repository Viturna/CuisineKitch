class AddStep6ToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :step6, :text
  end
end
