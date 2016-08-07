class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|

      t.string        :name
      t.belongs_to    :channel
      
      t.timestamps
    end
  end
end
