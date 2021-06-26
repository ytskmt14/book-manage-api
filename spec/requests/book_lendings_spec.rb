require 'rails_helper'

RSpec.describe Api::V1::BookLendingsController do
  let(:sample_book) { create(:book) }
  let!(:sample_lending) { create(:sample_lending, book_id: sample_book.id) }

  describe '#index' do
    before do
      create_list(:book_lending, 9)
    end
    example '貸出予約の一覧が取得できること' do
      get api_v1_book_lendings_path
      json = JSON.parse(response.body)

      expect(response).to have_http_status 200
      expect(json['data'].length).to eq(10)
    end
  end

  describe '#show' do
    example '特定の貸出予約の情報が取得できること' do
      get api_v1_book_lending_path(sample_lending.id)
      body = JSON.parse(response.body)

      expect(response).to have_http_status 200
      expect(body['data']['start_dt']).to eq(sample_lending.start_dt.strftime('%Y-%m-%d'))
    end
  end

  describe '#create' do
    example '貸出予約の情報が新規作成できること' do
      expect do
        post api_v1_book_lendings_path, params: { book_lending: attributes_for(:new_lending, book_id: sample_book.id) }
      end.to change(BookLending, :count).by(1)

      expect(response).to have_http_status 200
    end
  end

  describe '#update' do
    example '特定の貸出予約の情報が更新できること' do
      book_lending = BookLending.find(sample_lending.id)

      put api_v1_book_lending_path(book_lending.id), params: { book_lending: attributes_for(:book_lending) }

      expect(response).to have_http_status 200
    end
  end

  describe '#destroy' do
    example '特定の貸出予約の情報が削除できること' do
      book_lending = BookLending.find(sample_book.id)

      expect do
        delete api_v1_book_lending_path(book_lending.id)
      end.to change(BookLending, :count).by(-1)

      expect(response).to have_http_status 200
    end
  end

  describe '#cancel' do
    example '特定の貸出予約の情報がキャンセルできること' do
      book_lending = BookLending.find(sample_lending.id)

      expect do
        post cancel_api_v1_book_lending_path(book_lending.id)
      end.to change { BookLending.find(book_lending.id).is_cancelled }.from(false).to(true)

      expect(response).to have_http_status 200
    end
  end
end
