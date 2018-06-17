module Services
  class CreateUser

    def self.call(user_params)
      User.find_by(vk_id: user_params[:vk_id]) || User.create(user_params)
    end

  end
end