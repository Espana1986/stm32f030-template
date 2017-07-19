CONTAINER = stm32f030-build 
FLASHER = ./nrfjprog.sh

all:
	docker run --rm -v `pwd`:/host $(CONTAINER) /bin/bash -c "cd /host/firmware/; make"

clean:
	docker run --rm -v `pwd`:/host $(CONTAINER) /bin/bash -c "cd /host/firmware/; make clean"

flash: 	
	$(FLASHER) --flash firmware/nara/_build/nrf52832_xxac.hex -f nrf52 --sectorerase
	$(FLASHER) --reset -f nrf52

flash-softdevice:
	@echo Flashing: s130_nrf51_2.0.1_softdevice.hex
	$(FLASHER) --flash-softdevice SDK/components/softdevice/s132/hex/s132_nrf52_3.0.0_softdevice.hex -f nrf52 --sectorerase
	$(FLASHER) --reset -f nrf52

erase:
	$(FLASHER) --erase-all -f nrf52

prepare:
	docker build -t $(CONTAINER) . 
