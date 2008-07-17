class TableTrees < ActiveRecord::Base

     def self.find_parents(tables_id)
          return_array = []
          
          return_array = self.find(:all,
                           :conditions => ["tables_id = ? and relationship = 'PARENT'", tables_id],
                           :order => "table_name")
          
          if(return_array.length == 0)
               return_array << self.blank_record
          end
          return return_array

     
     end
     
     def self.find_children(tables_id)
          return_array = []
          
          return_array = self.find(:all,
                           :conditions => ["tables_id = ? and relationship = 'CHILD'", tables_id],
                           :order => "table_name")

          if(return_array.length == 0)
               return_array << self.blank_record
          end
          return return_array
     
     end


     def self.blank_record
          return self.new(:id => -1,
                          :tables_id => -1,
                          :relationship => "NONE",
                          :table_name => "NONE")
     end
end