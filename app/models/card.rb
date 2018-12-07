class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validate :change_string

  # before_create :create_date

  scope :third_days_ago, -> { where("review_date <= ?", 3.days.ago) }

  private

  def change_string
    return unless original_text.casecmp? translated_text

    errors.add(:original_text, "Original text can't be translated")
  end

  def create_date
    self.review_date = (Date.today + 3.days).to_s
  end
end
