class Board < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  has_many :comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  belongs_to :user
  mount_uploader :board_image, BoardImageUploader
end
