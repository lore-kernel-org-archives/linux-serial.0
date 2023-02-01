Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85FAC636D3
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBAO1p (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjBAO1l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 09:27:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4D8677BB
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 06:27:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u21so17861174edv.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2023 06:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGRQXniAfmCVOhEPry8KBc9X4/FRyELFse0MGdO3NRc=;
        b=SGbmN2t4hYYb3e3VPWT+ES5NcVhUe3+2eOBFVLTN0GQflDQLSehKJBKsv2KfOvPbZY
         0/UApKMQKKQqpT4Dt5lw8QwWQpE9rPUufUNuXIWDwyti17Av1wHlOCHKbcQY+dFGtok+
         rBrYjErKtcv0Y9uhyZYZyYW+QSwa8woXH2QA2609DWTA1VUzclsqrxsTBhNN0RrhIxes
         eSdrqteqm/UA0wPwrnF5PlBLO/8neabvp1+Y8016vW/jkaV2VXYWm18z2VW3OG+p2WsI
         1Gfll0Gn5YGGrPHqNLbUZAOSFWW7FSPCB8nfQ3EjuYVt268xbV0u1IVb0ur9MBKfigN1
         +t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGRQXniAfmCVOhEPry8KBc9X4/FRyELFse0MGdO3NRc=;
        b=IVPv40FVYXIoasPxacr1kzxz9U0h6NBfJmVfZWgUKFH7fxdNCR1aRIUjBxjiEvx1Ht
         266XbuHVFYksMj/jYbke/bv+CHjc5ja6haiOGTaPmvE6Gk1ZmCGPRQ8pBkgqz3Ct8RwM
         yIa3DnuKPAzXNQODazl81rERiZU7NUDrBX37OnmmuZt3LV0L4OnQ1ctxb5RrRk5zCPn5
         WHGbQ/VY0wT/vzx/vLWog1oBHIf6832EswWf/zXcxL3UPxMOhsOm+gsnwSaTwVAtxhsp
         F0gXZCr7hv/Fcn7Rn8MHFsifckFvoDLznj4ALvKEYsBwnRdD0nysyygWE26+I0Lg+YvX
         9/NA==
X-Gm-Message-State: AO0yUKUcXgHcP9RVl/MmfhhMaMXO+VaNmC9DtAfSB4SG5EuBkQKxfuLC
        BJSjouK+o9wKK8ssRu1oeIE=
X-Google-Smtp-Source: AK7set9iXSdmW3yFrjlGJjCNUYuL6XEWMG+gPdLAsXKGT93ZsVy4zKEc/s9XpHhl7JmYtae67Hw6Ag==
X-Received: by 2002:a05:6402:2c8:b0:4a3:43c1:8435 with SMTP id b8-20020a05640202c800b004a343c18435mr1923504edx.9.1675261658939;
        Wed, 01 Feb 2023 06:27:38 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm8975564edb.79.2023.02.01.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:27:38 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 1/7] serial: imx: factor-out common code to imx_uart_soft_reset()
Date:   Wed,  1 Feb 2023 17:26:54 +0300
Message-Id: <20230201142700.4346-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201142700.4346-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230201142700.4346-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We perform soft reset in 2 places, slightly differently for no sufficient
reasons, so move more generic variant to a function, and re-use the code.

Out of 2 repeat counters, 10 and 100, select 10, as the code works at
interrupts disabled, and in practice the reset happens immediately.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 73 ++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 757825edb0cd..bf222d8568a9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -397,6 +397,39 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
        hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
+/* called with port.lock taken and irqs off */
+static void imx_uart_soft_reset(struct imx_port *sport)
+{
+	int i = 10;
+	u32 ucr2, ubir, ubmr, uts;
+
+	/*
+	 * According to the Reference Manual description of the UART SRST bit:
+	 *
+	 * "Reset the transmit and receive state machines,
+	 * all FIFOs and register USR1, USR2, UBIR, UBMR, UBRC, URXD, UTXD
+	 * and UTS[6-3]".
+	 *
+	 * We don't need to restore the old values from USR1, USR2, URXD and
+	 * UTXD. UBRC is read only, so only save/restore the other three
+	 * registers.
+	 */
+	ubir = imx_uart_readl(sport, UBIR);
+	ubmr = imx_uart_readl(sport, UBMR);
+	uts = imx_uart_readl(sport, IMX21_UTS);
+
+	ucr2 = imx_uart_readl(sport, UCR2);
+	imx_uart_writel(sport, ucr2 & ~UCR2_SRST, UCR2);
+
+	while (!(imx_uart_readl(sport, UCR2) & UCR2_SRST) && (--i > 0))
+		udelay(1);
+
+	/* Restore the registers */
+	imx_uart_writel(sport, ubir, UBIR);
+	imx_uart_writel(sport, ubmr, UBMR);
+	imx_uart_writel(sport, uts, IMX21_UTS);
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -1398,7 +1431,7 @@ static void imx_uart_disable_dma(struct imx_port *sport)
 static int imx_uart_startup(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	int retval, i;
+	int retval;
 	unsigned long flags;
 	int dma_is_inited = 0;
 	u32 ucr1, ucr2, ucr3, ucr4, uts;
@@ -1430,15 +1463,9 @@ static int imx_uart_startup(struct uart_port *port)
 		dma_is_inited = 1;
 
 	spin_lock_irqsave(&sport->port.lock, flags);
+
 	/* Reset fifo's and state machines */
-	i = 100;
-
-	ucr2 = imx_uart_readl(sport, UCR2);
-	ucr2 &= ~UCR2_SRST;
-	imx_uart_writel(sport, ucr2, UCR2);
-
-	while (!(imx_uart_readl(sport, UCR2) & UCR2_SRST) && (--i > 0))
-		udelay(1);
+	imx_uart_soft_reset(sport);
 
 	/*
 	 * Finally, clear and enable interrupts
@@ -1593,8 +1620,6 @@ static void imx_uart_flush_buffer(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	struct scatterlist *sgl = &sport->tx_sgl[0];
-	u32 ucr2;
-	int i = 100, ubir, ubmr, uts;
 
 	if (!sport->dma_chan_tx)
 		return;
@@ -1612,32 +1637,8 @@ static void imx_uart_flush_buffer(struct uart_port *port)
 		sport->dma_is_txing = 0;
 	}
 
-	/*
-	 * According to the Reference Manual description of the UART SRST bit:
-	 *
-	 * "Reset the transmit and receive state machines,
-	 * all FIFOs and register USR1, USR2, UBIR, UBMR, UBRC, URXD, UTXD
-	 * and UTS[6-3]".
-	 *
-	 * We don't need to restore the old values from USR1, USR2, URXD and
-	 * UTXD. UBRC is read only, so only save/restore the other three
-	 * registers.
-	 */
-	ubir = imx_uart_readl(sport, UBIR);
-	ubmr = imx_uart_readl(sport, UBMR);
-	uts = imx_uart_readl(sport, IMX21_UTS);
+	imx_uart_soft_reset(sport);
 
-	ucr2 = imx_uart_readl(sport, UCR2);
-	ucr2 &= ~UCR2_SRST;
-	imx_uart_writel(sport, ucr2, UCR2);
-
-	while (!(imx_uart_readl(sport, UCR2) & UCR2_SRST) && (--i > 0))
-		udelay(1);
-
-	/* Restore the registers */
-	imx_uart_writel(sport, ubir, UBIR);
-	imx_uart_writel(sport, ubmr, UBMR);
-	imx_uart_writel(sport, uts, IMX21_UTS);
 }
 
 static void
-- 
2.30.1

