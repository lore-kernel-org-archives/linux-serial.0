Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C194BC43462
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4FC61408
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhELOOi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 10:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhELOOQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 10:14:16 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50753C061574;
        Wed, 12 May 2021 07:13:08 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 91B6922260;
        Wed, 12 May 2021 16:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620828786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmpSNgM9mDURcLAQ47HsvC3UAZc1p3XAcKNA/nVD8AM=;
        b=g0FZ8yC+UVxgMDUpDWgSLlBu+Q5/gXbzStzZSwB/ndTFR87N2slxxqwgxx7kR4uAm05++B
        71MfvgjNmg2Pmi2f5x/IcVct7Ndzqtz/w5B50PoNRWll4P6oWS+IVeoDEf35TBVOcEx528
        DDAjW74vz92Y9vAiP1jHsoAHqFJNXw8=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 3/9] serial: fsl_lpuart: don't restore interrupt state in ISR
Date:   Wed, 12 May 2021 16:12:49 +0200
Message-Id: <20210512141255.18277-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512141255.18277-1-michael@walle.cc>
References: <20210512141255.18277-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From commit 75f4e830fa9c ("serial: do not restore interrupt state in
sysrq helper"):

  Since commit 81e2073c175b ("genirq: Disable interrupts for force
  threaded handlers") interrupt handlers that are not explicitly
  requested as threaded are always called with interrupts disabled and
  there is no need to save the interrupt state when taking the port
  lock.

Apply this also to fsl_lpuart in prepartion for sysrq handling with
uart_unlock_and_check_sysrq().

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b76ddc0d8edc..37e02d992c0b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -824,21 +824,18 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 
 static void lpuart_txint(struct lpuart_port *sport)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 	lpuart_transmit_buffer(sport);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 }
 
 static void lpuart_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned long flags;
 	unsigned char rx, sr;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 
 	while (!(readb(sport->port.membase + UARTSFIFO) & UARTSFIFO_RXEMPT)) {
 		flg = TTY_NORMAL;
@@ -896,28 +893,25 @@ static void lpuart_rxint(struct lpuart_port *sport)
 		writeb(UARTSFIFO_RXOF, sport->port.membase + UARTSFIFO);
 	}
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 
 	tty_flip_buffer_push(port);
 }
 
 static void lpuart32_txint(struct lpuart_port *sport)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 	lpuart32_transmit_buffer(sport);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 }
 
 static void lpuart32_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned long flags;
 	unsigned long rx, sr;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 
 	while (!(lpuart32_read(&sport->port, UARTFIFO) & UARTFIFO_RXEMPT)) {
 		flg = TTY_NORMAL;
@@ -965,7 +959,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 	}
 
 out:
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 
 	tty_flip_buffer_push(port);
 }
-- 
2.20.1

