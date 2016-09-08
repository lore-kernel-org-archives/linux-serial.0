From: <tthayer@opensource.altera.com>
Subject: [PATCH 0/4] Add TX FIFO Threshold for Altera 16550-FIFOxx
Date: Thu, 8 Sep 2016 11:12:17 -0500
Message-ID: <1473351141-9239-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, lftan@altera.com, jslaby@suse.com, arnd@arndb.de, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, mail@maciej.szmigiero.name
Cc: peter.ujfalusi@ti.com, jonathanh@nvidia.com, dongsheng.wang@nxp.com, luis@debethencourt.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, tthayer.linux@gmail.com, tthayer@opensource.altera.com, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

From: Thor Thayer <tthayer@opensource.altera.com>

Some variants of the 16550 have a programmable TX FIFO threshold that
will trigger an IRQ when the FIFO drops below the threshold. The Altera
16550 compatible soft IP supports programmable TX FIFO thresholds.

This patch series adds the tx_loadsz to the device tree. The tx_loadsz
variable is amount of data that can be loaded into the FIFO on an IRQ.

This patch series also adds support for the TX FIFO threshold registers
in the Altera 16550-FIFOxx soft IP.

Thor Thayer (4):
  Documentation: dt: serial: Add TX FIFO load size
  serial: 8250: of: Load TX FIFO Load Size from DT
  serial: 8250: Set Altera 16550 TX FIFO Threshold
  nios2: dts: 10m50: Add tx-loadsz parameter

 Documentation/devicetree/bindings/serial/8250.txt |    1 +
 arch/nios2/boot/dts/10m50_devboard.dts            |    1 +
 drivers/tty/serial/8250/8250_of.c                 |    6 ++++
 drivers/tty/serial/8250/8250_port.c               |   36 +++++++++++++++++++++
 include/uapi/linux/serial_reg.h                   |    8 +++++
 5 files changed, 52 insertions(+)

-- 
1.7.9.5
