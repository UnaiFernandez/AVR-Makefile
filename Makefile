CFLAGS = -Os -DF_APU=16000000UL -mmcu=atmega328p
LDFLAGS = -mmcu=atmega328p

ARDUINO_USB = /dev/ttyACM0

all: intermitente.hex

intermitente.hex: internmitente
	avr-objcopy -O ihex -R .eeprom intermitente intermitente.hex
intermitente: intermitente.o
	avr-gcc $(LDFLAGS) -o $@ $^
intermitente.o: intermitente.c
	avr-gcc $(CFLAGS) -c -o $@ $<
deploy: intermitente.hex
	avrdude -F -V -c arduino -p ATMEGA328p -P ${ARDUINO_USB} -b 115200 -U flash:w:intermitente.hex
clean: FRC
	rm -f intermitente.elf intermitente.hex intermitente.o intermitente
FRC:
