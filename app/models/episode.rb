class Episode < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :description, presence: true
  mount_uploader :screenshot, ScreenshotUploader
  acts_as_taggable
end
