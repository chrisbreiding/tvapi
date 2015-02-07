# == Schema Information
#
# Table name: shows
#
#  id           :integer          not null, primary key
#  display_name :string
#  search_name  :string
#  file_name    :string
#  source_id    :string
#

class Show < ActiveRecord::Base
  validates_presence_of :display_name, :search_name, :file_name, :source_id
  validates_uniqueness_of :source_id
  has_many :episodes
end
