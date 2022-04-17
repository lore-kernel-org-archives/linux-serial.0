Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8476C433FE
	for <linux-serial@archiver.kernel.org>; Sun, 17 Apr 2022 23:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiDQXF1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 Apr 2022 19:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiDQXFT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 Apr 2022 19:05:19 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D03C186FD;
        Sun, 17 Apr 2022 16:02:42 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 125A79200B3; Mon, 18 Apr 2022 01:02:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0C59092009E;
        Mon, 18 Apr 2022 00:02:42 +0100 (BST)
Date:   Mon, 18 Apr 2022 00:02:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v4 4/5] serial: 8250: Also set sticky MCR bits in console
 restoration
In-Reply-To: <alpine.DEB.2.21.2204161848030.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204162156340.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204161848030.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Sticky MCR bits are lost in console restoration if console suspending 
has been disabled.  This currently affects the AFE bit, which works in 
combination with RTS which we set, so we want to make sure the UART 
retains control of its FIFO where previously requested.  Also specific 
drivers may need other bits in the future.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 4516d50aabed ("serial: 8250: Use canary to restart console after suspend")
Cc: stable@vger.kernel.org # v4.0+
---
New change in v4, factored out from 5/5.
---
 drivers/tty/serial/8250/8250_port.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-serial-8250-mcr-restore.diff
Index: linux-macro/drivers/tty/serial/8250/8250_port.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/8250/8250_port.c
+++ linux-macro/drivers/tty/serial/8250/8250_port.c
@@ -3308,7 +3308,7 @@ static void serial8250_console_restore(s
 
 	serial8250_set_divisor(port, baud, quot, frac);
 	serial_port_out(port, UART_LCR, up->lcr);
-	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
+	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
 /*
