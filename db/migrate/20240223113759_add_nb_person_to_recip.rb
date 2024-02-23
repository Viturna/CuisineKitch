class AddNbPersonToRecip < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :nbperson, :integer
  end
end
