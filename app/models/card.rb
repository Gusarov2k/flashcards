class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validate :change_string

  before_create :recheck_date

  scope :created_at_earlier, -> { where("review_date <= ?", Time.now) }
  scope :random, -> { order('RANDOM()') }

  def check_word(user_text)
    original_text.casecmp(user_text.strip.downcase).zero?
  end

  def recheck_date
    self.review_date = (Date.today + 3.days).to_s
  end

  private

  def change_string
    return unless original_text.casecmp(translated_text.strip.downcase).zero?

    errors.add(:original_text, "Original text can't be translated")
  end
end
