class FlashCard < ActiveRecord::Base
  accepts_nested_attributes_for :card
end
