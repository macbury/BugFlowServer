require "amqp"

class Worker
  
  def initialize(args)
    log "Start..."
    @thread = Thread.new { EventMachine.run }
    log "Starting EventMachine"
    @thread.abort_on_exception = true
    sleep(0.5)
    
    log "Connecting"
    @connection = AMQP.connect :user => "guest", :pass => "guest", :vhost => "/"
    log "Connecting to channel"
    @channel = AMQP::Channel.new(@connection, :auto_recovery => true)
    @channel.prefetch(10)

    bind
    
    log "Boot successful"
    Signal.trap("INT") { @connection.close { EventMachine.stop } }
    @thread.join
  end
  
  def demonize
    
  end
  
  def log(msg)
    puts msg
  end
  
  def bind
    log "Starting queue"
    @channel.queue("requests.ruby", :durable => true, :auto_delete => false).subscribe(:ack => true) do |metadata, payload|
      request = YAML.load(payload)
      log "metadata: "
      log metadata.inspect

      log "Payload"
      log request.inspect

      EM.next_tick { request }
      metadata.ack
    end
  end
  
end
