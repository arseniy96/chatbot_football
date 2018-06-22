module Services
  class GenerateTextForChant

    def self.call(username)
      text = "В любую погоду, и в ливень, и в зной\n#{username} умеет поражать красотой.\nПара обводок и хитрых решений,\n#{username}, мы фанаты твоих телодвижений!"
    end

  end
end