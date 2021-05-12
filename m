Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304FDC43600
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF616127A
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhELOOj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhELOOR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 10:14:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88DDC06174A;
        Wed, 12 May 2021 07:13:08 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E518E22264;
        Wed, 12 May 2021 16:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620828787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDfS9iCyKAFrAsK6pAO+znRKWWaSL3SBcDzUWtD8J58=;
        b=v7bOCUrlG+xN7JHcoh5eqF4LnE8uc7upVZtji2f4TJSvpgVAEW0/A+SGh6Xjg9yU/+Oyok
        OBf9BytCGrLoR20O4S/5iB4Q0PinP/uON0CLwa5oBQ5gg4Rcobt6EU5vVfCNDuoZY4/oJF
        /b4xIY6gn5RKvwtx2yOn4q8XpCqiDfs=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 4/9] serial: fsl_lpuart: split sysrq handling
Date:   Wed, 12 May 2021 16:12:50 +0200
Message-Id: <20210512141255.18277-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512141255.18277-1-michael@walle.cc>
References: <20210512141255.18277-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Instead of uart_handle_sysrq_char() use uart_prepare_sysrq_char() and
uart_unlock_and_check_sysrq(). This will call handle_sysrq() without
holding the port lock, which in turn let us drop the spin_trylock hack.

Suggested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 37e02d992c0b..63a1dac7c3aa 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -847,7 +847,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 		sr = readb(sport->port.membase + UARTSR1);
 		rx = readb(sport->port.membase + UARTDR);
 
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		if (uart_prepare_sysrq_char(&sport->port, rx))
 			continue;
 
 		if (sr & (UARTSR1_PE | UARTSR1_OR | UARTSR1_FE)) {
@@ -893,7 +893,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 		writeb(UARTSFIFO_RXOF, sport->port.membase + UARTSFIFO);
 	}
 
-	spin_unlock(&sport->port.lock);
+	uart_unlock_and_check_sysrq(&sport->port);
 
 	tty_flip_buffer_push(port);
 }
@@ -924,7 +924,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 		rx = lpuart32_read(&sport->port, UARTDATA);
 		rx &= UARTDATA_MASK;
 
-		if (uart_handle_sysrq_char(&sport->port, rx))
+		if (uart_prepare_sysrq_char(&sport->port, rx))
 			continue;
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_OR | UARTSTAT_FE)) {
@@ -959,7 +959,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 	}
 
 out:
-	spin_unlock(&sport->port.lock);
+	uart_unlock_and_check_sysrq(&sport->port);
 
 	tty_flip_buffer_push(port);
 }
@@ -2272,7 +2272,7 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned long flags;
 	int locked = 1;
 
-	if (sport->port.sysrq || oops_in_progress)
+	if (oops_in_progress)
 		locked = spin_trylock_irqsave(&sport->port.lock, flags);
 	else
 		spin_lock_irqsave(&sport->port.lock, flags);
@@ -2302,7 +2302,7 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned long flags;
 	int locked = 1;
 
-	if (sport->port.sysrq || oops_in_progress)
+	if (oops_in_progress)
 		locked = spin_trylock_irqsave(&sport->port.lock, flags);
 	else
 		spin_lock_irqsave(&sport->port.lock, flags);
-- 
2.20.1

