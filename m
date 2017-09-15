From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2 2/9] clk: at91: pmc: Save SCSR during suspend
Date: Fri, 15 Sep 2017 16:04:04 +0200
Message-ID: <20170915140411.31716-3-romain.izard.pro@gmail.com>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170915140411.31716-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

The contents of the System Clock Status Register (SCSR) needs to be
restored into the System Clock Enable Register (SCER).

As the bootloader will restore some clocks by itself, the issue can be
missed as only the USB controller, the LCD controller, the Image Sensor
controller and the programmable clocks will be impacted.

Fix the obvious typo in the suspend/resume code, as the IMR register
does not need to be saved twice.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 5c2b26de303e..07dc2861ad3f 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -86,7 +86,7 @@ static int pmc_suspend(void)
 {
 	int i;
 
-	regmap_read(pmcreg, AT91_PMC_IMR, &pmc_cache.scsr);
+	regmap_read(pmcreg, AT91_PMC_SCSR, &pmc_cache.scsr);
 	regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
 	regmap_read(pmcreg, AT91_CKGR_UCKR, &pmc_cache.uckr);
 	regmap_read(pmcreg, AT91_CKGR_MOR, &pmc_cache.mor);
@@ -129,7 +129,7 @@ static void pmc_resume(void)
 	if (pmc_cache.pllar != tmp)
 		pr_warn("PLLAR was not configured properly by the firmware\n");
 
-	regmap_write(pmcreg, AT91_PMC_IMR, pmc_cache.scsr);
+	regmap_write(pmcreg, AT91_PMC_SCER, pmc_cache.scsr);
 	regmap_write(pmcreg, AT91_PMC_PCER, pmc_cache.pcsr0);
 	regmap_write(pmcreg, AT91_CKGR_UCKR, pmc_cache.uckr);
 	regmap_write(pmcreg, AT91_CKGR_MOR, pmc_cache.mor);
-- 
2.11.0
