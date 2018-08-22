#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <SPI.h>

// Includes needed for Ethernet
#include <Ethernet.h>
#include <EthernetUdp.h>

byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xFE};
IPAddress ip(192, 168, 1, 134);
IPAddress sendIP(192, 168, 1, 31);
unsigned int localPort = 38000;      // local port to listen on
unsigned int sendPort = 38001;      // remote port to send to

const int num_values_in_data_array = 4;
const int num_bytes_in_message = num_values_in_data_array * 4;

union {
  float values[num_values_in_data_array];
  char data_buffer[num_bytes_in_message];
} send_data;

union {
  float values[num_values_in_data_array];
  char data_buffer[num_bytes_in_message];
} recv_data;

// Declare the UDP object
EthernetUDP Udp;

//*****************************************************
void setup()
//*****************************************************
{
  for(int i=0;i<num_values_in_data_array;i++){
    recv_data.values[i]=0.0;
    }
  pinMode(4, OUTPUT);
  digitalWrite(4, HIGH);

  // setup for Ethernet UDP
  Ethernet.begin(mac, ip);
  Udp.begin(localPort);
  Serial.begin(9600);
  delay(100);

}

void loop()
{

  //Recieve via UDP
  int packetSize = Udp.parsePacket();
  Udp.read(recv_data.data_buffer, sizeof(recv_data.data_buffer));
  if(packetSize) {
  Serial.println("Bytes received:");
  Serial.println(packetSize);
  Serial.println("Data recieved:");
  Serial.print(recv_data.values[0]);
  Serial.print(" ");
  Serial.print(recv_data.values[1]);
  Serial.print(" ");
  Serial.print(recv_data.values[2]);
  Serial.print(" ");
  Serial.println(recv_data.values[3]);
  } else {
    Serial.println("No data received.");
  }

  //Send via UDP
  send_data.values[0] = (float) recv_data.values[0];
  send_data.values[1] = (float) 2.1;
  send_data.values[2] = (float) 3.1;
  send_data.values[3] = (float) 4.1;

  //Send Sensor Dta to remote IP address and port
  Udp.beginPacket(sendIP, sendPort);
  Udp.write(send_data.data_buffer, sizeof(send_data.data_buffer));
  Udp.endPacket();

  //delay(2);

}//end loop
