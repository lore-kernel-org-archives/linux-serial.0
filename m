Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5CFC3DA78
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjAMSoK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjAMSny (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 13:43:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828853739C
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d30so29407923lfv.8
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEk4AFlxAF8T5iRhtAEH/nRNJxTDpq08gbezozP0K5c=;
        b=EST2u7+EY1BljGeUo+Jl+mIEA0GL3IUBwxEHYsN5Q+frpg+8rXwH/USoGKBXXuaaCq
         4DNbVhaE1UxEjroEhkxeNYPTLsYfLK+yC4eH0+a3E2VRZQO287qJ1+vUifcABD7edciy
         ycSPaQLULmrLkqqGzc46TGE7VatG3iA9bXJE/PPeqthdFEiWQ0L0MDzDEWFRU56urgEK
         47qq8OrIHpK00lgOiWmQJLNUc1ebiUV9rWtinefVmz43yYMhwycjYauOCvqVM4Z+8Toj
         uu7vwLvuTsKARCXTsFXHDttrpfuEgg4m2UyJGCEl9cn9qKPdI6WApM12xgUlj5CHqim9
         9qQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEk4AFlxAF8T5iRhtAEH/nRNJxTDpq08gbezozP0K5c=;
        b=xI2G+z9waNMdvkV2xgUCvb3WH9/EIYY7tJFky+MFa8AsUnv703o1gjJikYCWyKpUtO
         Qfe+CsgehOiHzL3ZTrNQ5dKlQWuH/dygfzU7HP3txEXykgYufIjrX/TWbNrZz8RdQqN9
         s2GiTULWcdPjW/yKMpWuHmlJ9oyqlrZseWKuO1M4N37BDolMjCsuFUcezIwfAg0GY0iY
         zYSSwXGIgTxgE4sQBfNIuFRt5Y04Ce611gyEblsgbrj6qGTtmb+MjeBQgecfA0c/Uiyz
         cq2WLKNWs+9uzGb58uWI5el8Q80J7wiZNsR9hUYIHYuaPLBzuTkTGJf1q3BFFGOFOUWn
         fRbQ==
X-Gm-Message-State: AFqh2krbTPzN1Fq0RBJCqo0HwDXAVIBxT7R7DREkUrKUBzYBUZ9PIMdg
        q6nYYKlmtRlFSyDW5RJB4Tlcy8PwxWY=
X-Google-Smtp-Source: AMrXdXsFRmXLBepa75IdA8upDEUsOGVX6bHbVT7iNgg7WPN7teH0vjcgcywcHXIQ6vaZhr2DUfGdZw==
X-Received: by 2002:ac2:5234:0:b0:4a7:64ea:7855 with SMTP id i20-20020ac25234000000b004a764ea7855mr211232lfl.47.1673635429454;
        Fri, 13 Jan 2023 10:43:49 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004cc9ddce3adsm1261439lfl.82.2023.01.13.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:43:48 -0800 (PST)
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
Subject: [PATCH 6/8] serial: imx: stop using USR2 in FIFO reading loop
Date:   Fri, 13 Jan 2023 21:43:32 +0300
Message-Id: <20230113184334.287130-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230113184334.287130-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
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
index c44a7293c013..be00362b8b67 100644
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

