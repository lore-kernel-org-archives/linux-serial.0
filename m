From: John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 2/2] serial: MIPS: lantiq: fix clock error check
Date: Fri,  9 Aug 2013 20:54:31 +0200
Message-ID: <1376074471-29404-2-git-send-email-blogic@openwrt.org>
References: <1376074471-29404-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:33309 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030743Ab3HITBl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Aug 2013 15:01:41 -0400
In-Reply-To: <1376074471-29404-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>

The clock should be checked with the proper IS_ERR() api before using it.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/lantiq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 93ac046..88d01e0 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -318,7 +318,7 @@ lqasc_startup(struct uart_port *port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 	int retval;
 
-	if (ltq_port->clk)
+	if (!IS_ERR(ltq_port->clk))
 		clk_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
@@ -386,7 +386,7 @@ lqasc_shutdown(struct uart_port *port)
 		port->membase + LTQ_ASC_RXFCON);
 	ltq_w32_mask(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
-	if (ltq_port->clk)
+	if (!IS_ERR(ltq_port->clk))
 		clk_disable(ltq_port->clk);
 }
 
-- 
1.7.10.4

