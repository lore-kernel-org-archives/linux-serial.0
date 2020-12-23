Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F1FC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 23 Dec 2020 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C1522225
	for <linux-serial@archiver.kernel.org>; Wed, 23 Dec 2020 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgLWTU3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Dec 2020 14:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgLWTU3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Dec 2020 14:20:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B57F7221FC;
        Wed, 23 Dec 2020 19:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608751188;
        bh=9coihf0UH+25WGPnIAMMnvqH8xa/SNz1A8l5yYJ/taM=;
        h=From:To:Cc:Subject:Date:From;
        b=sWE47vxJY6W5kxwXQotEftSRoXdVJU0yn4/g999TT+/K3ess0vJufskkj7wN+F+3W
         1njgHTAVYNgTUmfuMK/q4JCO8Q5/0B+Vd/uUu+snW9fZ16kzzmAaYYc1a0B3/rLO0y
         pw0ah/TeODLSc/oUMyAbRwcVar8SglJgjNQMj3Rv0LHnGUifNft0y4pCvZlltpN9va
         OEtOaI9/Mcz5UJqNmy63/xzLs60FNY6fmk9PCVn+WWWuMK1QRLf8sDHrQ8RyJKD2KN
         fOYi7Gpo/To8j3qkmrxwH39D1UJWTohH95hyv2JbMJKInTD3cAu2oFK2qNx4mYhCTu
         aIoruG0A0Xevg==
Received: by pali.im (Postfix)
        id 6C76C7F0; Wed, 23 Dec 2020 20:19:46 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH] serial: mvebu-uart: fix tx lost characters at power off
Date:   Wed, 23 Dec 2020 20:19:31 +0100
Message-Id: <20201223191931.18343-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit c685af1108d7 ("serial: mvebu-uart: fix tx lost characters") fixed tx
lost characters at low baud rates but started causing tx lost characters
when kernel is going to power off or reboot.

TX_EMP tells us when transmit queue is empty therefore all characters were
transmitted. TX_RDY tells us when CPU can send a new character.

Therefore we need to use different check prior transmitting new character
and different check after all characters were sent.

This patch splits polling code into two functions: wait_for_xmitr() which
waits for TX_RDY and wait_for_xmite() which waits for TX_EMP.

When rebooting A3720 platform without this patch on UART is print only:
[   42.699�

And with this patch on UART is full output:
[   39.530216] reboot: Restarting system

Fixes: c685af1108d7 ("serial: mvebu-uart: fix tx lost characters")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/tty/serial/mvebu-uart.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 118b29912289..e0c00a1b0763 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -648,6 +648,14 @@ static void wait_for_xmitr(struct uart_port *port)
 				  (val & STAT_TX_RDY(port)), 1, 10000);
 }
 
+static void wait_for_xmite(struct uart_port *port)
+{
+	u32 val;
+
+	readl_poll_timeout_atomic(port->membase + UART_STAT, val,
+				  (val & STAT_TX_EMP), 1, 10000);
+}
+
 static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
 {
 	wait_for_xmitr(port);
@@ -675,7 +683,7 @@ static void mvebu_uart_console_write(struct console *co, const char *s,
 
 	uart_console_write(port, s, count, mvebu_uart_console_putchar);
 
-	wait_for_xmitr(port);
+	wait_for_xmite(port);
 
 	if (ier)
 		writel(ier, port->membase + UART_CTRL(port));
-- 
2.20.1

