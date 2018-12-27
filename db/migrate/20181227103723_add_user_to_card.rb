class AddUserToCard < ActiveRecord::Migration
  def change
    add_belongs_to :cards, :user
  end
end
