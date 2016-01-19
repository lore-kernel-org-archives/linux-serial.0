From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Tue, 19 Jan 2016 10:41:03 +0800
Message-ID: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, paul.gortmaker@windriver.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fintek F81504/508/512 is a multi-functional PCIE device. It contains
GPIO and serial port with high baudrate & RTS auto direction for RS485.

The serial ports support from 50bps to 1.5Mbps with Linux baudrate
define excluding 1.0Mbps due to not support 16MHz clock source.

IC function list:
	F81504: Max 2x8 GPIOs and max 4 serial ports
			port2/3 are multi-function
	F81508: Max 6x8 GPIOs and max 8 serial ports
			port2/3 are multi-function, port8/9/10/11 are gpio only
	F81512: Max 6x8 GPIOs and max 12 serial ports
			port2/3/8/9/10/11 are multi-function

We'll spilt from 8250_pci.c to new file 8250_fintek_pci.c and make it
as a kernel module with first & second patch, implements GPIOLIB with
third patch. 

Peter Hung (3):
  serial: 8250_pci: Remove Fintek PCIE UART driver
  8250_fintek_pci: Add Fintek PCIE UART driver
  8250_fintek_pci: Add GPIOLIB support

 drivers/tty/serial/8250/8250_fintek_pci.c | 767 ++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c        | 201 --------
 drivers/tty/serial/8250/Kconfig           |   9 +
 drivers/tty/serial/8250/Makefile          |   1 +
 4 files changed, 777 insertions(+), 201 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_fintek_pci.c

-- 
1.9.1
