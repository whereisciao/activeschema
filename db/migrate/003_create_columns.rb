class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
	t.column "name", :string
	t.column "column_type", :string
	t.column "null_ind", :boolean
	t.column "code_value", :integer
	t.column "description", :text
	t.column "tables_id", :integer
	t.column "seq", :integer
    end
  end

  def self.down
    drop_table :columns
  end
end
