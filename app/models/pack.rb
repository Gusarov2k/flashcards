class Pack < ActiveRecord::Base
  has_many :cards
  accepts_nested_attributes_for :cards

  belongs_to :user

  validates :name, presence: true
end
