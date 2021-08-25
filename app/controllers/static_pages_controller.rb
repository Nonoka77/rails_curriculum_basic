class StaticPagesController < ApplicationController
    skip_before_action :require_login
    def top
        render "/static_pages/top"
    end
end
