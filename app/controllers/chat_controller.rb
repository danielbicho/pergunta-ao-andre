class ChatController < ApplicationController
  def index
  end

  def ask
    OpenAiClient.new.ask(params[:query]) do |chunk|
      if token = chunk.dig("choices", 0, "delta", "content")
        Turbo::StreamsChannel.broadcast_append_to(
          :answers,
          target: "answer",
          content: "#{token}",
        )
      end
    end

    head :ok
  end
end
