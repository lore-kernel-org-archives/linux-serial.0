Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5ECC05027
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 14:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBAO1z (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjBAO1s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 09:27:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58182CFD9
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 06:27:45 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cw4so12728234edb.13
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2023 06:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEm5A99uTG2c238a+JDBkz/mOTpdwi/bBFV9FIiWCUw=;
        b=hqqEqTK0vARzjhmqa9hC6bsI/43ShQLK8//yNN4LKLiy2WkIGvyXDYZ2m8GwRYhND9
         bDzPhj4P3JTMuOHV7ReCUIXnc+k2DCtkuR5WATi1e7simYqn/scDIwWxlbFDqU4KBPXa
         eZE33vSPuG4gKrpDbQf+ma7fIakaRy+/RXJ2rEjomknemkaxN2HKc5nAxtz5XIpuaRfe
         puxzpZUI8J04cDtaG4LZIeabkjgsApoH4KDJtMnW1DwWjeFb9Hm/LTHGGmNzxV//ZyrK
         HMNT3e/PUk/YtM9L+ZlZ5mRx45dDZ0cIiRwiQFQ6YUfQTutjE7IRwN5dxXFb9HS44Xh/
         L0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEm5A99uTG2c238a+JDBkz/mOTpdwi/bBFV9FIiWCUw=;
        b=vSjJ4jvaruGwJGheJtCT2Wogo6XKdWHFYt0nLK9yH4OhHE4V1ZvxEvvPXOzBWOkXac
         ZhuiIu/Oe3F4eOj6eQSYlBfCmAU6HvcwlVFU5nU+yi3T3X6G5nYAX2tK1xYLaqouAUha
         kdvKR9JOsc6/qQkZ5REuVMcs3JcPcA8EhUxM1G6MB37dQRJ+dscIqPS191cmpMI3yvaz
         Pf4CJHdhSFt2zfktdZfaiyWS/leskFalE7hWKf08WK9uTk5Spx0v/Y2+tMPtj0UQwhQm
         s9MaTl7Njz6PVOk5mkjSEeBL/D60Y9bvVlcR5eahieHLAFys4q0nl1N0kRj7RTCHwPe0
         bgWw==
X-Gm-Message-State: AO0yUKU7GIT8C2Dk5dqdKRoJlOTETSe0C4NKpTdRtRQ0+996nM6zsAcc
        g2/lEPuG+iWelZr5DmcfX38=
X-Google-Smtp-Source: AK7set8ws7NdcXePeM55LM4BT1j7mYwM+w20CWy2QWuufVGR25bLp8ZxOOgYCX5HpeGK6TKSRutHlA==
X-Received: by 2002:aa7:de13:0:b0:499:d0e3:7745 with SMTP id h19-20020aa7de13000000b00499d0e37745mr2245544edv.14.1675261664352;
        Wed, 01 Feb 2023 06:27:44 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm8975564edb.79.2023.02.01.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:27:43 -0800 (PST)
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
Subject: [PATCH v1 4/7] serial: imx: do not break from FIFO reading loop prematurely
Date:   Wed,  1 Feb 2023 17:26:57 +0300
Message-Id: <20230201142700.4346-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201142700.4346-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230201142700.4346-1-sorganov@gmail.com>
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

