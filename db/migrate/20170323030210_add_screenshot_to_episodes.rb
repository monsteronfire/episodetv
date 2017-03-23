class AddScreenshotToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :screenshot, :string
  end
end
