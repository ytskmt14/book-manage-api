# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: %i[show update destroy]

      def index
        books = Book.order(created_at: :desc)
        render json: { status: :ok, data: books }
      end

      def show
        render json: { status: :ok, data: @book }
      end

      def create
        book = Book.new(book_params)
        if book.save
          render json: { status: :ok, data: book }
        else
          render json: { status: :bad_request, data: book.errors }
        end
      end

      def update
        if @book.update(book_params)
          render json: { status: :ok, data: @book }
        else
          render json: { status: :ok, data: @book.errors }
        end
      end

      def destroy
        @book.destroy
        render json: { status: :ok, data: @book }
      end

      private

      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
