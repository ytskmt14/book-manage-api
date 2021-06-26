require 'rails_helper'

RSpec.describe Api::V1::BooksController do
  let!(:sample_book) { create(:book) }

  describe '#index' do
    before do
      # let!が評価されてbookの情報が作成されるので9回作成すればOK
      create_list(:book, 9)
    end
    example '本の一覧が取得できること' do
      get api_v1_books_path
      json = JSON.parse(response.body)

      expect(response).to have_http_status 200
      expect(json['data'].length).to eq(10)
    end
  end

  describe '#show' do
    example '特定の本の情報が取得できること' do
      get api_v1_book_path(sample_book.id)
      body = JSON.parse(response.body)

      expect(response).to have_http_status 200
      expect(body['data']['title']).to eq(sample_book.title)
    end
  end

  describe '#create' do
    example '本の情報が新規作成できること' do
      expect do
        post api_v1_books_path, params: { book: attributes_for(:book) }
      end.to change(Book, :count).by(1)

      expect(response).to have_http_status 200
    end
  end

  describe '#update' do
    example '特定の本の情報を更新できること' do
      book = Book.find(sample_book.id)

      expect do
        put api_v1_book_path(book.id), params: { book: attributes_for(:update_book) }
      end.to change { Book.find(book.id).title }.from('Sample Title').to('Updated Sample Title')

      expect(response).to have_http_status 200
    end
  end

  describe '#destroy' do
    example '特定の本の情報を削除できること' do
      book = Book.find(sample_book.id)

      expect do
        delete api_v1_book_path(book.id)
      end.to change(Book, :count).by(-1)

      expect(response).to have_http_status 200
    end
  end
end
