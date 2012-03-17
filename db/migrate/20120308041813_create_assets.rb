class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :user_id
      t.timestamps
    end

    add_index :assets, :user_id
  end

  def self.down
    drop_table :assets
  end
end
