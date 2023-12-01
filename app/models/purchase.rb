class Purchase < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :category_purchases, dependent: :destroy
  has_many :categories, through: :category_purchases, dependent: :destroy

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :author_id, presence: true
end
