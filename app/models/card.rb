class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validate :change_string

  before_create :create_date

  scope :select_line_created_earlier, -> { where("review_date <= ?", Time.now).order('RANDOM()') }

  def check_word(user_text)
    original_text.casecmp(user_text.strip.downcase).zero?
  end

  def add_therd_days
    create_date
    save
  end

  private

  def change_string
    return unless original_text.casecmp(translated_text.strip.downcase).zero?

    errors.add(:original_text, "Original text can't be translated")
  end

  def create_date
    self.review_date = (Date.today + 3.days).to_s
  end
end
