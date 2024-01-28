class HuggingFaceClient
  API_BASE_URL = "https://api-inference.huggingface.co/models"

  def initialize(model = "microsoft/DialoGPT-medium")
    @model = model
    @api_url = "#{API_BASE_URL}/#{model}"
    @headers = {
      "Authorization Bearer" => ENV["HUGGINGFACE_API_KEY"],
    }
  end

  def ask(query)
    conn = Faraday.new
    response = conn.post(@api_url, query, @headers)

    JSON.parse(response.body)["generated_text"]
  end
end