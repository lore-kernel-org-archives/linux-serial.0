From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
        <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/2] ACPI serdev support
Date: Tue, 10 Oct 2017 12:12:43 +0200
Message-ID: <1507630365-26692-1-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Add ACPI support for serial attached devices.

Currently, serial devices are not set as enumerated during ACPI scan for SPI
or i2c buses (but not for UART). This should also be done for UART serial
devices.
I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.

Tested on T100TA with Broadcom BCM2E39.

Since v1:
  - Check if a serdev device as been allocated during acpi_walk_namespace() to
    prevent serdev controller registration instead of the tty-class device.
  - Reword dev_dbg() strings replacing Serial by serdev
  - Removing redundant "serdev%d" in dev_dbg() calls in serdev_controller_add()
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

 drivers/acpi/scan.c       |  37 ++++++++--------
 drivers/tty/serdev/core.c | 106 +++++++++++++++++++++++++++++++++++++++++++---
 include/acpi/acpi_bus.h   |   2 +-
 3 files changed, 117 insertions(+), 28 deletions(-)

-- 
2.7.4
