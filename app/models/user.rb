# == Schema Information
#
# Table name: users
#
#  id        :integer          not null, primary key
#  username  :string
#  api_key   :string
#  view_link :string
#

class User < ActiveRecord::Base
  has_many :viewerships, dependent: :destroy
  has_many :shows, through: :viewerships
end
