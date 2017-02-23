class DropWikisTable < ActiveRecord::Migration
  def up
    drop_table :wikis    
  end
end
