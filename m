Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4ADC05027
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 14:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBAO15 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjBAO1w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 09:27:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160CE68127
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 06:27:51 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m8so8638980edd.10
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2023 06:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fbiDWy8ZCeEEPo3XsRTUlzcMe3rsD7fkZwC6S0cFK0=;
        b=gAuVsJrYc7jh8ErBsEv3KC4ZC2oYJctZttWWSRj1FJ2yUsydorfPIcxfqxhbIpT+NM
         VJSNjFhzuhLo2iCXIi7JP/kh0sPKfPyNhxp1sLzCMpxDDUwxa1g6RoBiWpOfxmYEMUbk
         vI1ZbhbaGzTVCg5d2AYbxzQT6Lht/1pTHdceiMUoBc+/tEL6HzyozcGSM/9m37UR9aSn
         uPZx6Y6ve8uBCqK9loEjuNnqFTWU376VNeTQOrdvDp7xk67ltLLCH9OdKA/N4GUjzlmp
         RzmXlvs07ezYOghcZkzVgphJEiPqALOXtnVVN8SXtbvZyjnOFA+3dqltAwVIgr/rbMoc
         eDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fbiDWy8ZCeEEPo3XsRTUlzcMe3rsD7fkZwC6S0cFK0=;
        b=7tHZGnQZG3AZQ9/YbqXg0f1blmWUnJ3TsyPjRQhm0W+v4FGPjglba8eEOMJTdEfuJO
         RqY8Xw0Yo/uMToVsuwO6GruY5jgzWGdFJFPcMCyZq93NbAexRxAeNHAJcF9NW+A+qgrx
         VBI9VejZKQVBoBiybEffW6Byi9QnPQbLAypb+rIUbHvIC2+e9y8LcDNk0T7H+pWUBnI8
         wFMqzPhMhD/yLE881HIISstookAMK5qC2wSQJ+Q+wat9++lb7C3nUXS5fEmiWsk288/J
         5T2b/jWY7y/5+bcGJF831hdC2wNMnWWE3s0yvsr0FdO5Zud4IzWSaAvJ8ansOAVk5LRE
         KR1A==
X-Gm-Message-State: AO0yUKVVbjf0rCRjSpYkQJzEaTzjazpnl3SLFdxeYON+pIpCnQNye6S4
        lv69MBwu8Ow0mYgTc9NTAeG8nLaJdKI=
X-Google-Smtp-Source: AK7set+Ldupr8odgypamg0BybQedrh29v5qHb8uwrB94NJrvfSbIEZzbyHzI9wwW8XEVlszcDIL6sg==
X-Received: by 2002:a05:6402:1bcd:b0:472:9af1:163f with SMTP id ch13-20020a0564021bcd00b004729af1163fmr1833744edb.37.1675261669554;
        Wed, 01 Feb 2023 06:27:49 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm8975564edb.79.2023.02.01.06.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:27:49 -0800 (PST)
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
Subject: [PATCH v1 7/7] serial: imx: refine local variables in rxint()
Date:   Wed,  1 Feb 2023 17:27:00 +0300
Message-Id: <20230201142700.4346-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201142700.4346-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230201142700.4346-1-sorganov@gmail.com>
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

