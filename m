From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 0/3] ACPI/UART: Add ACPI 5.0 enueration support for UART.
Date: Mon,  3 Dec 2012 11:39:44 +0800
Message-ID: <cover.1354505471.git.lv.zheng@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:26992 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530Ab2LCDj5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Dec 2012 22:39:57 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

ACPI 5.0 specification introduces enumeration support for SPB buses. This
patch set adds the UART serial bus enumeration support to Linux using such
mechanism.

NOTE: The [PATCH 3/3] is only for the demonstration purpose and should not
      be merged into any of the published Linux source tree.

Lv Zheng (3):
  UART: Add UART subsystem as a bus.
  ACPI / UART: Add ACPI enumeration support for UART bus.
  UART: Add dummy devices to test the enumeration.

 drivers/acpi/Kconfig                 |    7 +
 drivers/acpi/Makefile                |    1 +
 drivers/acpi/acpi_uart.c             |  255 ++++++++++++++++++++
 drivers/acpi/scan.c                  |    1 +
 drivers/tty/serial/8250/8250.c       |   10 +-
 drivers/tty/serial/8250/8250_dummy.c |  128 ++++++++++
 drivers/tty/serial/8250/Kconfig      |   10 +
 drivers/tty/serial/8250/Makefile     |    1 +
 drivers/tty/serial/Makefile          |    2 +-
 drivers/tty/serial/serial_bus.c      |  426 ++++++++++++++++++++++++++++++++++
 include/linux/acpi_uart.h            |   40 ++++
 include/linux/mod_devicetable.h      |    5 +
 include/linux/serial_8250.h          |    2 +
 include/linux/serial_core.h          |   59 +++++
 14 files changed, 944 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/acpi_uart.c
 create mode 100644 drivers/tty/serial/8250/8250_dummy.c
 create mode 100644 drivers/tty/serial/serial_bus.c
 create mode 100644 include/linux/acpi_uart.h

-- 
1.7.10

