class ChatController < ApplicationController
  def index
  end

  def ask
    Turbo::StreamsChannel.broadcast_replace_to(:answers, target: "answer", html: "<turbo-frame id='answer' class='answer-box'></turbo-frame>")

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
