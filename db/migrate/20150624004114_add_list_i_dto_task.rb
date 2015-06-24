class AddListIDtoTask < ActiveRecord::Migration
  belongs_to :list

  def change
    add_column :tasks, :list_id, :integer
  end
end
