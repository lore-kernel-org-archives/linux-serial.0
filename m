Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ABCC43462
	for <linux-serial@archiver.kernel.org>; Tue, 11 May 2021 20:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A382617ED
	for <linux-serial@archiver.kernel.org>; Tue, 11 May 2021 20:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhEKUDM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 May 2021 16:03:12 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43473 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhEKUDL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 May 2021 16:03:11 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AA0892226E;
        Tue, 11 May 2021 22:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620763323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyDiQUyNgBgGc+H3cFQoAm5Uka2UF4lgSKM+qeTxRAQ=;
        b=Noju+nZmmG1XjrgW2szmzE17vTeHwZ2/HjvcNiRDNY1bapLnPkBEgqVtaB/byTiAweaC8V
        Sb/qDZE9zUl97RgvgVkrxHpZjawUmwI3G7EUGjy285H+tczQ7jtkXVArJyEOby+QRn4Qkm
        fNCARjZI14zXEsxNoPaW4KpCwZqId34=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 4/8] serial: fsl_lpuart: handle break and make sysrq work
Date:   Tue, 11 May 2021 22:01:44 +0200
Message-Id: <20210511200148.11934-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511200148.11934-1-michael@walle.cc>
References: <20210511200148.11934-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Although there is already (broken) sysrq characters handling, a break
condition was never detected. There is also a possible deadlock because
we might call handle_sysrq() while still holding the port lock.

Add support for break detection and use the proper
uart_unlock_and_check_sysrq() to defer calling handle_sysrq().

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 36 ++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 37e02d992c0b..0a578ad31a19 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -910,6 +910,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long rx, sr;
+	bool is_break;
 
 	spin_lock(&sport->port.lock);
 
@@ -924,14 +925,27 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 		rx = lpuart32_read(&sport->port, UARTDATA);
 		rx &= UARTDATA_MASK;
 
-		if (uart_handle_sysrq_char(&sport->port, rx))
+		/*
+		 * The LPUART can't distinguish between a break and a framing error,
+		 * thus we assume it is a break if the received data is zero.
+		 */
+		is_break = sr & UARTSTAT_FE && !rx;
+
+		if (is_break && uart_handle_break(&sport->port))
+			continue;
+
+		if (uart_prepare_sysrq_char(&sport->port, rx))
 			continue;
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_OR | UARTSTAT_FE)) {
-			if (sr & UARTSTAT_PE)
-				sport->port.icount.parity++;
-			else if (sr & UARTSTAT_FE)
+			if (sr & UARTSTAT_PE) {
+				if (is_break)
+					sport->port.icount.brk++;
+				else
+					sport->port.icount.parity++;
+			} else if (sr & UARTSTAT_FE) {
 				sport->port.icount.frame++;
+			}
 
 			if (sr & UARTSTAT_OR)
 				sport->port.icount.overrun++;
@@ -944,22 +958,24 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 
 			sr &= sport->port.read_status_mask;
 
-			if (sr & UARTSTAT_PE)
-				flg = TTY_PARITY;
-			else if (sr & UARTSTAT_FE)
+			if (sr & UARTSTAT_PE) {
+				if (is_break)
+					flg = TTY_BREAK;
+				else
+					flg = TTY_PARITY;
+			} else if (sr & UARTSTAT_FE) {
 				flg = TTY_FRAME;
+			}
 
 			if (sr & UARTSTAT_OR)
 				flg = TTY_OVERRUN;
-
-			sport->port.sysrq = 0;
 		}
 
 		tty_insert_flip_char(port, rx, flg);
 	}
 
 out:
-	spin_unlock(&sport->port.lock);
+	uart_unlock_and_check_sysrq(&sport->port);
 
 	tty_flip_buffer_push(port);
 }
-- 
2.20.1

