# == Schema Information
#
# Table name: viewerships
#
#  id      :integer          not null, primary key
#  user_id :integer
#  show_id :integer
#

class Viewership < ActiveRecord::Base
  belongs_to :show
  belongs_to :user
end
