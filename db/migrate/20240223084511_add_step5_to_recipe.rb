class AddStep5ToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :step5, :text
  end
end
