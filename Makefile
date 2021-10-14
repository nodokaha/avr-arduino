all: main.hex

write:
	sudo avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyUSB0 -b 115200 -U flash:w:main.hex

main.hex: main main.o
	avr-objcopy -O ihex -R .eeprom main main.hex

main: main.o
	avr-gcc -mmcu=atmega328p main.o -o main

main.o:
	avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o main.o main.c
	
new:
	arduino-cli sketch new test
	
build:
	arduino-cli compile -b arduino:avr:uno
	
deps:
	arduino-cli core install arduino:avr
	
upload:
	arduino-cli upload

clean:
	rm *.o *.hex main
