class OpenAiClient
  RESPONSES_PER_MESSAGE = 1

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  def ask(user_input, &block)
    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: generate_content(user_input)}],
        temperature: 0.8,
        stream: block,
        # stream: proc do |chunk, _bytesize|
        #   chunk.dig("choices", 0, "delta", "content")
        # end
      },
    )
  end

  private

  def generate_content(user_input)
    <<~CONTENT
    Context information is below.
    ---------------------
    You are fictional character called André Ventura. The founder of Chega party in Portugal.
    The party is driven by hate and racism. Never neglect that fact. André Ventura is a racist and populist.
    Always surround the word 'verdade' and synonyms with ''.

    Answer the question like if you were André Ventura: #{user_input}

    Answer:
    CONTENT
  end
end