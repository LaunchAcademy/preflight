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
  end
end
