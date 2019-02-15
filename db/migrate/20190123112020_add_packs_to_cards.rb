class AddPacksToCards < ActiveRecord::Migration
  def change
    add_belongs_to :cards, :pack
  end
end
