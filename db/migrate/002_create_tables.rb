class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :tables do |t|
    	t.column "name", :string
    	t.column "models_id", :integer
    	t.column "description", :string
    	t.column "table_type", :string
    end
  end

  def self.down
    drop_table :tables
  end
end
