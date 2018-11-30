class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true

  validate :change_string

  def change_string
    if original_text == translated_text
      errors.add(:original_text, 'Оригинальный текст не может быть равен переведенному')
    end
  end
end
