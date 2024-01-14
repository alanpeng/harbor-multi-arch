export VERSION = $(shell cat version)

all: dep patch

dep:
	git submodule update --init --recursive
	git submodule update --force --remote
	git submodule foreach -q --recursive 'git reset --hard && git checkout ${VERSION}'

patch:
	cd harbor && sh -c "curl https://github.com/alanpeng/harbor/compare/$(VERSION)...morlay:patch-$(VERSION).patch | git apply -v"

