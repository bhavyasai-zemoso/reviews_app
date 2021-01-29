class AddUniqueConstraintToPosts < ActiveRecord::Migration[6.1]
  def change
    add_index :posts, [:user_id, :postable_id], unique: true
  end
end
