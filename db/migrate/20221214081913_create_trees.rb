class CreateTrees < ActiveRecord::Migration[7.0]
  def change
    create_table :trees do |t|
      t.string :name
      t.integer :height
      t.string :species

      t.timestamps
    end
  end
end
