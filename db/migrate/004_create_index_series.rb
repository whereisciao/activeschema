class CreateIndexSeries < ActiveRecord::Migration
  def self.up
    create_table :index_series do |t|
     t.column "tables_id", :integer
     t.column "series", :integer
     t.column "seq", :integer
     t.column "column_name", :string
    end
  end

  def self.down
    drop_table :index_series
  end
end
