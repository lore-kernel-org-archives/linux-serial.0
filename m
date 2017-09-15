From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2 0/9] Various patches for SAMA5D2 backup mode
Date: Fri, 15 Sep 2017 16:04:02 +0200
Message-ID: <20170915140411.31716-1-romain.izard.pro@gmail.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

While the core of the backup mode for SAMA5D2 has been integrated in
v4.13, it is far from complete. Individual controllers in the chip have
drivers that do not support the reset of the registers during suspend,
and they need to be adapted to handle it.

The first patch uses the clock wakeup code from the prototype backup
mode instead of the version integrated in the mainline, as the mainline
version is not stable. During a test loop with two-second backup
suspend, the mainline version will hang in less than one day, whereas
the prototype version has been running the same test for more than a
week without hanging.

Changes in v2:
* drop the IIO patch duplicating existing code
* determine the number of programmable clocks to save dynamically
* declare a required local variable in the tty/serial patch

Romain Izard (9):
  clk: at91: pmc: Wait for clocks when resuming
  clk: at91: pmc: Save SCSR during suspend
  clk: at91: pmc: Support backup for programmable clocks
  mtd: nand: atmel: Avoid ECC errors when leaving backup mode
  mtd: nand: atmel: Report PMECC failures as errors
  ehci-atmel: Power down during suspend is normal
  pwm: atmel-tcb: Support backup mode
  atmel_flexcom: Support backup mode
  tty/serial: atmel: Prevent a warning on suspend

 drivers/clk/at91/clk-programmable.c |  2 ++
 drivers/clk/at91/pmc.c              | 55 +++++++++++++++++++++++++------
 drivers/clk/at91/pmc.h              |  2 ++
 drivers/mfd/atmel-flexcom.c         | 65 ++++++++++++++++++++++++++++---------
 drivers/mtd/nand/atmel/pmecc.c      | 15 ++++-----
 drivers/pwm/pwm-atmel-tcb.c         | 63 +++++++++++++++++++++++++++++++++--
 drivers/tty/serial/atmel_serial.c   | 14 ++++++++
 drivers/usb/host/ehci-atmel.c       |  3 +-
 8 files changed, 182 insertions(+), 37 deletions(-)

-- 
2.11.0

