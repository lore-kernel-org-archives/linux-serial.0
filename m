From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/10] Nokia H4+ support
Date: Sat,  4 Mar 2017 12:58:23 +0100
Message-ID: <20170304115833.3538-1-sre@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi,

As the title suggest here is another try to get the Nokia bluetooth
supported mainline. The driver is based on the serdev work from Rob
Herring, which got merged into 4.11-rc1 (this patchset is based on
recent master branch from torvalds).

The driver was tested on N950 (I can connect to different devices
with bluetoothctl and fetch their info). It does not yet run completly
stable (especially on N900), but its better than no device support
at all.

-- Sebastian

Rob Herring (1):
  Bluetooth: hci_uart: add serdev driver support library

Sebastian Reichel (9):
  ARM: dts: N9/N950: add bluetooth
  ARM: dts: N900: Add bluetooth
  Bluetooth: hci_uart: add support for word alignment
  Bluetooth: hci_serdev: do not open device in hci open
  tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init
  serdev: add serdev_device_wait_until_sent
  serdev: add serdev_device_get_cts
  serdev: add serdev_device_set_rts
  Bluetooth: add nokia driver

 .../devicetree/bindings/net/nokia-bluetooth.txt    |  51 ++
 arch/arm/boot/dts/omap3-n900.dts                   |  23 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  32 +
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   3 +
 drivers/bluetooth/hci_h4.c                         |  17 +
 drivers/bluetooth/hci_ldisc.c                      |   4 +
 drivers/bluetooth/hci_nokia.c                      | 839 +++++++++++++++++++++
 drivers/bluetooth/hci_serdev.c                     | 365 +++++++++
 drivers/bluetooth/hci_uart.h                       |   7 +
 drivers/tty/serdev/core.c                          |  33 +
 drivers/tty/serdev/serdev-ttyport.c                |  62 +-
 drivers/tty/serial/omap-serial.c                   |   3 +
 include/linux/serdev.h                             |  12 +
 14 files changed, 1460 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
 create mode 100644 drivers/bluetooth/hci_nokia.c
 create mode 100644 drivers/bluetooth/hci_serdev.c

-- 
2.11.0
