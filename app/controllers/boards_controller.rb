class BoardsController < ApplicationController
    def index
        @boards = Board.all.eager_load(:user).order(created_at: :desc)
    end
end