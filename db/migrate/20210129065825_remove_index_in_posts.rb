class RemoveIndexInPosts < ActiveRecord::Migration[6.1]
  def change
    remove_index :posts, name: "index_posts_on_user_id_and_postable_id_and_postable_type"
  end
end
