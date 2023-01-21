Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52874C25B50
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 15:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjAUPhO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAUPhN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 10:37:13 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7AE2CFD7
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id v6so20849412ejg.6
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbE3Vyz7FEJBJTK44d6toywOKJ/fNH9oM8amuUNHVHc=;
        b=g0IxxXcZdni3MvQefW4X+InxgH/pux2DG02UrrEhp3kc0Q9AT+/HLx1pKQtVzb3NIM
         jhKUriY7zH1SzMS9QYyvWdrZSyvzt1u3mazS95qOkW6hblhQroNHGtXUP77+tN/ybdMD
         vMbR05dEvnEciH8Anw0VVI1gHn/2l3IDGUcqWuX2TLt+ehZaTK9EphUDMWH23qb0jFkT
         wS4f6Vvvm9jcXns1P/zGZlz8Pe//IY4hWHd9D1nNIfc6fkkFNJ09ENd3Lz/+K/OZBiM0
         xAearXVmLrcxxHrf1fCIvQmw8lz90GB33vR7YJoBu8dYoyv7K+qbsr1Hqxq9MeVq85ey
         S3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbE3Vyz7FEJBJTK44d6toywOKJ/fNH9oM8amuUNHVHc=;
        b=6bw0Ozntrg0E9zHB+9Bt5t0yXrkiCWjr4owz7z+CXd/UDVJ5lYCHabTS5fO91m1L7L
         z6Eoc+oVrteGplMsiOyqwzmZ8o1/TlZnTSvQF0TGYFeHQWkUBySTC6Irhy3VH6Fsncql
         OkCKiY1fTbo4+Vh/ZFoA4Q+rxVlfG3xFH1ydt8cW+NZrIMdxLpaYzsP84n98ly9RZqPy
         rNJu9jIXvRMAkvN5Wbjx7l+1T171bEq6SnbcpqQorE0k37o171J5U4vqOTUa5CPWjAT5
         nC/L3ntH8jYbhBBuIrIdVtRKPTV8X6/W7eZGnZnj+8DWucatFabSvuGLdDufB0+b+8R1
         GcQA==
X-Gm-Message-State: AFqh2kozXYuuj7oFliXeMI2qF95flLtKOGA5/oEdIRcjJmlCB/xx+rBY
        9EpWg6iLxasHUVlf5DkJMso+z4o60hw=
X-Google-Smtp-Source: AMrXdXvXTRNVHgy6ypXQ7cuQfNYqYetzSg/T0mKpOwyL0ioQdx2HJ58aVfmb/nS1jZd8Qk5M7tU3rA==
X-Received: by 2002:a17:907:11cd:b0:870:b950:18e7 with SMTP id va13-20020a17090711cd00b00870b95018e7mr20325963ejb.19.1674315410946;
        Sat, 21 Jan 2023 07:36:50 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id vc10-20020a170907d08a00b008717a377125sm8187030ejc.85.2023.01.21.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 07:36:50 -0800 (PST)
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
Subject: [PATCH v1 0/7] serial: imx: work-around for hardware RX flood, and then isr improvements
Date:   Sat, 21 Jan 2023 18:36:32 +0300
Message-Id: <20230121153639.15402-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87bko4e65y.fsf@osv.gnss.ru>
References: <87bko4e65y.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These series contain a work-around for hardware RX flood in first 2
commits, and then further cleanups and optimizations of the receive IRQ
handler.

WARNING: the flood fix is extensively tested with older version of the
kernel with DMA turned off. The DMA path is tested only a bit, as DMA has
receive problems on my kernel version.

Changes in v1:

  * Missing braces fixed.

  * Withdrawn patch optimizing imx_uart_readl() -> readl(), on request of
    Uwe Kleine-König.

Sergey Organov (7):
  serial: imx: factor-out common code to imx_uart_soft_reset()
  serial: imx: work-around for hardware RX flood
  serial: imx: do not sysrq broken chars
  serial: imx: do not break from FIFO reading loop prematurely
  serial: imx: remove redundant USR2 read from FIFO reading loop
  serial: imx: stop using USR2 in FIFO reading loop
  serial: imx: refine local variables in rxint()

 drivers/tty/serial/imx.c | 225 ++++++++++++++++++++++++---------------
 1 file changed, 140 insertions(+), 85 deletions(-)

Interdiff against v0:
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 45327ff6dd14..447b9060d9df 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -889,15 +889,14 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
 	struct tty_port *port = &sport->port.state->port;
-	typeof(sport->port.membase) membase = sport->port.membase;
 	u32 usr2, rx;
 
 	/* If we received something, check for 0xff flood */
-	usr2 = readl(membase + USR2);
+	usr2 = imx_uart_readl(sport, USR2);
 	if (usr2 & USR2_RDR)
 		imx_uart_check_flood(sport, usr2);
 
-	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
+	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
 		unsigned int flg = TTY_NORMAL;
 		sport->port.icount.rx++;
 
@@ -929,8 +928,9 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 				flg = TTY_OVERRUN;
 
 			sport->port.sysrq = 0;
-		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx)) {
 			continue;
+		}
 
 		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
 			continue;
-- 
2.30.1

