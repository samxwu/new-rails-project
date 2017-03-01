require 'redcarpet'
module ApplicationHelper
    def markdown(text)
        options = {
            hard_wrap:              true, 
            filter_html:            true, 
            autolink:               true, 
            no_intra_emphasis:      true, 
            fenced_code_blocks:     true,
            space_after_headers:    true
        }
        
        extensions = {
            autolink:           true,
            superscript:        true,
            disable_indented_code_blocks: true
        }
    
        renderer = Redcarpet::Render::HTML.new(options)
        markdown = Redcarpet::Markdown.new(renderer, extensions)
        
        markdown.render(text).html_safe
    end
end
