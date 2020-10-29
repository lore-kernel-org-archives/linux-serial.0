Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADF5C2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F7D20782
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MA09L/Oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgJ2LyV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:54:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37356 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgJ2LyV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:54:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09T5JYL3121768;
        Thu, 29 Oct 2020 00:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603948774;
        bh=ZByVPzkHmsKvUvCnhCpfP8mAajrWcyo1gasXudSIqG8=;
        h=From:To:CC:Subject:Date;
        b=MA09L/OqvvTObcLxCACI2zfE1drOrc+z89DDSsLjhCXr0b+SsdzNyAvSXYOEqb9gv
         K+u1dronAcRc5sjCIhGQomraFvrsuMYxiOkMOSQY1BU69u4L5/LS8p6qlIP/8bENOH
         tF1+4t4HD9SBRC4xZyNaTSJfaGMKiDD77SiUE9bs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09T5JYKw015004
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 00:19:34 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 29
 Oct 2020 00:19:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 29 Oct 2020 00:19:34 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09T5JVOA027985;
        Thu, 29 Oct 2020 00:19:32 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: 8250: 8250_omap: Disable RX interrupt after DMA enable
Date:   Thu, 29 Oct 2020 10:49:30 +0530
Message-ID: <20201029051930.7097-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

UARTs on TI SoCs prior to J7200 don't provide independent control over
RX FIFO not empty interrupt (RHR_IT) and RX timeout interrupt.
Starting with J7200 SoC, its possible to disable RHR_IT independent of
RX timeout interrupt using bit 2 of IER2 register. So disable RHR_IT
once RX DMA is started so as to avoid spurious interrupt being raised
when data is in the RX FIFO but is yet to be drained by DMA (a known
errata in older SoCs).

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 42 ++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 562087df7d33..084e7bc51f0e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -27,6 +27,7 @@
 #include <linux/pm_qos.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
+#include <linux/sys_soc.h>
 
 #include "8250.h"
 
@@ -41,6 +42,7 @@
  */
 #define UART_ERRATA_CLOCK_DISABLE	(1 << 3)
 #define	UART_HAS_EFR2			BIT(4)
+#define UART_HAS_RHR_IT_DIS		BIT(5)
 
 #define OMAP_UART_FCR_RX_TRIG		6
 #define OMAP_UART_FCR_TX_TRIG		4
@@ -94,6 +96,10 @@
 #define OMAP_UART_REV_52 0x0502
 #define OMAP_UART_REV_63 0x0603
 
+/* Interrupt Enable Register 2 */
+#define UART_OMAP_IER2			0x1B
+#define UART_OMAP_IER2_RHR_IT_DIS	BIT(2)
+
 /* Enhanced features register 2 */
 #define UART_OMAP_EFR2			0x23
 #define UART_OMAP_EFR2_TIMEOUT_BEHAVE	BIT(6)
@@ -761,17 +767,27 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma    *dma = p->dma;
 	struct tty_port         *tty_port = &p->port.state->port;
+	struct omap8250_priv	*priv = p->port.private_data;
 	struct dma_chan		*rxchan = dma->rxchan;
 	dma_cookie_t		cookie;
 	struct dma_tx_state     state;
 	int                     count;
 	int			ret;
+	u32			reg;
 
 	if (!dma->rx_running)
 		goto out;
 
 	cookie = dma->rx_cookie;
 	dma->rx_running = 0;
+
+	/* Re-enable RX FIFO interrupt now that transfer is complete */
+	if (priv->habit & UART_HAS_RHR_IT_DIS) {
+		reg = serial_in(p, UART_OMAP_IER2);
+		reg &= ~UART_OMAP_IER2_RHR_IT_DIS;
+		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+	}
+
 	dmaengine_tx_status(rxchan, cookie, &state);
 
 	count = dma->rx_size - state.residue + state.in_flight_bytes;
@@ -867,6 +883,7 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 	int				err = 0;
 	struct dma_async_tx_descriptor  *desc;
 	unsigned long			flags;
+	u32				reg;
 
 	if (priv->rx_dma_broken)
 		return -EINVAL;
@@ -902,6 +919,17 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 
 	dma->rx_cookie = dmaengine_submit(desc);
 
+	/*
+	 * Disable RX FIFO interrupt while RX DMA is enabled, else
+	 * spurious interrupt may be raised when data is in the RX FIFO
+	 * but is yet to be drained by DMA.
+	 */
+	if (priv->habit & UART_HAS_RHR_IT_DIS) {
+		reg = serial_in(p, UART_OMAP_IER2);
+		reg |= UART_OMAP_IER2_RHR_IT_DIS;
+		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+	}
+
 	dma_async_issue_pending(dma->rxchan);
 out:
 	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
@@ -1168,6 +1196,11 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 	return 0;
 }
 
+static const struct soc_device_attribute k3_soc_devices[] = {
+	{ .family = "AM65X",  },
+	{ .family = "J721E", .revision = "SR1.0" },
+};
+
 static struct omap8250_dma_params am654_dma = {
 	.rx_size = SZ_2K,
 	.rx_trigger = 1,
@@ -1182,7 +1215,7 @@ static struct omap8250_dma_params am33xx_dma = {
 
 static struct omap8250_platdata am654_platdata = {
 	.dma_params	= &am654_dma,
-	.habit		= UART_HAS_EFR2,
+	.habit		= UART_HAS_EFR2 | UART_HAS_RHR_IT_DIS,
 };
 
 static struct omap8250_platdata am33xx_platdata = {
@@ -1372,6 +1405,13 @@ static int omap8250_probe(struct platform_device *pdev)
 			up.dma->rxconf.src_maxburst = RX_TRIGGER;
 			up.dma->txconf.dst_maxburst = TX_TRIGGER;
 		}
+
+		/*
+		 * AM65x SR1.0, AM65x SR2.0 and J721e SR1.0 don't
+		 * don't have RHR_IT_DIS bit in IER2 register
+		 */
+		if (soc_device_match(k3_soc_devices))
+			priv->habit &= ~UART_HAS_RHR_IT_DIS;
 	}
 #endif
 	ret = serial8250_register_8250_port(&up);
-- 
2.29.0

