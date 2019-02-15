class Card < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :pack

  validates :original_text, :translated_text, presence: true
  validates :pack_id, presence: true
  validate :clear_words, if: proc { |a| a.original_text? && a.translated_text? }
  validate :change_string, if: proc { |a| a.original_text? && a.translated_text? }

  before_create :set_review_date_as_now

  scope :ready_for_review, -> { where("review_date <= ?", Time.zone.now) }
  scope :random, -> { order('RANDOM()') }
  scope :all_cards, ->(packs) { where(pack_id: packs.pluck(:id)) }

  def check_word(user_text)
    original_text.casecmp(user_text.mb_chars.strip.downcase).zero?
  end

  def set_review_date_as_now
    self.review_date = Time.zone.now.to_s
  end

  def set_review_date_and_box
    hash = {  0 => [1, 12.hours],
              1 => [2, 3.days],
              2 => [3, 7.days],
              3 => [4, 14.days],
              4 => [5, 1.month],
              5 => [5, 1.month] }
    box_value, review_date = hash[box]
    self.box = box_value
    self.review_date = Time.zone.now + review_date
    save
  end

  def check_bad_guessing
    if guessing == 3
      self.box = 1
      self.guessing = 0
    else
      self.guessing += 1
    end
    save
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
