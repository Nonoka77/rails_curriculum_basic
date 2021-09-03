module ApplicationHelper
    def full_title(page_title = '')
        base_title = 'RUNTEQ BOARD APP'

        page_title.empty? ? page_title : page_title + ' | ' + base_title
    end
end
