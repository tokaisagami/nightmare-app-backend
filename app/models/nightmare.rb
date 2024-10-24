class Nightmare < ApplicationRecord
  belongs_to :user

  enum ending_category: { happy_end: 0, unexpected_end: 1, bad_end: 2 }

  validates :description, presence: true
  validates :modified_description, presence: true
  validates :ending_category, presence: true
  validates :published, inclusion: { in: [true, false] }
end
