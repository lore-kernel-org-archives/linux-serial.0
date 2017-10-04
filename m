From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
        <frederic.danis.oss@gmail.com>
Subject: [PATCH 0/2] ACPI serdev support
Date: Wed,  4 Oct 2017 10:51:28 +0200
Message-ID: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
To: robh@kernel.org, marcel@holtmann.org, sre@kernel.org, loic.poulain@gmail.com, johan@kernel.org, lukas@wunner.de, hdegoede@redhat.com
Cc: linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, frederic.danis.oss@gmail.com
List-Id: linux-serial@vger.kernel.org

Add ACPI support for serial attached devices.

Currently, serial devices are not set as enumerated during ACPI scan for SPI
or i2c buses (but not for UART). This should also be done for UART serial
devices.
I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.

For hci_bcm, this needs Hans de Goede's "Bluetooth: hci_bcm: Add (runtime)pm
support to the serdev drv" patches to work.

Tested on T100TA with Broadcom BCM2E39.

Since RFC:
  - Add or reword commit messages
  - Rename *serial_slave* to *serial_bus_slave*
  - Add specific check for Apple in acpi_is_serial_bus_slave(), thanks to
    Lukas Wunner
  - Update comment in acpi_default_enumeration()
  - Remove patch 3 "Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39"
    in favor of patches from Hans de Goede

Frédéric Danis (2):
  serdev: Add ACPI support
  ACPI / scan: Fix enumeration for special UART devices

 drivers/acpi/scan.c       | 37 ++++++++----------
 drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
 include/acpi/acpi_bus.h   |  2 +-
 3 files changed, 112 insertions(+), 26 deletions(-)

-- 
2.7.4

