class Episode < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :description, presence: true
end
