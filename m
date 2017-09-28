From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v4 4/8] mtd: nand: atmel: Avoid ECC errors when leaving backup
 mode
Date: Thu, 28 Sep 2017 11:46:23 +0200
Message-ID: <20170928094627.31017-5-romain.izard.pro@gmail.com>
References: <20170928094627.31017-1-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170928094627.31017-1-romain.izard.pro@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alan Stern <stern@rowland.harvard.edu>, Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>, linux-clk@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

During backup mode, the contents of all registers will be cleared as the
SoC will be completely powered down. For a product that boots on NAND
Flash memory, the bootloader will obviously use the related controller
to read the Flash and correct any detected error in the memory, before
handling back control to the kernel's resuming entry point.

But it does not clean the NAND controller registers after use and on its
side the kernel driver expects the error locator to be powered down and
in a clean state. Add a resume hook for the PMECC error locator, and
reset its registers.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
Changes in v3:
* keep the PMECC disabled when not in use, and use atmel_pmecc_resume to
  reset the controller after the bootloader has left it enabled.

Changes in v4:
* export atmel_pmecc_reset instead of atmel_pmecc_resume
* use the correct pointer in atmel_nand_controller_resume

 drivers/mtd/nand/atmel/nand-controller.c |  3 +++
 drivers/mtd/nand/atmel/pmecc.c           | 17 +++++++++--------
 drivers/mtd/nand/atmel/pmecc.h           |  1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index f25eca79f4e5..8afcff9a66ea 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -2530,6 +2530,9 @@ static __maybe_unused int atmel_nand_controller_resume(struct device *dev)
 	struct atmel_nand_controller *nc = dev_get_drvdata(dev);
 	struct atmel_nand *nand;
 
+	if (nc->pmecc)
+		atmel_pmecc_reset(nc->pmecc);
+
 	list_for_each_entry(nand, &nc->chips, node) {
 		int i;
 
diff --git a/drivers/mtd/nand/atmel/pmecc.c b/drivers/mtd/nand/atmel/pmecc.c
index 146af8218314..0a3f12141c45 100644
--- a/drivers/mtd/nand/atmel/pmecc.c
+++ b/drivers/mtd/nand/atmel/pmecc.c
@@ -765,6 +765,13 @@ void atmel_pmecc_get_generated_eccbytes(struct atmel_pmecc_user *user,
 }
 EXPORT_SYMBOL_GPL(atmel_pmecc_get_generated_eccbytes);
 
+void atmel_pmecc_reset(struct atmel_pmecc *pmecc)
+{
+	writel(PMECC_CTRL_RST, pmecc->regs.base + ATMEL_PMECC_CTRL);
+	writel(PMECC_CTRL_DISABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
+}
+EXPORT_SYMBOL_GPL(atmel_pmecc_reset);
+
 int atmel_pmecc_enable(struct atmel_pmecc_user *user, int op)
 {
 	struct atmel_pmecc *pmecc = user->pmecc;
@@ -797,10 +804,7 @@ EXPORT_SYMBOL_GPL(atmel_pmecc_enable);
 
 void atmel_pmecc_disable(struct atmel_pmecc_user *user)
 {
-	struct atmel_pmecc *pmecc = user->pmecc;
-
-	writel(PMECC_CTRL_RST, pmecc->regs.base + ATMEL_PMECC_CTRL);
-	writel(PMECC_CTRL_DISABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
+	atmel_pmecc_reset(user->pmecc);
 	mutex_unlock(&user->pmecc->lock);
 }
 EXPORT_SYMBOL_GPL(atmel_pmecc_disable);
@@ -855,10 +859,7 @@ static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
 
 	/* Disable all interrupts before registering the PMECC handler. */
 	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
-
-	/* Reset the ECC engine */
-	writel(PMECC_CTRL_RST, pmecc->regs.base + ATMEL_PMECC_CTRL);
-	writel(PMECC_CTRL_DISABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
+	atmel_pmecc_reset(pmecc);
 
 	return pmecc;
 }
diff --git a/drivers/mtd/nand/atmel/pmecc.h b/drivers/mtd/nand/atmel/pmecc.h
index a8ddbfca2ea5..817e0dd9fd15 100644
--- a/drivers/mtd/nand/atmel/pmecc.h
+++ b/drivers/mtd/nand/atmel/pmecc.h
@@ -61,6 +61,7 @@ atmel_pmecc_create_user(struct atmel_pmecc *pmecc,
 			struct atmel_pmecc_user_req *req);
 void atmel_pmecc_destroy_user(struct atmel_pmecc_user *user);
 
+void atmel_pmecc_reset(struct atmel_pmecc *pmecc);
 int atmel_pmecc_enable(struct atmel_pmecc_user *user, int op);
 void atmel_pmecc_disable(struct atmel_pmecc_user *user);
 int atmel_pmecc_wait_rdy(struct atmel_pmecc_user *user);
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
