class CreateBirdsAndTrees < ActiveRecord::Migration[7.0]
  def change
    create_table :birds_trees, id: false do |t|
      t.belongs_to :bird
      t.belongs_to :tree
    end
  end
end
