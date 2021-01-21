class Author < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :country, presence: true
end
