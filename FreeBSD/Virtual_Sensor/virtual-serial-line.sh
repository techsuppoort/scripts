#!/bin/sh

# Create virtual raw device pair
socat -d -d PTY,link=/tmp/virtual-sensor,raw,echo=0 PTY,link=/tmp/virtual-client,raw,echo=0 &
sleep 2
SENSOR_DEV="/tmp/virtual-sensor"
CLIENT_DEV=$(readlink /tmp/virtual-client)

chmod 664 "$CLIENT_DEV"

# Generate random data
generate_random() {
  # Use awk and random number generation to make sure values vary
  echo $(awk -v min=$1 -v max=$2 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
}

while true; do
  # Generate random values for temperature, humidity, pressure, and light using the generate_random function
  TEMP=$(generate_random 20 30).$(generate_random 0 9)
  HUMIDITY=$(generate_random 40 70).$(generate_random 0 9)
  PRESSURE=$(generate_random 980 1020).$(generate_random 0 9)
  LIGHT=$(generate_random 100 1000)

  # Print the random sensor data to the virtual sensor device
  printf "TEMP: %s C  HUMIDITY: %s %%  PRESSURE: %s hPa  LIGHT: %s lux\n" \
    "$TEMP" "$HUMIDITY" "$PRESSURE" "$LIGHT" > "$SENSOR_DEV"

  # Ensure the write is flushed and the data is immediately visible
  sync

  # Random sleep between 1 and 3 seconds
  sleep $((RANDOM % 3 + 1))
done
