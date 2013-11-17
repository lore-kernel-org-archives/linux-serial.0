From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v5 10/17] serial: mpc512x: setup the PSC FIFO clock as well
Date: Mon, 18 Nov 2013 00:06:10 +0100
Message-ID: <1384729577-7336-11-git-send-email-gsi@denx.de>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39901 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab3KQXIW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Nov 2013 18:08:22 -0500
In-Reply-To: <1384729577-7336-1-git-send-email-gsi@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Cc: Scott Wood <scottwood@freescale.com>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

prepare and enable the FIFO clock upon PSC FIFO initialization,
check for and propagage errors when enabling the PSC FIFO clock,
disable and unprepare the FIFO clock upon PSC FIFO uninitialization

devm_{get,put}_clk() doesn't apply here, as the SoC provides a
single FIFO component which is shared among several PSC components,
thus the FIFO isn't associated with a device (while the PSCs are)

provide a fallback clock lookup approach in case the OF based clock
lookup for the PSC FIFO fails, this allows for successful operation in
the presence of an outdated device tree which lacks clock specs

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # for v4
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
Greg, the addition since v4 is the clk_get_sys() call for the 'ipg'
clock item (backwards compat for device trees w/o clock specs)

---
 drivers/tty/serial/mpc52xx_uart.c |   50 ++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 1d1dbe9d5af2..78c8cbadc776 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -421,6 +421,7 @@ struct psc_fifoc {
 
 static struct psc_fifoc __iomem *psc_fifoc;
 static unsigned int psc_fifoc_irq;
+static struct clk *psc_fifoc_clk;
 
 static void mpc512x_psc_fifo_init(struct uart_port *port)
 {
@@ -568,36 +569,73 @@ static unsigned int mpc512x_psc_set_baudrate(struct uart_port *port,
 /* Init PSC FIFO Controller */
 static int __init mpc512x_psc_fifoc_init(void)
 {
+	int err;
 	struct device_node *np;
+	struct clk *clk;
+
+	/* default error code, potentially overwritten by clock calls */
+	err = -ENODEV;
 
 	np = of_find_compatible_node(NULL, NULL,
 				     "fsl,mpc5121-psc-fifo");
 	if (!np) {
 		pr_err("%s: Can't find FIFOC node\n", __func__);
-		return -ENODEV;
+		goto out_err;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		/* backwards compat with device trees that lack clock specs */
+		clk = clk_get_sys(np->name, "ipg");
+	}
+	if (IS_ERR(clk)) {
+		pr_err("%s: Can't lookup FIFO clock\n", __func__);
+		err = PTR_ERR(clk);
+		goto out_ofnode_put;
+	}
+	if (clk_prepare_enable(clk)) {
+		pr_err("%s: Can't enable FIFO clock\n", __func__);
+		clk_put(clk);
+		goto out_ofnode_put;
 	}
+	psc_fifoc_clk = clk;
 
 	psc_fifoc = of_iomap(np, 0);
 	if (!psc_fifoc) {
 		pr_err("%s: Can't map FIFOC\n", __func__);
-		of_node_put(np);
-		return -ENODEV;
+		goto out_clk_disable;
 	}
 
 	psc_fifoc_irq = irq_of_parse_and_map(np, 0);
-	of_node_put(np);
 	if (psc_fifoc_irq == 0) {
 		pr_err("%s: Can't get FIFOC irq\n", __func__);
-		iounmap(psc_fifoc);
-		return -ENODEV;
+		goto out_unmap;
 	}
 
+	of_node_put(np);
 	return 0;
+
+out_unmap:
+	iounmap(psc_fifoc);
+out_clk_disable:
+	clk_disable_unprepare(psc_fifoc_clk);
+	clk_put(psc_fifoc_clk);
+out_ofnode_put:
+	of_node_put(np);
+out_err:
+	return err;
 }
 
 static void __exit mpc512x_psc_fifoc_uninit(void)
 {
 	iounmap(psc_fifoc);
+
+	/* disable the clock, errors are not fatal */
+	if (psc_fifoc_clk) {
+		clk_disable_unprepare(psc_fifoc_clk);
+		clk_put(psc_fifoc_clk);
+		psc_fifoc_clk = NULL;
+	}
 }
 
 /* 512x specific interrupt handler. The caller holds the port lock */
-- 
1.7.10.4

