Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76394C25B50
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 15:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjAUPhR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAUPhP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 10:37:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD9F2CC5E
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:59 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vw16so20786123ejc.12
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEm5A99uTG2c238a+JDBkz/mOTpdwi/bBFV9FIiWCUw=;
        b=hKOanOB+Jp4twUTrfXiXV8T4xU7zos4v0oiBi0NKbLmvUTU+eLWrdQvXmBhVaVndRP
         VMVuYgvl43SPxyS042yXS1SrdssVRlpWla7n1BLoDIGOeVeoaEnMG3VqLsUzOMHyJ7Uv
         hTBVuIdBBVN30aMgO3Pejg7iQ+Mo6jnmPm3SQtgKg1hJK4i1WNqQZQK/FuXjR5uIfCuw
         zCjSW4OTXKoTx5DKqGUzNA8Dh7YAIxlPH+UBSyfPUn4V13t/uf7+vp5REfGqWc4JOzGX
         lX7HTkdrO3ACsF9yAGxTZlED4Qe1cEwr1LSl6s8g8vj9dhSzj5p405tjEW4u+MtlMPxC
         k9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEm5A99uTG2c238a+JDBkz/mOTpdwi/bBFV9FIiWCUw=;
        b=W1E+A0pgbW+ph0Mse1S3LtGp4tfm2FpJ7NhtedXb+O3co47kYvfPgUO2+9Cc3Wrrfb
         1/5J2+8Dd8njiDgvWlifKqF7Olduf6b9OqXLwpuCS3DD34ruX7K6pZqio3QkIBsVsyqS
         /iQg8AFQusfKWpYvg9Ip+4lblPwADoKKi686z4W1x1eGZP2kLMWXSN5IcHyLvxSKAs+E
         G6AdiOsA6iN9lF7V/VwieloXbAYX9fBZtSGYp1I2uxKryx/y9qHednWGKMaXr+QYaj1q
         vM56ZxvlKUCRXEkqobUxP/zFJXJvG6FyZexe45sya97dBuEbFuF4zH1S96DH+spXOzgE
         BGqg==
X-Gm-Message-State: AFqh2kprnq0V0YzQAtKJJJm+XVdBe/vYGkXY6jZIrJvlljJnp24vPJzv
        CYiD2ayQC7ZDNU/I7Uk7xdbWaEhhrzM=
X-Google-Smtp-Source: AMrXdXud2vbRhpBZTL2WdDc/3x2g68JGn78+ZaUp9GYAg6ZI1mbhN9/TQRbZhqN8NeRWcVIpiEvVxg==
X-Received: by 2002:a17:906:6bc6:b0:7c0:f684:9092 with SMTP id t6-20020a1709066bc600b007c0f6849092mr18559572ejs.37.1674315417507;
        Sat, 21 Jan 2023 07:36:57 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id vc10-20020a170907d08a00b008717a377125sm8187030ejc.85.2023.01.21.07.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 07:36:57 -0800 (PST)
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
Subject: [PATCH v1 4/7] serial: imx: do not break from FIFO reading loop prematurely
Date:   Sat, 21 Jan 2023 18:36:36 +0300
Message-Id: <20230121153639.15402-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121153639.15402-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230121153639.15402-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no reason to prematurely break out of FIFO reading loop, and it
might cause needless reenters into ISR, so keep reading until FIFO is
empty.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e709118fe85c..797c441088a9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -888,7 +888,7 @@ static void imx_uart_check_flood(struct imx_port *sport, u32 usr2)
 static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	unsigned int rx, flg, ignored = 0;
+	unsigned int rx, flg;
 	struct tty_port *port = &sport->port.state->port;
 	u32 usr2;
 
@@ -921,11 +921,8 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 			if (rx & URXD_OVRRUN)
 				sport->port.icount.overrun++;
 
-			if (rx & sport->port.ignore_status_mask) {
-				if (++ignored > 100)
-					goto out;
+			if (rx & sport->port.ignore_status_mask)
 				continue;
-			}
 
 			rx &= (sport->port.read_status_mask | 0xFF);
 
@@ -944,13 +941,12 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 		}
 
 		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
-			goto out;
+			continue;
 
 		if (tty_insert_flip_char(port, rx, flg) == 0)
 			sport->port.icount.buf_overrun++;
 	}
 
-out:
 	tty_flip_buffer_push(port);
 
 	return IRQ_HANDLED;
-- 
2.30.1

