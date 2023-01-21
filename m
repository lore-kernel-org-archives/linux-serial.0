Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F7C004D4
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 15:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjAUPh0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAUPhP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 10:37:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1BC2CC62
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:37:02 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kt14so20876814ejc.3
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5v/xKpmgx3IRd85qrBv3zwjvdUmTrkcJb9ZlFLMDeA=;
        b=VHBApdFOPZlOveIj1sbYZ2BXz/eudd82xyd28Uk6eQ3ZM9AMJ7E1Hmy0JsbMflSpAa
         wcaWe+Xta+zgbBmhWusTulf46g/Nf6EOxW1pE4lA4PFZ44e3d3+1f0Kj1U7GN7+CytlR
         ywwnyseDKSetNt7P8XnsQP/qd+lf3By1EDIaZ2D26fjlPGOk/mqXNLOiMpgKHQwO4V2a
         imf8X4tZpBwVumCswjMlZMPXCHThQZvcuy2i3qFb6V00wpZ8lMntAleJKUu1JdaKaIhQ
         xi0noeO22vZXEQ5ZocSXAIUUsMJWK9lRaF7Vk07hg+83PxnGjW8Na7PkJWrrWnYugja+
         pPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5v/xKpmgx3IRd85qrBv3zwjvdUmTrkcJb9ZlFLMDeA=;
        b=okvMF9NS9onqClMUlquncZLxj+iuMMNsZsoKCoFB3o5EiMXQT7yqb22hZ44kQh3slg
         XYzclkkPWhRfDG1HzsoBRNXC8Ko0cR8ka1APBPEZRGpx9O3fj7gkKgV/xoklRUQJR2is
         yCzao0eV+lAmRnMbZMd8MTWUCtXJpU6s+m8acIEqoTGUpKr9ws0CcZJby6gzqcLBBx1q
         ShiI6kSzBx8ENP7mCMdt8wFeEnJtsRvhvqYQXlptGq5ux4dRo9TjolZ1iYw16yBr0bfU
         VfQJrIZif+zxzXFOGv7nt2HJI6lJr8HCUq9LIq7b8zpQ9g9R2CbPphfBLQAkUSrogA5v
         7U9g==
X-Gm-Message-State: AFqh2kp64F/COPvcaPa3Qi47jka36EpfLydJ9wApWhfUea3gnxhu/Yt8
        kU8HxtS2PY87MrmNc866HMtyjNgo5yQ=
X-Google-Smtp-Source: AMrXdXuSrQSmLVE+LDC1ygBKS7TGV/TZreUIwxcgMvbeTLF5GCi5bkAkPQJ55dKBfGfvBmRu3dUFcw==
X-Received: by 2002:a17:906:fad4:b0:7c1:2529:b25e with SMTP id lu20-20020a170906fad400b007c12529b25emr19869516ejb.43.1674315420658;
        Sat, 21 Jan 2023 07:37:00 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id vc10-20020a170907d08a00b008717a377125sm8187030ejc.85.2023.01.21.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 07:37:00 -0800 (PST)
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
Subject: [PATCH v1 6/7] serial: imx: stop using USR2 in FIFO reading loop
Date:   Sat, 21 Jan 2023 18:36:38 +0300
Message-Id: <20230121153639.15402-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121153639.15402-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230121153639.15402-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The chip provides all the needed bits in the URXD0 register that we read
anyway for data, so get rid of reading USR2 and use only URXD0 bits
instead.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index af4349fe6970..488d8119562e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -892,27 +892,21 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 	struct tty_port *port = &sport->port.state->port;
 	u32 usr2;
 
-	usr2 = imx_uart_readl(sport, USR2);
-
 	/* If we received something, check for 0xff flood */
+	usr2 = imx_uart_readl(sport, USR2);
 	if (usr2 & USR2_RDR)
 		imx_uart_check_flood(sport, usr2);
 
-	for ( ; usr2 & USR2_RDR; usr2 = imx_uart_readl(sport, USR2)) {
+	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
 		flg = TTY_NORMAL;
 		sport->port.icount.rx++;
 
-		rx = imx_uart_readl(sport, URXD0);
-
-		if (usr2 & USR2_BRCD) {
-			imx_uart_writel(sport, USR2_BRCD, USR2);
-			if (uart_handle_break(&sport->port))
-				continue;
-		}
-
 		if (unlikely(rx & URXD_ERR)) {
-			if (rx & URXD_BRK)
+			if (rx & URXD_BRK) {
 				sport->port.icount.brk++;
+				if (uart_handle_break(&sport->port))
+					continue;
+			}
 			else if (rx & URXD_PRERR)
 				sport->port.icount.parity++;
 			else if (rx & URXD_FRMERR)
-- 
2.30.1

