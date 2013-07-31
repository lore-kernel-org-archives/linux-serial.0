From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/4] serial: sccnxp: Using CLK API for getting UART clock
Date: Wed, 31 Jul 2013 14:56:30 +0400
Message-ID: <1375268191-13428-2-git-send-email-shc_work@mail.ru>
References: <1375268191-13428-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp33.i.mail.ru ([94.100.177.93]:40944 "EHLO smtp33.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755605Ab3GaK4j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Jul 2013 06:56:39 -0400
In-Reply-To: <1375268191-13428-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch removes "frequency" parameter from SCCNXP platform_data
and uses CLK API for getting clock. If CLK ommited, default IC
frequency will be used instead.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/mips/sni/a20r.c                        |  1 -
 drivers/tty/serial/sccnxp.c                 | 36 ++++++++++++++++++-----------
 include/linux/platform_data/serial-sccnxp.h |  3 ---
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/mips/sni/a20r.c b/arch/mips/sni/a20r.c
index dd0ab98..f9407e1 100644
--- a/arch/mips/sni/a20r.c
+++ b/arch/mips/sni/a20r.c
@@ -122,7 +122,6 @@ static struct resource sc26xx_rsrc[] = {
 
 static struct sccnxp_pdata sccnxp_data = {
 	.reg_shift	= 2,
-	.frequency	= 3686400,
 	.mctrl_cfg[0]	= MCTRL_SIG(DTR_OP, LINE_OP7) |
 			  MCTRL_SIG(RTS_OP, LINE_OP3) |
 			  MCTRL_SIG(DSR_IP, LINE_IP5) |
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 12a5c26..81e7047 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -15,6 +15,7 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -783,9 +784,10 @@ static int sccnxp_probe(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int chiptype = pdev->id_entry->driver_data;
 	struct sccnxp_pdata *pdata = dev_get_platdata(&pdev->dev);
-	int i, ret, fifosize, freq_min, freq_max;
+	int i, ret, fifosize, freq_min, freq_max, uartclk;
 	struct sccnxp_port *s;
 	void __iomem *membase;
+	struct clk *clk;
 
 	membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(membase))
@@ -898,11 +900,25 @@ static int sccnxp_probe(struct platform_device *pdev)
 	} else if (PTR_ERR(s->regulator) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	if (!pdata) {
-		dev_warn(&pdev->dev,
-			 "No platform data supplied, using defaults\n");
-		s->pdata.frequency = s->freq_std;
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		if (PTR_ERR(clk) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_out;
+		}
+		dev_notice(&pdev->dev, "Using default clock frequency\n");
+		uartclk = s->freq_std;
 	} else
+		uartclk = clk_get_rate(clk);
+
+	/* Check input frequency */
+	if ((uartclk < freq_min) || (uartclk > freq_max)) {
+		dev_err(&pdev->dev, "Frequency out of bounds\n");
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (pdata)
 		memcpy(&s->pdata, pdata, sizeof(struct sccnxp_pdata));
 
 	if (s->pdata.poll_time_us) {
@@ -920,14 +936,6 @@ static int sccnxp_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Check input frequency */
-	if ((s->pdata.frequency < freq_min) ||
-	    (s->pdata.frequency > freq_max)) {
-		dev_err(&pdev->dev, "Frequency out of bounds\n");
-		ret = -EINVAL;
-		goto err_out;
-	}
-
 	s->uart.owner		= THIS_MODULE;
 	s->uart.dev_name	= "ttySC";
 	s->uart.major		= SCCNXP_MAJOR;
@@ -959,7 +967,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 		s->port[i].mapbase	= res->start;
 		s->port[i].membase	= membase;
 		s->port[i].regshift	= s->pdata.reg_shift;
-		s->port[i].uartclk	= s->pdata.frequency;
+		s->port[i].uartclk	= uartclk;
 		s->port[i].ops		= &sccnxp_ops;
 		uart_add_one_port(&s->uart, &s->port[i]);
 		/* Set direction to input */
diff --git a/include/linux/platform_data/serial-sccnxp.h b/include/linux/platform_data/serial-sccnxp.h
index bdc510d..af0c8c3 100644
--- a/include/linux/platform_data/serial-sccnxp.h
+++ b/include/linux/platform_data/serial-sccnxp.h
@@ -60,7 +60,6 @@
  * };
  *
  * static struct sccnxp_pdata sc2892_info = {
- *	.frequency	= 3686400,
  *	.mctrl_cfg[0]	= MCTRL_SIG(DIR_OP, LINE_OP0),
  *	.mctrl_cfg[1]	= MCTRL_SIG(DIR_OP, LINE_OP1),
  * };
@@ -78,8 +77,6 @@
 
 /* SCCNXP platform data structure */
 struct sccnxp_pdata {
-	/* Frequency (extrenal clock or crystal) */
-	int			frequency;
 	/* Shift for A0 line */
 	const u8		reg_shift;
 	/* Modem control lines configuration */
-- 
1.8.1.5

