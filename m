From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v5 0/2]  tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date: Fri, 12 Apr 2019 19:01:09 -0700
Message-ID: <20190413020111.23400-1-paul.walmsley@sifive.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-serial@vger.kernel.org

This series adds a serial driver, with console support, for the
UART IP block present on the SiFive FU540 SoC.  The programming
model is straightforward, but unique.

Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
open-source FSBL (with appropriate patches to the DT data).

This fifth version fixes a bug in the set_termios handler,
found by Andreas Schwab <schwab@suse.de>.

The patches in this series can also be found, with the PRCI patches,
DT patches, and DT prerequisite patch, at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4


- Paul

Paul Walmsley (2):
  dt-bindings: serial: add documentation for the SiFive UART driver
  tty: serial: add driver for the SiFive UART

 .../bindings/serial/sifive-serial.txt         |   33 +
 drivers/tty/serial/Kconfig                    |   24 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/sifive.c                   | 1056 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 5 files changed, 1117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
 create mode 100644 drivers/tty/serial/sifive.c

-- 
2.20.1
