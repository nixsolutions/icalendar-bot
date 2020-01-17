require 'json'

def webhook(event:, context:)
  p 'test webhook'
  {
    statusCode: 200
  }
end
