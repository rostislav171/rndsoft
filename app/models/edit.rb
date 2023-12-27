class Edit < ApplicationRecord
  has_many :edits, class_name: 'Edit'
end
