From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v1 03/10] clk: at91: pmc: Support backup for programmable clocks
Date: Fri,  8 Sep 2017 17:35:57 +0200
Message-ID: <20170908153604.28383-4-romain.izard.pro@gmail.com>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20170908153604.28383-1-romain.izard.pro@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Jonathan Cameron <jic23@kernel.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Romain Izard <romain.izard@mobile-devices.fr>, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: Romain Izard <romain.izard@mobile-devices.fr>

Save and restore the System Clock and Programmable Clock register for
the backup use case.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/clk/at91/pmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 07dc2861ad3f..5421b03553ec 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -66,6 +66,7 @@ static struct
 	u32 pcr[PMC_MAX_IDS];
 	u32 audio_pll0;
 	u32 audio_pll1;
+	u32 pckr[3];
 } pmc_cache;
 
 void pmc_register_id(u8 id)
@@ -103,6 +104,8 @@ static int pmc_suspend(void)
 		regmap_read(pmcreg, AT91_PMC_PCR,
 			    &pmc_cache.pcr[registered_ids[i]]);
 	}
+	for (i = 0; i < 3; i++)
+		regmap_read(pmcreg, AT91_PMC_PCKR(i), &pmc_cache.pckr[i]);
 
 	return 0;
 }
@@ -143,6 +146,8 @@ static void pmc_resume(void)
 			     pmc_cache.pcr[registered_ids[i]] |
 			     AT91_PMC_PCR_CMD);
 	}
+	for (i = 0; i < 3; i++)
+		regmap_write(pmcreg, AT91_PMC_PCKR(i), pmc_cache.pckr[i]);
 
 	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
 		mask |= AT91_PMC_LOCKU;
-- 
2.11.0
