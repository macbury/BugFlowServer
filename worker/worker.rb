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
    log "Adding channel"
    @channel = AMQP::Channel.new(@connection, :auto_recovery => true)
    @channel.prefetch(10)

    log "Binding"
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
    @channel.queue("requests.ruby", :durable => true, :auto_delete => false).subscribe(:ack => true) do |metadata, payload|
      log "recived!"
      metadata.ack
    end
  end
  
end
