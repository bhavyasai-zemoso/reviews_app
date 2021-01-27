class Book < ApplicationRecord
    has_many :posts, as: :postable, dependent: :destroy
end
