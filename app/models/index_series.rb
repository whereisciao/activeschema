class IndexSeries < ActiveRecord::Base

     def self.find_index_for(tables_id)
          return self.find(:all,
                           :conditions => ["tables_id = ?", tables_id],
                           :order => "series desc, seq")
     end

end
