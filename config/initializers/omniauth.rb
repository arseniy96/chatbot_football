Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['VK_APP_ID'], ENV['VK_APP_SECRET'],
           {
               scope: 'friends,photos,groups',
               display: 'popup',
               lang: 'en',
               https: 1,
               image_size: 'bigger_x2',
               redirect_url: 'https://football-chatbot.herokuapp.com/users/auth/vkontakte/callback',
           }
end