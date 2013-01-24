From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 0/2] ACPI/UART: Add ACPI 5.0 enumeration support for UART
Date: Thu, 24 Jan 2013 18:30:11 +0800
Message-ID: <cover.1359022955.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51886 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591Ab3AXCaR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jan 2013 21:30:17 -0500
In-Reply-To: <cover.1354505471.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

ACPI 5.0 specification introduces enumeration support for SPB buses. This
patch set adds the UART serial bus enumeration support to Linux using such
mechanism.
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
  3. Add ACPI binding and test the binding (in seperate patch).
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
v5
  1. Add missing static reported by recent kernel build test.

Lv Zheng (2):
  TTY: Add TTY slave enumeration support
  ACPI / UART: Add ACPI enumeration support for UART

 drivers/acpi/Kconfig             |    6 +
 drivers/acpi/Makefile            |    1 +
 drivers/acpi/acpi_uart.c         |  215 +++++++++++++++++++++++
 drivers/tty/Kconfig              |    3 +
 drivers/tty/Makefile             |    1 +
 drivers/tty/serial/Kconfig       |    1 +
 drivers/tty/serial/serial_core.c |    2 +-
 drivers/tty/tty_enum.c           |  357 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/tty_port.c           |   42 ++++-
 include/linux/mod_devicetable.h  |    6 +
 include/linux/tty.h              |  112 ++++++++++++
 11 files changed, 742 insertions(+), 4 deletions(-)
 create mode 100644 drivers/acpi/acpi_uart.c
 create mode 100644 drivers/tty/tty_enum.c

-- 
1.7.10

