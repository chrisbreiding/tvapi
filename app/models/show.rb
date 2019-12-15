# == Schema Information
#
# Table name: shows
#
#  id           :integer          not null, primary key
#  display_name :string
#  search_name  :string
#  file_name    :string
#  source_id    :string
#  poster       :string
#

class Show < ActiveRecord::Base
  validates_presence_of :display_name, :search_name, :file_name, :source_id
  validates_uniqueness_of :source_id

  has_many :episodes, dependent: :destroy
  has_many :viewerships, dependent: :destroy
  has_many :users, through: :viewerships

  def self.existing(source_id)
    self.where(source_id: source_id).first
  end
end
