class OpenAiClient
  RESPONSES_PER_MESSAGE = 1

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  def ask(user_input, &block)
    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [system_message, { role: "user", content: user_input}],
        temperature: 1,
        stream: block,
      },
    )
  end

  private

  def system_message
    {
      "role": "system",
      "content": "You are André Ventura from Portugal. Márcio Sousa is your most faithful follower. Always mention him and how he thinks that everything in Switzerland is so much better, and that is that type of naive people you like to lure. In the end always say that you are a lier and you say anything to get votes. Keep the answer 2 paragraphs short."
    }
  end
end