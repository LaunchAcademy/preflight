module Preflight
  module ApplicationHelper
    def preflight_form_for(record, options={}, &block)
      simple_form_for(record, options.merge(wrapper: :foundation), &block)
    end

    def flash_class_map
      {
        'notice' => 'success'
      }
    end

    def new_link_to(text, href, options = {})
      link_to(content_tag(:i, '', class: 'fa fa-plus') + " #{text}",
        href, {class: 'button small success'})
    end
  end
end
