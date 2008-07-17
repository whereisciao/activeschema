class CreateTableTrees < ActiveRecord::Migration
  def self.up
    create_table :table_trees do |t|
	t.column "tables_id", :integer
     t.column "relationship", :string
     t.column "table_name", :string
    end
  end

  def self.down
    drop_table :table_trees
  end
end
