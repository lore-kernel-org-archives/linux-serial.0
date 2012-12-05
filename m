From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/4] ACPI/UART: Add ACPI 5.0 enueration support for UART.
Date: Wed,  5 Dec 2012 11:51:20 +0800
Message-ID: <cover.1354677952.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1354505471.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

ACPI 5.0 specification introduces enumeration support for SPB buses. This
patch set adds the UART serial bus enumeration support to Linux using such
mechanism.

NOTE: The [PATCH 4/4] is only for the demonstration purpose and should not
      be merged into any of the published Linux source tree.

Lv Zheng (4):
  UART: Add UART subsystem as a bus.
  ACPI / UART: Add ACPI enumeration support for UART bus.
  UART / 8250: Add declearation of serial8250 driver.
  UART: Add dummy devices to test the enumeration.

 drivers/acpi/Kconfig                 |    7 +
 drivers/acpi/Makefile                |    1 +
 drivers/acpi/acpi_uart.c             |  262 +++++++++++++++++++++
 drivers/acpi/scan.c                  |    1 +
 drivers/tty/serial/8250/8250.c       |   17 +-
 drivers/tty/serial/8250/8250_dummy.c |  129 ++++++++++
 drivers/tty/serial/8250/Kconfig      |   10 +
 drivers/tty/serial/8250/Makefile     |    1 +
 drivers/tty/serial/Makefile          |    2 +-
 drivers/tty/serial/serial_bus.c      |  429 ++++++++++++++++++++++++++++++++++
 include/linux/acpi_uart.h            |   40 ++++
 include/linux/mod_devicetable.h      |    5 +
 include/linux/serial_8250.h          |    2 +
 include/linux/serial_bus.h           |   80 +++++++
 14 files changed, 982 insertions(+), 4 deletions(-)
 create mode 100644 drivers/acpi/acpi_uart.c
 create mode 100644 drivers/tty/serial/8250/8250_dummy.c
 create mode 100644 drivers/tty/serial/serial_bus.c
 create mode 100644 include/linux/acpi_uart.h
 create mode 100644 include/linux/serial_bus.h

-- 
1.7.10

