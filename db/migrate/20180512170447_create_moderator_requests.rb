class CreateModeratorRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :moderator_requests do |t|

      t.timestamps
    end
  end
end
