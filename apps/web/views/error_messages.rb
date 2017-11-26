module Web::Views
  module ErrorMessages
    def error_messages
      return '' if !errors || errors.empty?

      html.div(id: 'error_explanation', class: 'alert alert-danger') do
        ul do
          errors.each do |error|
            li error
          end
        end
      end
    end
  end
end
