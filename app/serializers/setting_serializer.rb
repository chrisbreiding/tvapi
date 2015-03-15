# == Schema Information
#
# Table name: settings
#
#  id           :integer          not null, primary key
#  last_updated :datetime
#

class SettingSerializer < ActiveModel::Serializer
  attributes :id, :last_updated
end
