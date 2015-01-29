# == Schema Information
#
# Table name: shows
#
#  id           :integer          not null, primary key
#  display_name :string
#  search_name  :string
#  file_name    :string
#  tvsource_id  :string
#

class Show < ActiveRecord::Base
  validates_presence_of :display_name, :search_name, :file_name, :tvsource_id
  validates_uniqueness_of :tvsource_id
end
