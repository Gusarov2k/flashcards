class UserValidate
  include ActiveModel::Model

  attr_accessor :user_text, :original_text

  validates :user_text, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
