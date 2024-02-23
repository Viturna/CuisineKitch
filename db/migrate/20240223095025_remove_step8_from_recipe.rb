class RemoveStep8FromRecipe < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :step8, :text
  end
end
