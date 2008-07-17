class Table < ActiveRecord::Base
	belongs_to :model
	has_many :columns
	
end
