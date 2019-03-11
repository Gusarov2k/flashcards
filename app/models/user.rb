class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :packs
  belongs_to :current_pack, class_name: 'Pack', foreign_key: 'current_pack_id'

  validates :password, length: { minimum: 5 }, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :name, presence: true, length: { minimum: 2 }, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  validate :clear_words, if: proc { |a| a.name? && a.email? }

  scope :with_unreviewed_cards, lambda {
                                  joins(packs: :cards)
                                    .where('packs.id = users.current_pack_id AND cards.review_date <= ?',
                                           Time.zone.now).distinct
                                }

  private

  def clear_words
    self.name = name.mb_chars.downcase.strip
    self.email = email.downcase.strip
  end
end
