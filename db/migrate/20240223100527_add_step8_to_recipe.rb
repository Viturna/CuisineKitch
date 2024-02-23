class AddStep8ToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :step8, :text
  end
end
