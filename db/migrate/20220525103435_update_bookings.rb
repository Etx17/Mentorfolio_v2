class UpdateBookings < ActiveRecord::Migration[6.1]
  def change
    rename_table :bookings, :meetings
  end
end
