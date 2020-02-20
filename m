Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECD5C11D19
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB4124673
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="cDCt7jnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgBTRxo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:53:44 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34963 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgBTRxn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:43 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 94A8E23E21;
        Thu, 20 Feb 2020 18:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582220631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VX93nZn2AbWIOGGDfDdsClKAztru9C3qnY5D3he52bw=;
        b=cDCt7jnC4VKlq9HGutGVibkiup/IUCb8KB/wnuxDrXB30Jw3H00si0tX67se4NzuV0Z49w
        KDJhPXTqsDqCm6/uJ9Nmk2QWnZRfhyopcMxgBefPINOf0lc4O26E+d+vi7dpcThSV+q3uW
        oUHhg4fU7Dgi770ylP07Ke00Wu4Ge50=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/7] tty: serial: fsl_lpuart: free IDs allocated by IDA
Date:   Thu, 20 Feb 2020 18:43:29 +0100
Message-Id: <20200220174334.23322-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220174334.23322-1-michael@walle.cc>
References: <20200220174334.23322-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 94A8E23E21
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.462];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit 3bc3206e1c0f ("serial: fsl_lpuart: Remove the alias node
dependence") the port line number can also be allocated by IDA, but in
case of an error the ID will no be removed again. More importantly, any
ID will be freed in remove(), even if it wasn't allocated but instead
fetched by of_alias_get_id(). If it was not allocated by IDA there will
be a warning:
  WARN(1, "ida_free called for id=%d which is not allocated.\n", id);

Move the ID allocation more to the end of the probe() so that we still
can use plain return in the first error cases.

Fixes: 3bc3206e1c0f ("serial: fsl_lpuart: Remove the alias node dependence")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 39 ++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 27fdc131c352..c31b8f3db6bf 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -264,6 +264,7 @@ struct lpuart_port {
 	int			rx_dma_rng_buf_len;
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
+	bool			id_allocated;
 };
 
 struct lpuart_soc_data {
@@ -2422,19 +2423,6 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (!sport)
 		return -ENOMEM;
 
-	ret = of_alias_get_id(np, "serial");
-	if (ret < 0) {
-		ret = ida_simple_get(&fsl_lpuart_ida, 0, UART_NR, GFP_KERNEL);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "port line is full, add device failed\n");
-			return ret;
-		}
-	}
-	if (ret >= ARRAY_SIZE(lpuart_ports)) {
-		dev_err(&pdev->dev, "serial%d out of range\n", ret);
-		return -EINVAL;
-	}
-	sport->port.line = ret;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(sport->port.membase))
@@ -2479,9 +2467,25 @@ static int lpuart_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		ret = ida_simple_get(&fsl_lpuart_ida, 0, UART_NR, GFP_KERNEL);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "port line is full, add device failed\n");
+			return ret;
+		}
+		sport->id_allocated = true;
+	}
+	if (ret >= ARRAY_SIZE(lpuart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", ret);
+		ret = -EINVAL;
+		goto failed_out_of_range;
+	}
+	sport->port.line = ret;
+
 	ret = lpuart_enable_clks(sport);
 	if (ret)
-		return ret;
+		goto failed_clock_enable;
 	sport->port.uartclk = lpuart_get_baud_clk_rate(sport);
 
 	lpuart_ports[sport->port.line] = sport;
@@ -2531,6 +2535,10 @@ static int lpuart_probe(struct platform_device *pdev)
 failed_attach_port:
 failed_irq_request:
 	lpuart_disable_clks(sport);
+failed_clock_enable:
+failed_out_of_range:
+	if (sport->id_allocated)
+		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
 	return ret;
 }
 
@@ -2540,7 +2548,8 @@ static int lpuart_remove(struct platform_device *pdev)
 
 	uart_remove_one_port(&lpuart_reg, &sport->port);
 
-	ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
+	if (sport->id_allocated)
+		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
 
 	lpuart_disable_clks(sport);
 
-- 
2.20.1

