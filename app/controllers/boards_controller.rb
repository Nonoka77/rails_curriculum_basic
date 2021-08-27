class BoardsController < ApplicationController
    def index
        @boards = Board.new
    end

end