class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string    :name
      t.integer   :user_id
    end
  end
end
