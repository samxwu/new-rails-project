class DropCollaboratorsTable < ActiveRecord::Migration
  def up
    drop_table :collaborators
  end
end
