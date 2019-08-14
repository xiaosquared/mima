// TODO: Make this threaded! We can't hit high framerates otherwise :-(

class BlinkyTape
{
  private String m_portName;  // TODO: How to request cu.* devices?
  private Serial m_outPort;

  private int m_numberOfChannels;
  
  private PApplet _parent;
  
  private byte[] m_data;
  private int m_dataIndex = 0;

  BlinkyTape(PApplet parent, String portName, int numberOfChannels) {
    _parent = parent;
    m_data = new byte[numberOfChannels * 3 + 1];
    m_portName = portName;
    m_numberOfChannels = numberOfChannels;

    println("Connecting to BlinkyTape on: " + portName);
    try {
      m_outPort = new Serial(parent, portName, 115200);
      println(m_outPort.port);
    }
    catch (RuntimeException e) {
      println("LedOutput: Exception while making serial port: " + e);
    }
    
    for (int i=0; i < m_data.length; i++) {
      m_data[i] = 0;
    } 
  }
  
  boolean isConnected() {
    return(m_outPort != null);
  }
  
  // Attempt to close the serial port gracefully, so we don't leave it hanging
  void close() {
    if(isConnected()) {
      try {
        m_outPort.stop();
      }
      catch (Exception e) {
        println("LedOutput: Exception while closing: " + e);
      }
    }
    
    m_outPort = null;
  }
  
  String getPortName() {
    return m_portName;
  }
  
  void send() {
    startSend();
    while(sendNextChunk()) {
      delay(1);
    };
    
    m_dataIndex = 0;
  }
  
  int m_currentChunkPos;
  
  void startSend() {
    m_currentChunkPos = 0;
  }
  
  // returns false if done
  boolean sendNextChunk() {
    // Don't send data too fast, the arduino can't handle it.
    int maxChunkSize = 63;
    
    if( m_currentChunkPos >= m_numberOfChannels + 1) {
      return false;
    }
    
    int currentChunkSize = min(maxChunkSize, m_numberOfChannels + 1 - m_currentChunkPos);
    byte[] test = new byte[currentChunkSize];
    
    for(int i = 0; i < currentChunkSize; i++) {
        test[i] = m_data[m_currentChunkPos + i];
    }
  
    m_outPort.write(test);
    
    m_currentChunkPos += maxChunkSize;
    return true;
  }
  
  void pushChannel(int c) {
    m_data[m_dataIndex++] = (byte)min(254, c);
  }
  
  int getindex() {
    return m_dataIndex;
  }
  void setIndex(int i) {
    m_dataIndex = i;
  }
  
  // finalize - for use with pushPixel
  void update() {
    if( m_data[m_dataIndex] != (byte)255) {
      m_data[m_dataIndex++] = (byte)255;
    }
    send();
    m_dataIndex = 0;
  }
}
