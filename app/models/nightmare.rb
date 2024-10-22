class Nightmare < ApplicationRecord
  belongs_to :user

  validates :description, presence: true
  validates :modified_description, presence: true
  validates :ending_type, presence: true
  validates :published, inclusion: { in: [true, false] }
end
