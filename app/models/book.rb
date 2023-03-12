class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_many :reviews, dependent: :destroy
  has_many :bookcases, dependent: :destroy
end
