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

class ShowSerializer < ActiveModel::Serializer
  attributes :id, :display_name, :search_name, :file_name, :source_id
  has_many :episodes
end
