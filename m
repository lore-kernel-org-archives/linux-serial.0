From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 04/10] serial: timbuart: Staticize local symbols
Date: Thu, 08 Aug 2013 17:33:27 +0900
Message-ID: <005f01ce9411$f499ad30$ddcd0790$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38385 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757717Ab3HHId3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 04:33:29 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR700KVLEESEEC0@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 08 Aug 2013 17:33:28 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

These local symbols are used only in this file.
Fix the following sparse warnings:

drivers/tty/serial/timbuart.c:165:6: warning: symbol 'timbuart_handle_rx_port' was not declared. Should it be static?
drivers/tty/serial/timbuart.c:187:6: warning: symbol 'timbuart_tasklet' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/timbuart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 6818410..f87097a 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -162,7 +162,7 @@ static void timbuart_handle_tx_port(struct uart_port *port, u32 isr, u32 *ier)
 	dev_dbg(port->dev, "%s - leaving\n", __func__);
 }
 
-void timbuart_handle_rx_port(struct uart_port *port, u32 isr, u32 *ier)
+static void timbuart_handle_rx_port(struct uart_port *port, u32 isr, u32 *ier)
 {
 	if (isr & RXFLAGS) {
 		/* Some RX status is set */
@@ -184,7 +184,7 @@ void timbuart_handle_rx_port(struct uart_port *port, u32 isr, u32 *ier)
 	dev_dbg(port->dev, "%s - leaving\n", __func__);
 }
 
-void timbuart_tasklet(unsigned long arg)
+static void timbuart_tasklet(unsigned long arg)
 {
 	struct timbuart_port *uart = (struct timbuart_port *)arg;
 	u32 isr, ier = 0;
-- 
1.7.10.4


