class Purchase < ActiveRecord::Base

  belongs_to :reader, class_name: 'User'
  belongs_to :fiction
end
