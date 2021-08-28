class BoardsController < ApplicationController
    def index
        @boards = Board.eager_load(:user)
    end
    
end