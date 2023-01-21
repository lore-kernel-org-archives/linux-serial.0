Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E741C004D4
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 15:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjAUPhP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjAUPhO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 10:37:14 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2592CFC3
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:54 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kt14so20876297ejc.3
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGRQXniAfmCVOhEPry8KBc9X4/FRyELFse0MGdO3NRc=;
        b=Mt91O6wsHDuq9PZCKox9+WJFhgaeFmwcOWWLL/2N5ObZAjE6d+mUtPcre6xI0qeZ1p
         xAGWfUqn3Udu0VA5eFYCZUyV7Qj+nlNrkRgtNbcai4vq5AdxIuNZ2lOUtDMynwzaqZgW
         7TsJnh4kg87opmBIzWtd8mzppl7aNW3YljRDTAY/h6zlff8vhiXopClVfSdEKcQMz98D
         3VMTGsP4So01okN5M47ol8DM3F5en9qQs7dglNXQUSI6hHXK7SG1/aEF8v+T2Dj7Cnd9
         /vZThwN6tTTyo6pYIuCMuoHzRA3Xc9XePRfRCE7s+AfPlHUzm+PFWmhbOw+qXAvjkNEd
         DR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGRQXniAfmCVOhEPry8KBc9X4/FRyELFse0MGdO3NRc=;
        b=JL6eLOafAySIggVoy//BINuWi6UMQTu3hTAXL+22Dxp8YRimhxVk29QcN++3skWcy4
         JqdqFC8mQvxZaZ/t1rH9hu+4Mcx5fx4eu9OUeb7JvZFr18WBo9G2tYzRiglvZwDICvfP
         Jrs8+6Wi0oFZYee3dCm/dS2zOEq/5ufF4zBYJ5kfZ0R3BKdhpYG61vChiAFI6jmp6mfh
         YzxAj6JP1TBIUKlgXJyvtXy+ZOQjrWzknzgK3wip2W8jL4W6PplEC7cahXi9BLMTyEL5
         ntCkFcFbsSz9RVOwoQS+qEzHnMUgaDDekdgNh1JAmKaYb3PCuhXtIIdzEpGuzXM76vWL
         HfhQ==
X-Gm-Message-State: AFqh2kqlv6oeXpnHKieSikrpft9EzN/HhasGn26nND3/6NtcVhfUi4Wq
        er0B3pXcHGYsU5qfiNPaNJkKixhMsoM=
X-Google-Smtp-Source: AMrXdXtubvnAryt3g7C8rOL6o559ps+y9uy/MSBM/mlbKGyY45wWmLQCWCYT6SvaX414gJFU/TGHNg==
X-Received: by 2002:a17:906:3616:b0:870:e329:5f2e with SMTP id q22-20020a170906361600b00870e3295f2emr19580340ejb.20.1674315412643;
        Sat, 21 Jan 2023 07:36:52 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id vc10-20020a170907d08a00b008717a377125sm8187030ejc.85.2023.01.21.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 07:36:52 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 1/7] serial: imx: factor-out common code to imx_uart_soft_reset()
Date:   Sat, 21 Jan 2023 18:36:33 +0300
Message-Id: <20230121153639.15402-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121153639.15402-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230121153639.15402-1-sorganov@gmail.com>
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

