From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v3 3/8] clk: at91: pmc: Support backup for programmable clocks
Date: Wed, 27 Sep 2017 10:35:50 +0200
Message-ID: <20170927083555.16580-4-romain.izard.pro@gmail.com>
References: <20170927083555.16580-1-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170927083555.16580-1-romain.izard.pro@gmail.com>
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
Cc: linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org, Romain Izard <romain.izard@mobile-devices.fr>, Romain Izard <romain.izard.pro@gmail.com>, linux-clk@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Romain Izard <romain.izard@mobile-devices.fr>

When an AT91 programmable clock is declared in the device tree, register
it into the Power Management Controller driver. On entering suspend mode,
the driver saves and restores the Programmable Clock registers to support
the backup mode for these clocks.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changes in v2:
* register PCKs on clock startup
Chnages in v3:
* improve comments on hanling 0 in pmc_register_id and pmc_register_pck
* declare local variables earlier for checkpatch

 drivers/clk/at91/clk-programmable.c |  2 ++
 drivers/clk/at91/pmc.c              | 35 +++++++++++++++++++++++++++++++++++
 drivers/clk/at91/pmc.h              |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 85a449cf61e3..0e6aab1252fc 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -204,6 +204,8 @@ at91_clk_register_programmable(struct regmap *regmap,
 	if (ret) {
 		kfree(prog);
 		hw = ERR_PTR(ret);
+	} else {
+		pmc_register_pck(id);
 	}
 
 	return hw;
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 07dc2861ad3f..1fa27f4ea538 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -22,6 +22,7 @@
 #include "pmc.h"
 
 #define PMC_MAX_IDS 128
+#define PMC_MAX_PCKS 8
 
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range)
@@ -50,6 +51,7 @@ EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
 static struct regmap *pmcreg;
 
 static u8 registered_ids[PMC_MAX_IDS];
+static u8 registered_pcks[PMC_MAX_PCKS];
 
 static struct
 {
@@ -66,8 +68,13 @@ static struct
 	u32 pcr[PMC_MAX_IDS];
 	u32 audio_pll0;
 	u32 audio_pll1;
+	u32 pckr[PMC_MAX_PCKS];
 } pmc_cache;
 
+/*
+ * As Peripheral ID 0 is invalid on AT91 chips, the identifier is stored
+ * without alteration in the table, and 0 is for unused clocks.
+ */
 void pmc_register_id(u8 id)
 {
 	int i;
@@ -82,9 +89,28 @@ void pmc_register_id(u8 id)
 	}
 }
 
+/*
+ * As Programmable Clock 0 is valid on AT91 chips, there is an offset
+ * of 1 between the stored value and the real clock ID.
+ */
+void pmc_register_pck(u8 pck)
+{
+	int i;
+
+	for (i = 0; i < PMC_MAX_PCKS; i++) {
+		if (registered_pcks[i] == 0) {
+			registered_pcks[i] = pck + 1;
+			break;
+		}
+		if (registered_pcks[i] == (pck + 1))
+			break;
+	}
+}
+
 static int pmc_suspend(void)
 {
 	int i;
+	u8 num;
 
 	regmap_read(pmcreg, AT91_PMC_SCSR, &pmc_cache.scsr);
 	regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
@@ -103,6 +129,10 @@ static int pmc_suspend(void)
 		regmap_read(pmcreg, AT91_PMC_PCR,
 			    &pmc_cache.pcr[registered_ids[i]]);
 	}
+	for (i = 0; registered_pcks[i]; i++) {
+		num = registered_pcks[i] - 1;
+		regmap_read(pmcreg, AT91_PMC_PCKR(num), &pmc_cache.pckr[num]);
+	}
 
 	return 0;
 }
@@ -119,6 +149,7 @@ static bool pmc_ready(unsigned int mask)
 static void pmc_resume(void)
 {
 	int i;
+	u8 num;
 	u32 tmp;
 	u32 mask = AT91_PMC_MCKRDY | AT91_PMC_LOCKA;
 
@@ -143,6 +174,10 @@ static void pmc_resume(void)
 			     pmc_cache.pcr[registered_ids[i]] |
 			     AT91_PMC_PCR_CMD);
 	}
+	for (i = 0; registered_pcks[i]; i++) {
+		num = registered_pcks[i] - 1;
+		regmap_write(pmcreg, AT91_PMC_PCKR(num), pmc_cache.pckr[num]);
+	}
 
 	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
 		mask |= AT91_PMC_LOCKU;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 858e8ef7e8db..d22b1fa9ecdc 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -31,8 +31,10 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
 
 #ifdef CONFIG_PM
 void pmc_register_id(u8 id);
+void pmc_register_pck(u8 pck);
 #else
 static inline void pmc_register_id(u8 id) {}
+static inline void pmc_register_pck(u8 pck) {}
 #endif
 
 #endif /* __PMC_H_ */
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
