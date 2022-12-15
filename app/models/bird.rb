class Bird < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  has_and_belongs_to_many :trees
end
