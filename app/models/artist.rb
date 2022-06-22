class Artist < ApplicationRecord
  has_many :records, dependent: :destroy

  validates :name, presence: true
  # belongs_to :user
end
