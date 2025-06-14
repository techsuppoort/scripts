#include <avr/wdt.h> //watchdog
const int relayPin = 8;
bool relayState = LOW;

void setup() {
  wdt_enable(WDTO_8S); // reset board after 8 seconds
  pinMode(relayPin, OUTPUT);
  digitalWrite(relayPin, relayState); // Turn off relay at startup
  Serial.begin(9600);
}

void loop() {
  // Check for serial input
  if (Serial.available() > 0) {
    String command = Serial.readStringUntil('\n');
    command.trim(); // sanitize
    Serial.print("Got command: " + command + "\n");
    if (command.equalsIgnoreCase("off")) {
      relayState = HIGH;
      digitalWrite(relayPin, relayState);
      Serial.println("Relay engaged.");
      relayState = LOW;
      delay(5000);
      digitalWrite(relayPin, relayState);
      Serial.println("Relay disengaged.");
      wdt_reset(); // pet watchdog (useful if the USB is long and there is a voltage drop or if the board is bad quality)
    }
  }

}