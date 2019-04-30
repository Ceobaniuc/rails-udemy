module ApplicationHelper
  def login_helper style = ''
     if current_user.is_a?(GuestUser)
       (link_to 'register', new_user_registration_path, class: style) +
       " ".html_safe +
       (link_to 'login', new_user_session_path, class: style)
     else
       link_to 'logout', destroy_user_session_path, method: :delete, class: style
     end
  end
  def source_helper(layout_name)
    if session[:source]
      greeting = "Thanks for visiting me from  #{session[:source]} and you are on the #{layout_name} layout"
      content_tag(:p, greeting, class: "source-greeting")
    end
  end

  def copyright_generator
    DireitosAutorais::Renderer.copyright 'Pedro Ceobaniuc', 'Todos os direitos reservados'
  end

  def nav_helper style, tag_type
nav_links = <<NAV
<#{tag_type}><a href="#{root_path}" class="#{style}">Home</a></#{tag_type}>
<#{tag_type}><a href="#{about_me_path}" class="#{style}">About me</a></#{tag_type}>
<#{tag_type}><a href="#{contact_path}" class="#{style}">Contact me</a></#{tag_type}>
<#{tag_type}><a href="#{blogs_path}" class="#{style}">Blogs</a></#{tag_type}>
<#{tag_type}><a href="#{portfolios_path}" class="#{style}">Portfolios</a></#{tag_type}>
NAV

nav_links.html_safe

  end
end
