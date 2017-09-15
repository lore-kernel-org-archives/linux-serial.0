From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2 4/9] mtd: nand: atmel: Avoid ECC errors when leaving backup mode
Date: Fri, 15 Sep 2017 16:04:06 +0200
Message-ID: <20170915140411.31716-5-romain.izard.pro@gmail.com>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170915140411.31716-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

During backup mode, the contents of all registers will be cleared as the
SoC will be completely powered down. For a product that boots on NAND
Flash memory, the bootloader will obviously use the related controller
to read the Flash and correct any detected error in the memory, before
handling back control to the kernel's resuming entry point.

In normal devices, it is up to the driver's suspend/resume code to
restore the registers in a valid state. But the PMECC is not a regular
device in the driver model when used with the legacy device tree binding
for the Atmel NAND controller, and suspend/resume code is not called.

As in my case the bootloader leaves the PMECC controller in a programmed
state, and the controller is only reset at boot or after a NAND access,
the first NAND Flash access with the Atmel controller will report
uncorrectable ECC errors.

To avoid this, systematically reset the PMECC controller before using
it.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/mtd/nand/atmel/pmecc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/atmel/pmecc.c b/drivers/mtd/nand/atmel/pmecc.c
index 8c210a5776bc..8d1208f38025 100644
--- a/drivers/mtd/nand/atmel/pmecc.c
+++ b/drivers/mtd/nand/atmel/pmecc.c
@@ -777,6 +777,9 @@ int atmel_pmecc_enable(struct atmel_pmecc_user *user, int op)
 
 	mutex_lock(&user->pmecc->lock);
 
+	writel(PMECC_CTRL_RST, pmecc->regs.base + ATMEL_PMECC_CTRL);
+	writel(PMECC_CTRL_DISABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
+
 	cfg = user->cache.cfg;
 	if (op == NAND_ECC_WRITE)
 		cfg |= PMECC_CFG_WRITE_OP;
@@ -797,10 +800,6 @@ EXPORT_SYMBOL_GPL(atmel_pmecc_enable);
 
 void atmel_pmecc_disable(struct atmel_pmecc_user *user)
 {
-	struct atmel_pmecc *pmecc = user->pmecc;
-
-	writel(PMECC_CTRL_RST, pmecc->regs.base + ATMEL_PMECC_CTRL);
-	writel(PMECC_CTRL_DISABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
 	mutex_unlock(&user->pmecc->lock);
 }
 EXPORT_SYMBOL_GPL(atmel_pmecc_disable);
@@ -856,10 +855,6 @@ static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
 	/* Disable all interrupts before registering the PMECC handler. */
 	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
 
-	/* Reset the ECC engine */
-	writel(PMECC_CTRL_RST, pmecc->regs.base + ATMEL_PMECC_CTRL);
-	writel(PMECC_CTRL_DISABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
-
 	return pmecc;
 }
 
-- 
2.11.0
