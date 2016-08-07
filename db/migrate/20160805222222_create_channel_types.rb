class CreateChannelTypes < ActiveRecord::Migration
  def change
    create_table :channel_types do |t|

      t.string      :name
      
      t.timestamps
    end
  end
end
