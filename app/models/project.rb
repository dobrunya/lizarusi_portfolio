class Project < ActiveRecord::Base
  has_many :html_pages
  accepts_nested_attributes_for :html_pages
end
