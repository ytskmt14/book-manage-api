require 'rails_helper'

RSpec.describe Api::V1::BooksController do

  describe "#index" do
    before do
      create_list(:book, 10)
    end
    example "本の一覧が取得できること" do
      get api_v1_books_path
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['data'].length).to eq(10)
    end
  end

  describe "#show" do
    before do
      @book = create(:book)
    end
    example "特定の本の情報が取得できること" do
      get api_v1_book_path(@book.id)
      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body["data"]["title"]).to eq(@book.title)
    end
  end

  describe "#create" do
    example "本の情報が新規作成できること" do
      expect do
        post api_v1_books_path, params: { book: attributes_for(:book) }
      end.to change(Book, :count).by(1)

      expect(response.status).to eq(200)
    end
  end

  describe "#update" do
    before do
      @book = create(:book)
    end

    example "特定の本の情報を更新できること" do
      book = Book.find(@book.id)

      expect do
        put api_v1_book_path(book.id), params: { book: attributes_for(:update_book) }
      end.to change {Book.find(book.id).title}.from('Sample Title').to('Updated Sample Title')

      expect(response.status).to eq(200)
    end
  end

  describe "#destroy" do
    before do
      @book = create(:book)
    end

    example "特定の本の情報を削除できること" do
      book = Book.find(@book.id)

      expect do
        delete api_v1_book_path(book.id)
      end.to change(Book, :count).by(-1)

      expect(response.status).to eq(200)
    end
  end
end