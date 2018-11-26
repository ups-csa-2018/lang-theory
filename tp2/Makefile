SUBDIRS=grammar1 grammar2 grammar3 grammar4

all: build

build: $(SUBDIRS:=-build)

$(SUBDIRS:=-build):
	make -C "$(@:-build=)"

clean: $(SUBDIRS:=-clean)
	rm -f $(SUBDIRS:=.tar.gz)

$(SUBDIRS:=-clean):
	make -C "$(@:-clean=)" cleanall

archive: clean
	for d in $(SUBDIRS); do \
		tar -cvzf "$$d.tar.gz" "$$d"; \
	done
