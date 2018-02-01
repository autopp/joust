module Web::Views::Tournament
  class Index
    include Web::View

    def title
      'List of tournaments'
    end

    def back_path
      routes.path(:root)
    end
  end
end
