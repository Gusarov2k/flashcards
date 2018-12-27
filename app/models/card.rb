class Card < ActiveRecord::Base
  belongs_to :user

  validates :original_text, :translated_text, presence: true
  validate :clear_words, if: proc { |a| a.original_text? && a.translated_text? }
  validate :change_string, if: proc { |a| a.original_text? && a.translated_text? }

  before_create :recheck_date

  scope :ready_for_review, -> { where("review_date <= ?", Time.now) }
  scope :random, -> { order('RANDOM()') }

  def check_word(user_text)
    original_text.casecmp(user_text.mb_chars.strip.downcase).zero?
  end

  def recheck_date
    self.review_date = (Date.today + 3.days).to_s
  end

  private

  def clear_words
    self.original_text = original_text.mb_chars.downcase.strip
    self.translated_text = translated_text.mb_chars.downcase.strip
  end

  def change_string
    return unless original_text.casecmp(translated_text).zero?

    errors.add(:original_text, 'Original text can\'t be translated')
  end
end
