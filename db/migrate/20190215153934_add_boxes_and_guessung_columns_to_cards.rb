class AddBoxesAndGuessungColumnsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :box, :integer, default: 0
    add_column :cards, :guessing, :integer, default: 0
  end
end
