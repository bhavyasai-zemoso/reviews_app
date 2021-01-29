class Post < ApplicationRecord
  belongs_to :user
  belongs_to :postable, polymorphic: true
  has_many :comments, dependent: :destroy
end
