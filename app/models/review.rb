class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book, primary_key: "isbn"
end
