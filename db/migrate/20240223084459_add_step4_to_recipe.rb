class AddStep4ToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :step4, :text
  end
end
