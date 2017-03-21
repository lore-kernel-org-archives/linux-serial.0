From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 00/11] Nokia H4+ support
Date: Tue, 21 Mar 2017 23:32:05 +0100
Message-ID: <20170321223216.11733-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

This is the second revision from the Nokia H4+ bluetooth patchset. I fixed all
comments I received and verified that scanning for bluetooth devices still
works on N950.

The patchset is based upon 4.11-rc1 and is also available from
the following branch:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-n900.git nokia-bt-serdev-v2

-- Sebastian

Rob Herring (1):
  Bluetooth: hci_uart: add serdev driver support library

Sebastian Reichel (10):
  Bluetooth: hci_uart: add support for word alignment
  Bluetooth: hci_serdev: do not open device in hci open
  tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init
  serdev: add serdev_device_wait_until_sent
  serdev: implement get/set tiocm
  serdev: add helpers for cts and rts handling
  dt-bindings: net: bluetooth: Add nokia-bluetooth
  Bluetooth: add nokia driver
  ARM: dts: N900: Add bluetooth
  ARM: dts: N9/N950: add bluetooth

 .../devicetree/bindings/net/nokia-bluetooth.txt    |  51 ++
 arch/arm/boot/dts/omap3-n900.dts                   |  23 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  32 +
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   3 +
 drivers/bluetooth/hci_h4.c                         |  17 +
 drivers/bluetooth/hci_ldisc.c                      |   4 +
 drivers/bluetooth/hci_nokia.c                      | 819 +++++++++++++++++++++
 drivers/bluetooth/hci_serdev.c                     | 355 +++++++++
 drivers/bluetooth/hci_uart.h                       |   7 +
 drivers/tty/serdev/core.c                          |  33 +
 drivers/tty/serdev/serdev-ttyport.c                |  39 +-
 drivers/tty/serial/omap-serial.c                   |   3 +
 include/linux/serdev.h                             |  47 ++
 14 files changed, 1442 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
 create mode 100644 drivers/bluetooth/hci_nokia.c
 create mode 100644 drivers/bluetooth/hci_serdev.c

-- 
2.11.0
