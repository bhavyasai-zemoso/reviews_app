class Movie < ApplicationRecord
     has_many :authors, dependent: :destroy 
    #has_many :posts, dependent: :destroy 
end
