class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.time :preparationtime
      t.time :cookingtime
      t.time :restingtime
      t.text :description
      t.text :step1
      t.text :step2
      t.text :step3

      t.timestamps
    end
  end
end
