class CreatePostratings < ActiveRecord::Migration[5.1]
  def change
    create_table :postratings do |t|
      t.integer :star

      t.timestamps
    end
  end
end
