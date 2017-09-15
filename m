From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2 5/9] mtd: nand: atmel: Report PMECC failures as errors
Date: Fri, 15 Sep 2017 16:04:07 +0200
Message-ID: <20170915140411.31716-6-romain.izard.pro@gmail.com>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20170915140411.31716-1-romain.izard.pro@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

It is not normal for the PMECC to fail when trying to fix ECC errors.
Report these cases as errors.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/mtd/nand/atmel/pmecc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel/pmecc.c b/drivers/mtd/nand/atmel/pmecc.c
index 8d1208f38025..2a23f1ff945f 100644
--- a/drivers/mtd/nand/atmel/pmecc.c
+++ b/drivers/mtd/nand/atmel/pmecc.c
@@ -687,6 +687,8 @@ static int atmel_pmecc_err_location(struct atmel_pmecc_user *user)
 	 * Number of roots does not match the degree of smu
 	 * unable to correct error.
 	 */
+	dev_err(pmecc->dev,
+		"PMECC: Impossible to calculate error location.\n");
 	return -EBADMSG;
 }
 
@@ -729,7 +731,7 @@ int atmel_pmecc_correct_sector(struct atmel_pmecc_user *user, int sector,
 			ptr = ecc + byte - sectorsize;
 			area = "ECC";
 		} else {
-			dev_dbg(pmecc->dev,
+			dev_err(pmecc->dev,
 				"Invalid errpos value (%d, max is %d)\n",
 				errpos, (sectorsize + eccbytes) * 8);
 			return -EINVAL;
-- 
2.11.0
