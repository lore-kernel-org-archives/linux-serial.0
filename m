From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv3 00/10] Nokia H4+ support
Date: Tue, 28 Mar 2017 17:59:29 +0200
Message-ID: <20170328155939.31566-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Here is PATCHv3 for the Nokia bluetooth patchset. I addressed all comments from
Rob and Pavel regarding the serdev patches and dropped the *.dts patches, since
they were queued by Tony. I also changed the patch order, so that the serdev
patches come first. All of them have Acked-by from Rob, so I think it makes
sense to merge them to serdev subsystem (now) and provide an immutable branch
for the bluetooth subsystem.

The patchset is based upon 4.11-rc1 and is also available from the following
branch:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-n900.git/log/?h=nokia-bt-serdev-v3

-- Sebastian

Rob Herring (1):
  Bluetooth: hci_uart: add serdev driver support library

Sebastian Reichel (9):
  tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init
  serdev: add serdev_device_wait_until_sent
  serdev: implement get/set tiocm
  serdev: add helpers for cts and rts handling
  Bluetooth: hci_uart: add support for word alignment
  Bluetooth: hci_serdev: do not open device in hci open
  Bluetooth: hci_serdev: allow modular drivers
  dt-bindings: net: bluetooth: Add nokia-bluetooth
  Bluetooth: add nokia driver

 .../devicetree/bindings/net/nokia-bluetooth.txt    |  51 ++
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   3 +
 drivers/bluetooth/hci_h4.c                         |  17 +
 drivers/bluetooth/hci_ldisc.c                      |   5 +
 drivers/bluetooth/hci_nokia.c                      | 819 +++++++++++++++++++++
 drivers/bluetooth/hci_serdev.c                     | 356 +++++++++
 drivers/bluetooth/hci_uart.h                       |   7 +
 drivers/tty/serdev/core.c                          |  33 +
 drivers/tty/serdev/serdev-ttyport.c                |  42 +-
 drivers/tty/serial/omap-serial.c                   |   3 +
 include/linux/serdev.h                             |  47 ++
 12 files changed, 1391 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
 create mode 100644 drivers/bluetooth/hci_nokia.c
 create mode 100644 drivers/bluetooth/hci_serdev.c

-- 
2.11.0
