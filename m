Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589EEC54EBD
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 18:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjAMSnq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAMSnp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 13:43:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF33D5E4
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o20so2368034lfk.5
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGRQXniAfmCVOhEPry8KBc9X4/FRyELFse0MGdO3NRc=;
        b=Rwv/g4mCVgRRqLjbB3j4SFDyC98eqLKfVRU6rwsMPyAPKCDOx42i2FyqkSPeODooW5
         cmmkBSIqT1bugkOjdH0Cd2IfTWHwodxdGVhUXUuKLNg2MM/cVsVzo5DXFrXD4xEUyITV
         /O2iEamJmrAXjVhzv75qdTgr0xLSGqauDkq2MqEHBlj5FAZ9nTfXE3dhyuoAORwyfKLC
         BUHSmLS79mS41g9xbnB5XsBPNRAWzfZ72Uu1I292tBdAw6/UkU4SA5Miniwppoijbzh0
         J0mCGuvI/spmgvrPgL5oLGOatPEaLCjWHvnK2UN3ou2A6GpgBQOi0B0voFNfMSRE1q5b
         hUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGRQXniAfmCVOhEPry8KBc9X4/FRyELFse0MGdO3NRc=;
        b=YzQKXGbgkbtAWAu/Aw5/4s1yE1k9rXPGxfKs0rg1D8nb6b4g94iq8ggP/iI9Q4zvyr
         DtUqqXOJWxvWEPDWA0uK6ubPgfdv3+BP/MuNp0D1kO7kh68b2eeKplhHfJ8ymmeidLa8
         OStNyy0DIZmqtD6x0yO5H/yTvxDZpcOUeZ4S20IZA8yGagX5ewerwNst/eSJWkPt/yKu
         jQm4mc80OzBi+Alt1qd2+JS4QgNwD3+D+7b+R7BFEPsP2C46lZ0dPHK1C9yu472K5W77
         evZYOeJDUwaaCJLPwll5zIYnmXwu1G454QUCsxnzJzoXVvuxh3ZZ95WgVEAwkvTo9rXR
         hWRQ==
X-Gm-Message-State: AFqh2kpFB5wTHMgGBKVao7Pigov0wvkha0iQNuhQiutjXH38EFjIjF9J
        mwTz7nT+H0uKCrUeO7FugTNmoLaV4zA=
X-Google-Smtp-Source: AMrXdXtT2Nn4Ju2q6l6VlG1PM1GuIkdCZMI4iPrZK+vUPRefnDla6fN9sRqXX6avbDaz4wtL7X3p/A==
X-Received: by 2002:a05:6512:159b:b0:4b5:9138:145b with SMTP id bp27-20020a056512159b00b004b59138145bmr26918418lfb.14.1673635421844;
        Fri, 13 Jan 2023 10:43:41 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004cc9ddce3adsm1261439lfl.82.2023.01.13.10.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:43:41 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 1/8] serial: imx: factor-out common code to imx_uart_soft_reset()
Date:   Fri, 13 Jan 2023 21:43:27 +0300
Message-Id: <20230113184334.287130-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230113184334.287130-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
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

