Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449A9C43616
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC056127A
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhELOOl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhELOOT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 10:14:19 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E54EC061574;
        Wed, 12 May 2021 07:13:10 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 87B312224E;
        Wed, 12 May 2021 16:13:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620828788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uhIH+O4D664Cx/PV6KT/9KkEON+ziodtCiUccB2ePE=;
        b=Z0CJfNkSlQBCiP+nCQiJfQWjxq9PTAbqwt6rnrMOTMXxAgeN5EfhfoVnOp65aH5bzdmZ/9
        Rs5bIwxXvwlVNUs7jz52ajKaMbpBkCqcFZsmaXeQyDNGaTJRvwCak44PTKo1MTSJydxfRH
        wUpToJuMm8Qmy/CykOROHUi9SIUT050=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 8/9] serial: fsl_lpuart: add loopback support
Date:   Wed, 12 May 2021 16:12:54 +0200
Message-Id: <20210512141255.18277-9-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512141255.18277-1-michael@walle.cc>
References: <20210512141255.18277-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The LPUART can loop the RX and TX signal. Add support for it.

Please note, this was only tested on the 32 bit version of the LPUART.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 36 +++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ad1fe8cf63f2..1ed019d91177 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1403,22 +1403,54 @@ static int lpuart32_config_rs485(struct uart_port *port,
 
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
-	return 0;
+	unsigned int mctrl = 0;
+	u8 reg;
+
+	reg = readb(port->membase + UARTCR1);
+	if (reg & UARTCR1_LOOPS)
+		mctrl |= TIOCM_LOOP;
+
+	return mctrl;
 }
 
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 {
-	return 0;
+	unsigned int mctrl = 0;
+	u32 reg;
+
+	reg = lpuart32_read(port, UARTCTRL);
+	if (reg & UARTCTRL_LOOPS)
+		mctrl |= TIOCM_LOOP;
+
+	return mctrl;
 }
 
 static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	u8 reg;
+
+	reg = readb(port->membase + UARTCR1);
+
+	/* for internal loopback we need LOOPS=1 and RSRC=0 */
+	reg &= ~(UARTCR1_LOOPS | UARTCR1_RSRC);
+	if (mctrl & TIOCM_LOOP)
+		reg |= UARTCR1_LOOPS;
 
+	writeb(reg, port->membase + UARTCR1);
 }
 
 static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	u32 reg;
+
+	reg = lpuart32_read(port, UARTCTRL);
+
+	/* for internal loopback we need LOOPS=1 and RSRC=0 */
+	reg &= ~(UARTCTRL_LOOPS | UARTCTRL_RSRC);
+	if (mctrl & TIOCM_LOOP)
+		reg |= UARTCTRL_LOOPS;
 
+	lpuart32_write(port, reg, UARTCTRL);
 }
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
-- 
2.20.1

