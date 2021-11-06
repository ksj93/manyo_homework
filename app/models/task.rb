class Task < ApplicationRecord
  validates :title, presence:true
  validates :content, presence:true
  validates :status, presence:true
  validates :deadline, presence:true
  validates :priority, presence:true

  # enum status: {未着手:0,着手:1,完了:2}
  enum priority: {低い:0,普通:1,高い:2}

  scope :search_title,->(title_search){where("title LIKE?","%#{title_search}%")}
  scope :search_status,->(status_search){where(status:"#{status_search}")}
  belongs_to:user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings, source: :label
end
