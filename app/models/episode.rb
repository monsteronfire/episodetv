class Episode < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :description, presence: true
  mount_uploader :screenshot, ScreenshotUploader
  acts_as_taggable
  searchkick word_start: [:title], suggest: [:title]

  def search_data
    {
      title: title,
      description: description,
      tag_list: tag_list,
    }
  end
end
