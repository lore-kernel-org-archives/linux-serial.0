From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v4 0/3] ACPI/UART: Add ACPI 5.0 enueration support for UART.
Date: Wed, 9 Jan 2013 09:17:52 +0000 (UTC)
Message-ID: <cover.1357837482.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16319 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757391Ab3AIJRu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jan 2013 04:17:50 -0500
Date: Fri, 11 Jan 2013 01:16:55 +0800
In-Reply-To: <cover.1354505471.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

ACPI 5.0 specification introduces enumeration support for SPB buses. This
patch set adds the UART serial bus enumeration support to Linux using such
mechanism.
NOTE: PATCH 3 is a test patch, should not be merged into any published
      Linux source tree.
This patch set is based on the tty tree/tty-next branch.

History:
v1:
  1. Add "uart" bus subsystem.
  2. Add physical UART target device and description
     (uart_device/uart_board_info).
  3. Add logical UART host adapter (klist).
  4. Add UART target device attributes (tty_dev/tty_attrs/modem_lines).
  5. Create tty_device<->uart_device links (host_node/target_node).
v2.
  1. Change UART layer related stuff to non-UART related.
  2. Modify the order of the function parameters.
v3:
  1. Add comments for the uart_board_info and the uart_device.
  2. Add platform_data/archdata support.
  3. Add ACPI binding and test the binding.
  4. Add SERIAL_BUS kconfig item.
v4
  1. Convert "uart" bus into "tty_enum" bus.
  2. Convert uart_target_device into tty_slave_device.
  3. Convert uart_board_info into tty_board_info.
  3. Convert kconfig item SERIAL_BUS into TTY_ENUM.
  4. Add automatic device unregister support for slave devices.
     The new tty_port_unregister_device is for this purpose.
  5. Add HID/CID list support.
  6. Convert TTY slave device name into ACPI node name.

All of the codes can be tested by the dummy 8250 device.


Lv Zheng (3):
  TTY: Add TTY slave enumeration support.
  ACPI / UART: Add ACPI enumeration support for UART.
  UART: Add dummy devices to test the enumeration.

 drivers/acpi/Kconfig                 |    6 +
 drivers/acpi/Makefile                |    1 +
 drivers/acpi/acpi_uart.c             |  215 ++++++++++++++++++++
 drivers/acpi/scan.c                  |    1 +
 drivers/tty/Kconfig                  |    3 +
 drivers/tty/Makefile                 |    1 +
 drivers/tty/serial/8250/8250.c       |    5 +-
 drivers/tty/serial/8250/8250_dummy.c |  103 ++++++++++
 drivers/tty/serial/8250/Kconfig      |   10 +
 drivers/tty/serial/8250/Makefile     |    1 +
 drivers/tty/serial/Kconfig           |    1 +
 drivers/tty/serial/serial_core.c     |    2 +-
 drivers/tty/tty_enum.c               |  357 ++++++++++++++++++++++++++++++++++
 drivers/tty/tty_port.c               |   42 +++-
 include/linux/mod_devicetable.h      |    6 +
 include/linux/serial_8250.h          |    4 +
 include/linux/serial_core.h          |   12 ++
 include/linux/tty.h                  |  112 +++++++++++
 18 files changed, 875 insertions(+), 7 deletions(-)
 create mode 100644 drivers/acpi/acpi_uart.c
 create mode 100644 drivers/tty/serial/8250/8250_dummy.c
 create mode 100644 drivers/tty/tty_enum.c

-- 
1.7.10

