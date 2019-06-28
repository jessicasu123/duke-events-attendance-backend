class CreateCheckIns < ActiveRecord::Migration[5.2]
  def change
    create_table :check_ins do |t|
      t.integer :checkedin_id
      t.string :checkedin_type

      t.timestamps
    end
  end
end
