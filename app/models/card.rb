class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true

  validate :change_string

  before_create :create_date


  private

  def change_string
    if original_text == translated_text
      errors.add(:original_text, 'Оригинальный текст не может быть равен переведенному')
    end
  end

  def create_date
    self.review_date = (Date.today + 3.days).to_s
  end
end
