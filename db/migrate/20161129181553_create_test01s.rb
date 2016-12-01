class CreateTest01s < ActiveRecord::Migration
  def change
    create_table :test01s do |t|
      t.string :title
      t.decimal :price

      t.timestamps
    end
  end
end
