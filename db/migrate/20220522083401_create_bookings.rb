class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :user, null: false, foreign_key: true
      t.references :mentor, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
