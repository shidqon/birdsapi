class Tree < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :species, presence: true, length: { maximum: 255 }
  validates :height, presence: true, numericality: { greater_than: 0 }
end
