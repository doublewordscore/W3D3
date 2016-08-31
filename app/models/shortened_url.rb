require 'byebug'

class ShortenedUrl < ActiveRecord::Base
  require 'securerandom'

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, length: {maximum: 1024}
  validate :prevent_sixth

  belongs_to :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  has_many :visits,
    class_name: :Visit,
    foreign_key: :short_url_id,
    primary_key: :id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitors

  has_one :tagging,
    class_name: :Tagging,
    foreign_key: :tag_topic_id,
    primary_key: :id

  has_one :tag,
    through: :tagging,
    source: :tag


  def self.random_code
    until false
      random_string = SecureRandom.urlsafe_base64
      return random_string unless ShortenedUrl.exists?(short_url: random_string)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create(long_url: long_url, short_url: ShortenedUrl.random_code, user_id: user.id)
  end

  def num_clicks
    Visit.select(:user_id).where(short_url_id: id).count
  end
  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    ten_minutes_ago = 10.minutes.ago
    # Visit.select(:user_id).distinct.where(short_url_id: id).where(10.minutes.ago >= visits.created_at).count
    Visit.select(:user_id).distinct.where(short_url_id: id).where("created_at >= ?", ten_minutes_ago).count
  end

  def prevent_sixth
    fifth_url = User.find_by_id(user_id).fifth_url
    is_not_premium = User.find_by_id(user_id).is_not_premium?
    if fifth_url.created_at > 1.minutes.ago && is_not_premium
       errors.add(:sixth_url, "cannot be created")
    end
  end


end
