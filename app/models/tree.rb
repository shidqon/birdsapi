class Tree < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :species, presence: true, length: { maximum: 255 }
  validates :height, presence: true, numericality: { greater_than: 0 }
  has_and_belongs_to_many :birds
  validates_associated :birds
end
