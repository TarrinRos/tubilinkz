class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable,
         omniauth_providers: [:facebook, :vkontakte]

  has_many :links

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def self.find_for_facebook_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    url = "https://facebook.com/#{id}"

    where(url: url, provider: provider).first_or_create! do |user|
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
  end

  def self.find_for_vkontakte_oauth(access_token)
    # Как выглядит объект access_token можно посмотреть на странице гема
    # https://github.com/mamantoha/omniauth-vkontakte#authentication-hash
    # Мы достаем из этого объекта url и provider, вместе они формируют
    # уникального пользователя
    url = access_token.info.urls.Vkontakte
    provider = access_token.provider

    # Ищем таких пользователей методом where, а методом
    # first_or_create! мы либо выбираем первого (если такой нашелся)
    # либо создаем нового с такими параметрами (url, provider),
    # к этому юзеру в случае создания также будет применен блок
    where(url: url, provider: provider).first_or_create! do |user|
      # В блоке мы прописываем пользователю имя, которое получили от ВКонтатке
      user.name = access_token.info.name
      # Формируем email из id пользователя ВКонтакте
      user.email = "#{access_token.uid}@vk.com"
      # И генерируем ему случайный надежный парроль
      # пользоваться им никто не будет, но формально по нему можно войти
      user.password = Devise.friendly_token[0,20]
    end
  end
end
