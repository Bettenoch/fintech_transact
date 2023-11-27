class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :purchases, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true
end
