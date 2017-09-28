From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v4 1/8] clk: at91: pmc: Wait for clocks when resuming
Date: Thu, 28 Sep 2017 11:46:20 +0200
Message-ID: <20170928094627.31017-2-romain.izard.pro@gmail.com>
References: <20170928094627.31017-1-romain.izard.pro@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20170928094627.31017-1-romain.izard.pro@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alan Stern <stern@rowland.harvard.edu>, Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Ale
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

Wait for the syncronization of all clocks when resuming, not only the
UPLL clock. Do not use regmap_read_poll_timeout, as it will call BUG()
when interrupts are masked, which is the case in here.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/pmc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 775af473fe11..5c2b26de303e 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -107,10 +107,20 @@ static int pmc_suspend(void)
 	return 0;
 }
 
+static bool pmc_ready(unsigned int mask)
+{
+	unsigned int status;
+
+	regmap_read(pmcreg, AT91_PMC_SR, &status);
+
+	return ((status & mask) == mask) ? 1 : 0;
+}
+
 static void pmc_resume(void)
 {
-	int i, ret = 0;
+	int i;
 	u32 tmp;
+	u32 mask = AT91_PMC_MCKRDY | AT91_PMC_LOCKA;
 
 	regmap_read(pmcreg, AT91_PMC_MCKR, &tmp);
 	if (pmc_cache.mckr != tmp)
@@ -134,13 +144,11 @@ static void pmc_resume(void)
 			     AT91_PMC_PCR_CMD);
 	}
 
-	if (pmc_cache.uckr & AT91_PMC_UPLLEN) {
-		ret = regmap_read_poll_timeout(pmcreg, AT91_PMC_SR, tmp,
-					       !(tmp & AT91_PMC_LOCKU),
-					       10, 5000);
-		if (ret)
-			pr_crit("USB PLL didn't lock when resuming\n");
-	}
+	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
+		mask |= AT91_PMC_LOCKU;
+
+	while (!pmc_ready(mask))
+		cpu_relax();
 }
 
 static struct syscore_ops pmc_syscore_ops = {
-- 
2.11.0
