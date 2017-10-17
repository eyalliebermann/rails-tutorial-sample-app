module UsersHelper
  def gravatar_for (user, size:80)
    digest= Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{digest}?size=#{size}"
    image_tag gravatar_url, alt:user.name, class: 'gravatar', size:size
  end
end
