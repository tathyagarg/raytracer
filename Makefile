SOURCE := src
BINARY := bin
QR     := qr

.PHONY: all
all: $(BINARY) debug

prod:
	nasm -f elf64 $(SOURCE)/main.asm -o $(BINARY)/main.o -O3
	ld $(BINARY)/main.o -o $(BINARY)/main -z noseparate-code --strip-all

	rm $(BINARY)/main.o
	@echo "Finished building with size: " `wc -c $(BINARY)/main | awk '{print $$1}'` "bytes"

debug:
	nasm -f elf64 $(SOURCE)/main.asm -o $(BINARY)/main.o
	ld $(BINARY)/main.o -o $(BINARY)/main 
	rm $(BINARY)/main.o

run: debug 
	$(BINARY)/main

.PHONY: qr
qr: prod
	echo "data:application/octet-stream;base64," $$(base64 -w 0 $(BINARY)/main) > $(QR)/middleman.txt
	cat $(QR)/middleman.txt | qrencode -o $(QR)/main.png
	@echo "File size: " `wc -c $(QR)/middleman.txt | awk '{print $$1}'` "bytes"
	
$(BINARY):
	@mkdir -p $(BINARY)
