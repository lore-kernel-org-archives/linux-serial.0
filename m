Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953CFC25B50
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 15:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAUPh1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjAUPhS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 10:37:18 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253632CFD1
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:37:04 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id tz11so20949657ejc.0
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fbiDWy8ZCeEEPo3XsRTUlzcMe3rsD7fkZwC6S0cFK0=;
        b=cUKloTLrSAChI4BCO0eWJaaZnNF/rZJTMroMFj45nPKm8Z9uKUW1hn2uoyH8x1dr/0
         w1VlsQmfIg1o7b6OnBcQBF7ScdzssVX39T1BJyaW5vGhZUCVfuvtusjP2f2wsweYbWGU
         Q2kKYiAZXSvuGvoYgH/DJvfcVOUyqkvuSfov+dqbE9Pp07htHoqk0s6JrodKOdH7SXy3
         2gN8DqLB/at+lhW8Mj8g65c2OTxTsoOL0D2/cnAlp5anyqC/pqMjObgXlrLcLNj1c1N+
         +N6Uj0qqPAr1ZmEGr3RKQ0YJI+vUzOxRRiK5KECVbum/3RN02DXlumZ+givMw+S5gkXK
         aQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fbiDWy8ZCeEEPo3XsRTUlzcMe3rsD7fkZwC6S0cFK0=;
        b=jXgIyqSRlMKToVs3G+N3eWQmp1OVkx7mBBS2XkouhAsMx20/rs97dU7jPgPFd9uNBf
         QBlEOCqC6K9CpntUKLrSGHoYIucN+eZ3MmO+ZAk/S03GcWT+xU4YHqJ2d8heRIcqF8rt
         cZkAPm8mLufXVrDFSKB7hGH3ntiZ40qQQozeLBt1uEltTq2PZud0DtiCgqqTAa1XXpGh
         UEuMwO2WZllC5vmXBS8tMdS77yLgCJwxmFpyQ59Nv/4bcsmhpSJfugO8qukmm01meYvR
         Pmt6oYk1cgjg3iKjh0WEN48IiN2i6ZHoyMdcrjjiGcheUrHz04XHZwPh/m7xXBm8Ns7e
         vaKQ==
X-Gm-Message-State: AFqh2kpoTvtwgipHqurdEAX/z+oXhc6AzqRIKSZACbmtfB+P0Bp6r3x1
        Pxa3TfaCNOLmNdlmGnt4Wh9AA/sI6BE=
X-Google-Smtp-Source: AMrXdXu1qdNmIXsHJye5VL6FE77ShV+keQV6lziLd3CwABregAyifPuPk21u3ESwF1s20pxPZ5yisw==
X-Received: by 2002:a17:906:b305:b0:86e:8b7b:adb9 with SMTP id n5-20020a170906b30500b0086e8b7badb9mr17195606ejz.34.1674315422275;
        Sat, 21 Jan 2023 07:37:02 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id vc10-20020a170907d08a00b008717a377125sm8187030ejc.85.2023.01.21.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 07:37:01 -0800 (PST)
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
Subject: [PATCH v1 7/7] serial: imx: refine local variables in rxint()
Date:   Sat, 21 Jan 2023 18:36:39 +0300
Message-Id: <20230121153639.15402-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121153639.15402-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230121153639.15402-1-sorganov@gmail.com>
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
index 488d8119562e..447b9060d9df 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -888,9 +888,8 @@ static void imx_uart_check_flood(struct imx_port *sport, u32 usr2)
 static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	unsigned int rx, flg;
 	struct tty_port *port = &sport->port.state->port;
-	u32 usr2;
+	u32 usr2, rx;
 
 	/* If we received something, check for 0xff flood */
 	usr2 = imx_uart_readl(sport, USR2);
@@ -898,7 +897,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 		imx_uart_check_flood(sport, usr2);
 
 	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
-		flg = TTY_NORMAL;
+		unsigned int flg = TTY_NORMAL;
 		sport->port.icount.rx++;
 
 		if (unlikely(rx & URXD_ERR)) {
-- 
2.30.1

