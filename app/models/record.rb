class Record < ApplicationRecord

  validates :title, :year, presence: true
  # belongs_to :artist
  belongs_to :user
end
