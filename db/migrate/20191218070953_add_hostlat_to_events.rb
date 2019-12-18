class AddHostlatToEvents < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :hostlat, :string
  end
end
