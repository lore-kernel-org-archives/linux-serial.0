Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C842BC49EA5
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B258C613B7
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhFXWwQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232695AbhFXWwN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 18:52:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 286386135C;
        Thu, 24 Jun 2021 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624574994;
        bh=Do7JpeaMbcTZFmYRsJ6KflWqZQ5cEUS3jxE0VeBISec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KftG9LTMBq4EBxfDAXYFRYxvIic6GLpckd4GFs34LxG3LaieSh9UxRngbGqtcXXdI
         vDM+/kNx0FmKddqDDZYBmlWS1dxDQMpqasyV2BC3MOGzfjJ7HvIQpKxttYbiXMh2ew
         vQ5gpGK5kOJNIUXHTqipaHbBaJancGP3D6QxVO1lUOry391v7443wcAyUsRcqc0B7p
         WY9YitbrfNtAuF0uGe4CeYP0uy+4pMNMBKGDtFW96bPCaktQ/HJVUXjdWMyNzQ8vh4
         +ptCcBOMMyScAhiy4YdeQEaAE7HfPfE94IWsQ2S7iV9pXvgxBx3/jd4A+A5tIwps5/
         y8w8X9ODdp9Mg==
Received: by pali.im (Postfix)
        id DC8858A3; Fri, 25 Jun 2021 00:49:53 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/10] serial: mvebu-uart: correctly calculate minimal possible baudrate
Date:   Fri, 25 Jun 2021 00:49:02 +0200
Message-Id: <20210624224909.6350-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624224909.6350-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For default (x16) scheme which is currently used by mvebu-uart.c driver,
maximal divisor of UART base clock is 1023*16. Therefore there is limit for
minimal supported baudrate. This change calculate it correctly and prevents
setting invalid divisor 0 into hardware registers.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
---
 drivers/tty/serial/mvebu-uart.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index dc0c26824ddb..f8b0016db847 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -481,7 +481,7 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 				   struct ktermios *old)
 {
 	unsigned long flags;
-	unsigned int baud;
+	unsigned int baud, min_baud, max_baud;
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -500,16 +500,21 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 		port->ignore_status_mask |= STAT_RX_RDY(port) | STAT_BRK_ERR;
 
 	/*
+	 * Maximal divisor is 1023 * 16 when using default (x16) scheme.
 	 * Maximum achievable frequency with simple baudrate divisor is 230400.
 	 * Since the error per bit frame would be of more than 15%, achieving
 	 * higher frequencies would require to implement the fractional divisor
 	 * feature.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, 230400);
+	min_baud = DIV_ROUND_UP(port->uartclk, 1023 * 16);
+	max_baud = 230400;
+
+	baud = uart_get_baud_rate(port, termios, old, min_baud, max_baud);
 	if (mvebu_uart_baud_rate_set(port, baud)) {
 		/* No clock available, baudrate cannot be changed */
 		if (old)
-			baud = uart_get_baud_rate(port, old, NULL, 0, 230400);
+			baud = uart_get_baud_rate(port, old, NULL,
+						  min_baud, max_baud);
 	} else {
 		tty_termios_encode_baud_rate(termios, baud, baud);
 		uart_update_timeout(port, termios->c_cflag, baud);
-- 
2.20.1

