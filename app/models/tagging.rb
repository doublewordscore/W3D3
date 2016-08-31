class Tagging < ActiveRecord::Base

  validates :tag_topic_id, :url_id, presence: true

  belongs_to :urls
    class_name: :ShortenedUrl,
    foreign_key: :url_id,
    primary_key: :id

  belongs_to :tag,
    class_name: :TagTopic,
    foreign_key: :tag_topic_id,
    primary_key: :id



end
