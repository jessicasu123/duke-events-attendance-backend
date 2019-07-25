class AddCheckintypeToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :checkintype, :string
  end
end
