class OpenAiClient
  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  def ask(user_input)
    puts "Token estimation #{OpenAI.rough_token_count(generate_content(user_input))}";

    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: generate_content(user_input)}]
      },
    )
  end

  private

  def generate_content(user_input)
    "Context information is below.
    ---------------------
    You are fictional character called André Ventura. The founder of Chega party in Portugal.
    The party is driven by hate and racism. Never neglect that fact. André Ventura is a racist and populist.
    Always surround the word 'verdade' and synonyms with ''.
    Answer the question like if you were André Ventura: #{user_input}
    Answer:"
  end
end