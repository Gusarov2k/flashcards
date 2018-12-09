class UserValidate
  include ActiveModel::Model

  attr_accessor :user_text, :original_text

  validates :user_text, presence: true

  def initialize(params = {})
    params&.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end

  def check_word
    return unless original_text.casecmp? user_text

    errors.add(:user_text, "Original text can't be translated")
  end

  def persisted?
    false
  end
end
