module Api
  module V1
    class BookLendingsController < ApplicationController
      before_action :set_book_lending, only: %i[show update destroy cancel]

      def index
        book_lendings = BookLending.order(created_at: :desc)
        render json: { status: :ok, data: book_lendings }
      end

      def show
        render json: { status: :ok, data: @book_lending }
      end

      def create
        book_lending = BookLending.new(book_lending_param)
        if book_lending.save
          render json: { status: :ok, data: book_lending }
        else
          render json: { status: :bad_request, data: book_lending.errors }
        end
      end

      def update
        if @book_lending.update(book_lending_param)
          render json: { status: :ok, data: @book_lending }
        else
          render json: { status: :ok, data: @book_lending.errors }
        end
      end

      def destroy
        @book_lending.destroy
        render json: { status: :ok, data: @book_lending }
      end

      def cancel
        @book_lending.attributes = { is_cancelled: true }
        if @book_lending.save
          render json: { status: :ok, data: @book_lending }
        else
          render json: { status: :bad_request, data: @book_lending.errors }
        end
      end

      private

      def set_book_lending
        @book_lending = BookLending.find(params[:id])
      end

      def book_lending_param
        params.require(:book_lending).permit(:book_id, :start_dt, :end_dt, :returned_flg, :is_cancelled)
      end
    end
  end
end
