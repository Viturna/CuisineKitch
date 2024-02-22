class CreateJoinTableRecipeCategory < ActiveRecord::Migration[7.1]
  def change
    create_join_table :recipes, :categories do |t|
      t.index [:recipe_id, :category_id]
      t.timestamps
    end
  end
end
