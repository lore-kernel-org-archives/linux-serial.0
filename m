From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] serial: sirf: move to writel for TXFIFO instead of writeb
Date: Mon,  5 May 2014 08:05:51 +0800
Message-ID: <1399248352-7329-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:64342 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbaEEAGR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 May 2014 20:06:17 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so8350702pab.13
        for <linux-serial@vger.kernel.org>; Sun, 04 May 2014 17:06:16 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

All SiRFSoC UART registers are in 32-bits. If we use writeb for
TXFIFO, actually all of 32-bits are still written, for TXTIFO,
only low 8-bits are valid, so in prima2&atlas6, this causes no
problem.
But in the new atlas7, using writeb to write UART registers will
cause an imprecise data abort as HW does check the "wrong" writeb.
So move to writel and this also makes the code consistent with
sirfsoc_uart_pio_tx_chars() in which we use writel.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c |    2 +-
 drivers/tty/serial/sirfsoc_uart.h |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 68b0fd4..845548c 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1228,7 +1228,7 @@ static void sirfsoc_uart_console_putchar(struct uart_port *port, int ch)
 	while (rd_regl(port,
 		ureg->sirfsoc_tx_fifo_status) & ufifo_st->ff_full(port->line))
 		cpu_relax();
-	wr_regb(port, ureg->sirfsoc_tx_fifo_data, ch);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_data, ch);
 }
 
 static void sirfsoc_uart_console_write(struct console *co, const char *s,
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 8a6edda..4280819 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -441,9 +441,7 @@ struct sirfsoc_uart_port {
 
 /* Register Access Control */
 #define portaddr(port, reg)		((port)->membase + (reg))
-#define rd_regb(port, reg)		(__raw_readb(portaddr(port, reg)))
 #define rd_regl(port, reg)		(__raw_readl(portaddr(port, reg)))
-#define wr_regb(port, reg, val)		__raw_writeb(val, portaddr(port, reg))
 #define wr_regl(port, reg, val)		__raw_writel(val, portaddr(port, reg))
 
 /* UART Port Mask */
-- 
1.7.5.4

