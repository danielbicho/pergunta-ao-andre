class ChatController < ApplicationController
  def index
  end

  def ask
    # client = OpenAI::Client.new(access_token: "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")
    model = "microsoft/DialoGPT-medium"
    api_url = "https://api-inference.huggingface.co/models/#{model}"

    headers = {
      "Authorization Bearer" => ENV["HUGGINGFACE_API_KEY"],
    }

    conn = Faraday.new

    response = conn.post(api_url, params[:query], headers)
    @result = JSON.parse(response.body)["generated_text"]
  end
end
