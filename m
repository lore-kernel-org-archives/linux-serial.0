Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C94EC49EA6
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 04:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D1461982
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 04:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFZENq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Jun 2021 00:13:46 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60052 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhFZENo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Jun 2021 00:13:44 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3E9EA9200BC; Sat, 26 Jun 2021 06:11:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3B85C9200BB;
        Sat, 26 Jun 2021 06:11:21 +0200 (CEST)
Date:   Sat, 26 Jun 2021 06:11:21 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: Report magic multiplier extra baud rates
Message-ID: <alpine.DEB.2.21.2106260334170.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Report extra baud rates supported above the base rate for ports with the 
UPF_MAGIC_MULTIPLIER property, so that people have a way to find out 
that they can be used with their system, e.g.:

Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
printk: console [ttyS0] disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
serial8250.0: ttyS0 extra baud rates supported: 230400, 460800
printk: console [ttyS0] enabled
printk: bootconsole [uart8250] disabled
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
serial8250.0: ttyS1 extra baud rates supported: 230400, 460800
serial8250.0: ttyS2 at MMIO 0x1f000900 (irq = 20, base_baud = 230400) is a 16550A

Otherwise there is no clear way to figure this out, as the feature is 
only reported as an obscure TTY flag in bit 16:

$ cat /sys/class/tty/ttyS[0-2]/flags
0x10010040
0x10010040
0x90000040
$ 

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/tty/serial/serial_core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

linux-serial-core-magic-multiplier.diff
Index: linux-macro-ide-tty/drivers/tty/serial/serial_core.c
===================================================================
--- linux-macro-ide-tty.orig/drivers/tty/serial/serial_core.c
+++ linux-macro-ide-tty/drivers/tty/serial/serial_core.c
@@ -2314,6 +2314,14 @@ uart_report_port(struct uart_driver *drv
 	       port->dev ? ": " : "",
 	       port->name,
 	       address, port->irq, port->uartclk / 16, uart_type(port));
+
+	/* The magic multiplier feature is a bit obscure, so report it too.  */
+	if (port->flags & UPF_MAGIC_MULTIPLIER)
+		pr_info("%s%s%s extra baud rates supported: %d, %d",
+			port->dev ? dev_name(port->dev) : "",
+			port->dev ? ": " : "",
+			port->name,
+			port->uartclk / 8, port->uartclk / 4);
 }
 
 static void
