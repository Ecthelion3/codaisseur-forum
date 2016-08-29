module ApplicationHelper
        def sort_link(column, title = nil)
        title ||= column.titleize
        direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
        icon = sort_direction == "asc" ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down"
        icon = column == sort_column ? icon : ""
        link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
    end


    class CodeRayify < Redcarpet::Render::HTML
      def block_code(code, language)
        CodeRay.scan(code, language).div
      rescue
        code
      end
    end

    def markdown(text)
      return text if text.blank?
      coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)
      options = {
        fenced_code_blocks: true,
        no_intra_emphasis: true,
        autolink: true,
        strikethrough: true,
        lax_html_blocks: true,
        superscript: true
      }
      markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
      md = markdown_to_html.render(text).html_safe
      Emoji.replace_unicode_moji_with_images(md)
    end

    def bootstrap_class_for(flash_type)
      case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
      end
    end
end
