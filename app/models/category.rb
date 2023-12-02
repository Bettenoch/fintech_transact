class Category < ApplicationRecord
  belongs_to :user
  has_many :category_purchases, dependent: :destroy
  has_many :purchases, through: :category_purchases, dependent: :destroy

  validates :name, presence: true
  validates :icon, presence: true
  validates :user_id, presence: true
end
