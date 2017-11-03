module Web::Views::Tournament
  class New
    include Web::View

    def title
      'New Tournament'
    end

    def back_path
      Web.routes.path(:tournaments)
    end
  end
end
