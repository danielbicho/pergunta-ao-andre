class ChatController < ApplicationController
  def index
  end

  def ask
    @result = HuggingFaceClient.new.ask(params[:query])
    @result
  end
end
