From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v3 0/4] ACPI/UART: Add ACPI 5.0 enueration support for UART.
Date: Thu,  6 Dec 2012 17:21:45 +0800
Message-ID: <cover.1354785372.git.lv.zheng@intel.com>
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

History:
v1:
  1. Add uart bus type subsystem (uart_bus).
  2. Add physical uart target device and description
     (uart_device/uart_board_info).
  3. Add logical uart host adapter (klist).
  4. Add uart target device attributes (tty_dev/tty_attrs/modem_lines).
  5. Create tty_device<->uart_device links (host_node/target_node).
v2.
  1. Change uart layer related stuff to tty layer.
  2. Modify the order of the function parameters.
v3:
  1. Add comments for the uart_board_info and the uart_device.
  2. Add platform_data/archdata support.
  3. Add ACPI binding and test the binding.
  4. Add SERIAL_BUS kconfig item.

RFCs:
  1. Do we need to rename uart_bus to tty_bus and rename uart_device to
     tty_target?
  2. Do we need a kernel driver for the uart_device?
  3. Do we need to split uart_board_info.type into uart_board_info.id and
     uart_board_info.type? How can ACPI fill the uart_board_info.type?
  4. Do we need to set line discipline for the uart_board_info?

Lv Zheng (4):
  UART: Add UART subsystem as a bus.
  ACPI / UART: Add ACPI enumeration support for UART bus.
  UART / 8250: Add declearation of serial8250 driver.
  UART: Add dummy devices to test the enumeration.

 drivers/acpi/Kconfig                 |    7 +
 drivers/acpi/Makefile                |    1 +
 drivers/acpi/acpi_uart.c             |  263 ++++++++++++++++++++
 drivers/acpi/scan.c                  |    1 +
 drivers/tty/serial/8250/8250.c       |   17 +-
 drivers/tty/serial/8250/8250_dummy.c |  129 ++++++++++
 drivers/tty/serial/8250/Kconfig      |   10 +
 drivers/tty/serial/8250/Makefile     |    1 +
 drivers/tty/serial/Kconfig           |    8 +
 drivers/tty/serial/Makefile          |    1 +
 drivers/tty/serial/serial_bus.c      |  435 ++++++++++++++++++++++++++++++++++
 include/linux/acpi_uart.h            |   40 ++++
 include/linux/mod_devicetable.h      |    5 +
 include/linux/serial_8250.h          |    2 +
 include/linux/serial_bus.h           |  126 ++++++++++
 15 files changed, 1043 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/acpi_uart.c
 create mode 100644 drivers/tty/serial/8250/8250_dummy.c
 create mode 100644 drivers/tty/serial/serial_bus.c
 create mode 100644 include/linux/acpi_uart.h
 create mode 100644 include/linux/serial_bus.h

-- 
1.7.10

