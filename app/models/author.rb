class Author < ApplicationRecord
    belongs_to :movie
    validates :name, presence: true
    validates :email, presence: true
    validates :country, presence: true
end
