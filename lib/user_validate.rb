class UserValidate
  include ActiveModel::Model

  attr_accessor :user_text, :original_text

  validates :user_text, presence: true

  def initialize(params = {})
    params&.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end

  def persisted?
    false
  end
end
