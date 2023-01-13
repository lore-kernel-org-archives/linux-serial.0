Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51C3C3DA78
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 18:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjAMSoV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjAMSoF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 13:44:05 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DBC32EA1
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:53 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so34307948lfa.9
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv7yYu+svGwVLgS8wyxzW693EiE4HtsBGRbigAy1MWs=;
        b=CP0QKj9lJa+BeUqD8mjzJAzZER4o144dB1FKlqUxhlS8kvXAxLI1Zx0PSlEwZxhtpz
         A1HItOSE1W9IH0lAmNpXNdj5aXi+Jz3NXTWPeqfhJqrykhBMM8HcMPiSM1INLAp0Dksu
         N+t/ZsVCAiUJmkuv2QdCm+8qC22E0xZg+HB2GCsdIRSpXNlinC16hWmm9gAJrhAlKQxU
         ay0wMGuX63vB0rXHiNQv230xrMgyLGz+vNUHCRkdUdbH1iO1v6VRAHsVN4G3RJhlpZGe
         3Gs8pau5Tq1YiQ+/mYwyg4MfAS0eQd+TupXow1yPoP790TblXOt0ELIH1HOwtbarFusq
         IbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv7yYu+svGwVLgS8wyxzW693EiE4HtsBGRbigAy1MWs=;
        b=m7V58f8TtGzChoD28W4iYVzUDsGCLn0F71GIKv50koSKhJVpSoSxAZ7VnL42c77WA0
         k/qlvXmuHs2Xrh+z0XF0bmBn6J4qc6og4cDT/8P52v6Pp2wM74nPZ3akW7gwtV6GfY7L
         m58uhHoOoTOR5yfFNyG2z7rmoKbiAR310+GZcXgxdTJk8OIXhbCHz2cfaiy9wu8fGRR8
         0O7YMPnvlwhZ1kt75+l+aANyzqhRX/3RMf+5083HYgME6mfMgrSlyOTBoHhWIgVG0YYi
         7tM90qZjXR5vdAxPWThEXpXWJQ0fEx0ABTnlabTiuR6UTzkss+Af9dQlQoOrJfCQOKwu
         f1Fg==
X-Gm-Message-State: AFqh2krmrB7hj9LVkYqPhK/0ZjP0NvUtcY9zh7PP5+bj15e13I7IiFbG
        mhBWwoRJ/Cp10DMRwGyn/bWKgpX7FdE=
X-Google-Smtp-Source: AMrXdXvt1TMVuja3Y+Zq+MhsrzFa4qgMzz0RT70F2OE4C6YFu2bzKAp9gyGVW7pWlLPpu2ApvjCcEA==
X-Received: by 2002:a05:6512:1597:b0:4b6:f4bb:e53f with SMTP id bp23-20020a056512159700b004b6f4bbe53fmr26621541lfb.60.1673635432565;
        Fri, 13 Jan 2023 10:43:52 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004cc9ddce3adsm1261439lfl.82.2023.01.13.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:43:52 -0800 (PST)
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
Subject: [PATCH 8/8] serial: imx: refine local variables in rxint()
Date:   Fri, 13 Jan 2023 21:43:34 +0300
Message-Id: <20230113184334.287130-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230113184334.287130-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 'rx' is chip register, similar to 'usr2', so let it be of 'u32' type as
well.

Move 'flg' to be FIFO read loop local as it's not used outside.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f4236e8995fa..45327ff6dd14 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -888,10 +888,9 @@ static void imx_uart_check_flood(struct imx_port *sport, u32 usr2)
 static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	unsigned int rx, flg;
 	struct tty_port *port = &sport->port.state->port;
 	typeof(sport->port.membase) membase = sport->port.membase;
-	u32 usr2;
+	u32 usr2, rx;
 
 	/* If we received something, check for 0xff flood */
 	usr2 = readl(membase + USR2);
@@ -899,7 +898,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 		imx_uart_check_flood(sport, usr2);
 
 	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
-		flg = TTY_NORMAL;
+		unsigned int flg = TTY_NORMAL;
 		sport->port.icount.rx++;
 
 		if (unlikely(rx & URXD_ERR)) {
-- 
2.30.1

