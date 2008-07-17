# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 5) do

  create_table "columns", :force => true do |t|
    t.column "name",        :string
    t.column "column_type", :string
    t.column "null_ind",    :boolean
    t.column "code_value",  :integer
    t.column "description", :text
    t.column "tables_id",   :integer
    t.column "seq",         :integer
  end

  create_table "index_series", :force => true do |t|
    t.column "tables_id",   :integer
    t.column "series",      :integer
    t.column "seq",         :integer
    t.column "column_name", :string
  end

  create_table "models", :force => true do |t|
    t.column "name", :string
  end

  create_table "table_trees", :force => true do |t|
    t.column "tables_id",    :integer
    t.column "relationship", :string
    t.column "table_name",   :string
  end

  create_table "tables", :force => true do |t|
    t.column "name",        :string
    t.column "models_id",   :integer
    t.column "description", :string
    t.column "table_type",  :string
  end

end
