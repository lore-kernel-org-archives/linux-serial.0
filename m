Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E67FC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 10:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B31560EFE
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 10:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhJZKio (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Oct 2021 06:38:44 -0400
Received: from mail.bitwise.fi ([109.204.228.163]:58476 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234330AbhJZKiS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Oct 2021 06:38:18 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Oct 2021 06:38:10 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 175E9460029;
        Tue, 26 Oct 2021 13:29:15 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SmpeHPaUqtwC; Tue, 26 Oct 2021 13:29:09 +0300 (EEST)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id B9E01460026;
        Tue, 26 Oct 2021 13:29:09 +0300 (EEST)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: xilinx_uartps: Fix race condition causing stuck TX
Date:   Tue, 26 Oct 2021 13:27:41 +0300
Message-Id: <20211026102741.2910441-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

xilinx_uartps .start_tx() clears TXEMPTY when enabling TXEMPTY to avoid
any previous TXEVENT event asserting the UART interrupt. This clear
operation is done immediately after filling the TX FIFO.

However, if the bytes inserted by cdns_uart_handle_tx() are consumed by
the UART before the TXEMPTY is cleared, the clear operation eats the new
TXEMPTY event as well, causing cdns_uart_isr() to never receive the
TXEMPTY event. If there are bytes still queued in circbuf, TX will get
stuck as they will never get transferred to FIFO (unless new bytes are
queued to circbuf in which case .start_tx() is called again).

While the racy missed TXEMPTY occurs fairly often with short data
sequences (e.g. write 1 byte), in those cases circbuf is usually empty
so no action on TXEMPTY would have been needed anyway. On the other
hand, longer data sequences make the race much more unlikely as UART
takes longer to consume the TX FIFO. Therefore it is rare for this race
to cause visible issues in general.

Fix the race by clearing the TXEMPTY bit in ISR *before* filling the
FIFO.

The TXEMPTY bit in ISR will only get asserted at the exact moment the
TX FIFO *becomes* empty, so clearing the bit before filling FIFO does
not cause an extra immediate assertion even if the FIFO is initially
empty.

This is hard to reproduce directly on a normal system, but inserting
e.g. udelay(200) after cdns_uart_handle_tx(port), setting 4000000 baud,
and then running "dd if=/dev/zero bs=128 of=/dev/ttyPS0 count=50"
reliably reproduces the issue on my ZynqMP test system unless this fix
is applied.

Fixes: 85baf542d54e ("tty: xuartps: support 64 byte FIFO size")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
 drivers/tty/serial/xilinx_uartps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 962e522ccc45..d5e243908d9f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -601,9 +601,10 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	if (uart_circ_empty(&port->state->xmit))
 		return;
 
+	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
+
 	cdns_uart_handle_tx(port);
 
-	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 	/* Enable the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
 }
-- 
2.31.1

