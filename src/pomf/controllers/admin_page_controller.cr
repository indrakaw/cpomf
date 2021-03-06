module Pomf
  class AdminPageController
    include Util::AdminController

    def dashboard
      @title = "Dashboard"

      render "admin/dashboard"
    end

    def users
      @title = "Users"

      users = Models::User.where_multi("1=1")

      render "admin/users"
    end

    def users_edit
      username = Util::Validations.username(params["slug"])

      if username.nil?
        Util.redirect("/admin/users")
      end

      user = Models::User.where("username = $1", [username])

      if user.nil?
        Util.redirect("/admin/users")
      else
        errors = [] of String

        @title = "Editing #{user.username}"

        render "admin/users/edit"
      end
    end

    def files
      @title = "Files"

      render "admin/files"
    end

    def pages
      @title = "Pages"

      pages = Models::Page.where_multi("1=1")

      render "admin/pages"
    end

    def pages_new
      @title = "New Page"

      errors = [] of String

      render "admin/pages/new"
    end

    def pages_edit
      slug = params["slug"].to_slug

      if slug.empty?
        Util.redirect("/admin/pages")
      end

      errors = [] of String

      page = Models::Page.where("slug = $1", [slug])

      if !page.nil?
        @title = "Editing #{page.title}"

        render "admin/pages/edit"
      else
        Util.redirect("/admin/pages")
      end
    end
  end
end
