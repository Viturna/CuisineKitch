class AddDifficultyToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :difficulty, :string
  end
end
