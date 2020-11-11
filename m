Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67376C5517A
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 11:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDCE2074B
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 11:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZNjsT5S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgKKL1H (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:27:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44332 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgKKL1D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Nov 2020 06:27:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ABBQxYs011819;
        Wed, 11 Nov 2020 05:26:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605094019;
        bh=Hh+jDkF3giVGi/vYUSRN6JLLmVGAiVoDwWr3Matv26M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZNjsT5S4RT8K+0KUcgzSJ3SvTMjxHGScI1woE3Q5tjT3KgDCMXSOz+R/xSrqTEVXi
         upC4lyZOrU73kG4AfUvAB9LD8LP8HZTuLFfQN2+yi+H1gHQ1xAmB2lrHTuLdLM1xvV
         r3akqygfdSvxxTKA2IAIM9zgi4gEOrtWBLhboE/o=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ABBQxUG003515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 05:26:59 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 05:26:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 05:26:59 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ABBQsLC076461;
        Wed, 11 Nov 2020 05:26:57 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] serial: 8250: 8250_omap: Fix unused variable warning
Date:   Wed, 11 Nov 2020 16:56:53 +0530
Message-ID: <20201111112653.2710-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111112653.2710-1-vigneshr@ti.com>
References: <20201111112653.2710-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

With commit 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX interrupt after DMA enable"),
below warning is seen with W=1 and CONFIG_SERIAL_8250_DMA is disabled:

   drivers/tty/serial/8250/8250_omap.c:1199:42: warning: unused variable 'k3_soc_devices' [-Wunused-const-variable]

Fix this by moving the code using k3_soc_devices array to
omap_serial_fill_features_erratas() that handles other errata flags as
well.

Fixes: 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX interrupt after DMA enable")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ab18ef035659..0ab6517d389a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -539,6 +539,11 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
 					      struct omap8250_priv *priv)
 {
+	const struct soc_device_attribute k3_soc_devices[] = {
+		{ .family = "AM65X",  },
+		{ .family = "J721E", .revision = "SR1.0" },
+		{ /* sentinel */ }
+	};
 	u32 mvr, scheme;
 	u16 revision, major, minor;
 
@@ -586,6 +591,14 @@ static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
 	default:
 		break;
 	}
+
+	/*
+	 * AM65x SR1.0, AM65x SR2.0 and J721e SR1.0 don't
+	 * don't have RHR_IT_DIS bit in IER2 register. So drop to flag
+	 * to enable errata workaround.
+	 */
+	if (soc_device_match(k3_soc_devices))
+		priv->habit &= ~UART_HAS_RHR_IT_DIS;
 }
 
 static void omap8250_uart_qos_work(struct work_struct *work)
@@ -1196,12 +1209,6 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 	return 0;
 }
 
-static const struct soc_device_attribute k3_soc_devices[] = {
-	{ .family = "AM65X",  },
-	{ .family = "J721E", .revision = "SR1.0" },
-	{ /* sentinel */ }
-};
-
 static struct omap8250_dma_params am654_dma = {
 	.rx_size = SZ_2K,
 	.rx_trigger = 1,
@@ -1406,13 +1413,6 @@ static int omap8250_probe(struct platform_device *pdev)
 			up.dma->rxconf.src_maxburst = RX_TRIGGER;
 			up.dma->txconf.dst_maxburst = TX_TRIGGER;
 		}
-
-		/*
-		 * AM65x SR1.0, AM65x SR2.0 and J721e SR1.0 don't
-		 * don't have RHR_IT_DIS bit in IER2 register
-		 */
-		if (soc_device_match(k3_soc_devices))
-			priv->habit &= ~UART_HAS_RHR_IT_DIS;
 	}
 #endif
 	ret = serial8250_register_8250_port(&up);
-- 
2.29.2

