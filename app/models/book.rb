# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :book_lendings, dependent: :destroy
end
