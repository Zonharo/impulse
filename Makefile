APP_BUNDLE := $(CURDIR)/dist/Impulse.app
APP_BIN := $(APP_BUNDLE)/Contents/MacOS/impulse
GUEST_DIR := $(CURDIR)/build/guest

KERNEL ?= $(GUEST_DIR)/Image
INITRD ?= $(GUEST_DIR)/initrd
BASE_IMAGE ?= $(GUEST_DIR)/impulse-debian.raw.zst
CONFIG ?= $(CURDIR)/examples/gaming.impulse

.PHONY: app bundle dependencies guest-image run clean

app: guest-image
	./scripts/build-app.sh --kernel "$(KERNEL)" --initrd "$(INITRD)" --base-image "$(BASE_IMAGE)"

bundle: guest-image
	./scripts/build-app.sh --skip-dependencies --kernel "$(KERNEL)" --initrd "$(INITRD)" --base-image "$(BASE_IMAGE)"

dependencies:
	./scripts/build-app.sh --dependencies-only

guest-image:
	./guest/build-image.sh

run: bundle
	IMPULSE_FENCE_POLL_US=1000 \
	"$(APP_BIN)" "$(CONFIG)" 2> vmm.log

clean:
	rm -rf "$(CURDIR)/build" "$(CURDIR)/dist"
