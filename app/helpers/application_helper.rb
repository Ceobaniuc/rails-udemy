module ApplicationHelper
  def login_helper style = ''
     if current_user.is_a?(GuestUser)
       (link_to 'register', new_user_registration_path, class: style) +
       " ".html_safe +
       (link_to 'login', new_user_session_path, class: style)
     else
       (link_to 'logout', destroy_user_session_path, method: :delete, class: style) +
       (link_to 'edit profile', edit_user_registration_path, class: style)
     end
  end
  def source_helper(styles)
    if session[:source]
      greeting = "Obrigado por me visitar pelo #{session[:source]}, por favor, sinta-se a vontade para entrar #{ link_to 'contato', contact_path } caso queira trabalhar junto. "
      content_tag(:div, greeting.html_safe, class: styles)
    end
  end

  def copyright_generator
    DireitosAutorais::Renderer.copyright 'Pedro Ceobaniuc', 'Todos os direitos reservados'
  end

  def nav_items
    [
      {
        url: root_path,
        title: 'Home'
      },
      {
        url: about_me_path,
        title: 'About me'
      },
      {
        url: contact_path,
        title: 'Contact'
      },
      {
        url: tech_news_path,
        title: 'Tech News'
      },
      {
        url: blogs_path,
        title: 'Blogs'
      },
      {
        url: portfolios_path,
        title: 'Portfolio'
      }
    ]
  end

  def nav_helper style, tag_type
    nav_links =  ''

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
  end

  def active? path
    "active" if current_page? path
  end

  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])

    if alert
      alert_generator alert
    end
  end

  def alert_generator msg
    js add_gritter(msg, title: "Pedro Ceobaniuc Portfolio", sticky: false)
  end

end
