Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2914C636CD
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 14:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBAO15 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBAO1u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 09:27:50 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABA53FF2E
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 06:27:49 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q19so7921498edd.2
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2023 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5v/xKpmgx3IRd85qrBv3zwjvdUmTrkcJb9ZlFLMDeA=;
        b=DAPka0L/4I745c/qSKtgYk1wXpzL4moxASBPZFfPfq75oV0qTfjaY5x9Tjq2yLKzof
         9fYKAsmN9k0Fu28gVIG26CnvnbN5z54z+r6oz//cPTtDMVEOS3BfzTiVwL01XNHicWV4
         DZQxephCKADZIAC1Q9SxrKEAfSPvrBh9B2nakdG9VBvEBmRd57K2b+ZxN52HSbNy7jzT
         aGEtgbzC5XN2R/aO550nV1rLoUQiVvN9MMtxmFo7bzdT0gCE2CaCZIjNhte5mVq7BRRS
         sAJQNX1LkG1MKJv8q+g7yO5GvR3oqi09+nRxAFJYBhXLgCA/4LF5I/0WvLIDHIHTAwLH
         isbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5v/xKpmgx3IRd85qrBv3zwjvdUmTrkcJb9ZlFLMDeA=;
        b=e2zySTIbgxhIzMNvWM5o0W0ciHQTJhJjf0eNsM2Z4fSJvmcHZKclKpt1phNJVXB0pQ
         /FgTQ3StKm9DkbI1KrRcmAsh3QICO57/5zzj3MHgBtZQk3cPwcC4fyLOrsXtO78eYXEp
         ZLqOtNPfWLib6eZI1zsX52uTgK1kXXJhUaCJXu8S+PDoQYULQSgpiuT3hU7UCVg0zHmw
         fIqbN4dIakqbQHHVz7PNwddzfvVFbNRB4zT9cNtLPFPSMDH+okVBPUKarQsPXjK2m+Gl
         epUImmgF1eLNE6KcHlbdYZlpiTWjNSZiPuDQneSv6HhnchrWsyoumuAIi2ZKDCKnu42l
         fMEA==
X-Gm-Message-State: AO0yUKXi4LhMucz/13YnxXUI55QGe6zkHwrl9jCQiz7vGcko2CBWXYOb
        gusiCEdWqJGFqPhIsaO86Z7nWTYPlWs=
X-Google-Smtp-Source: AK7set9QcDJuAnQSBUBYWr27mdVAgUyXyUxUF978MjptXVS6Ji9xpOjDJa2P1X5QD2PbSZYITR2dBw==
X-Received: by 2002:a05:6402:882:b0:499:b48b:2c3 with SMTP id e2-20020a056402088200b00499b48b02c3mr2062287edy.25.1675261667832;
        Wed, 01 Feb 2023 06:27:47 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm8975564edb.79.2023.02.01.06.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:27:47 -0800 (PST)
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
Subject: [PATCH v1 6/7] serial: imx: stop using USR2 in FIFO reading loop
Date:   Wed,  1 Feb 2023 17:26:59 +0300
Message-Id: <20230201142700.4346-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201142700.4346-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230201142700.4346-1-sorganov@gmail.com>
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

