From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] drivers: tty: serial: xilinx_uartps: check related config
 macro before processing 'sysrq'
Date: Tue, 10 Dec 2013 13:21:49 +0800
Message-ID: <52A6A4ED.60700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:64528 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab3LJFTf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Dec 2013 00:19:35 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so6839845pbc.25
        for <linux-serial@vger.kernel.org>; Mon, 09 Dec 2013 21:19:35 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, James Hogan <james.hogan@imgtec.com>, linux-serial@vger.kernel.org

Need check CONFIG_SERIAL_CORE_CONSOLE or SUPPORT_SYSRQ just like the
structure definiation has done. Or may cause compiling issue.

The related error (with allmodconfig for metag):

    CC [M]  drivers/tty/serial/xilinx_uartps.o
  drivers/tty/serial/xilinx_uartps.c: In function 'xuartps_isr':
  drivers/tty/serial/xilinx_uartps.c:247: error: 'struct uart_port' has no member named 'sysrq'


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/tty/serial/xilinx_uartps.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e46e9f3..1501e6b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -244,6 +244,7 @@ static irqreturn_t xuartps_isr(int irq, void *dev_id)
 			 * uart_handle_sysrq_char() doesn't work if
 			 * spinlocked, for some reason
 			 */
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
 			 if (port->sysrq) {
 				spin_unlock(&port->lock);
 				if (uart_handle_sysrq_char(port,
@@ -253,7 +254,7 @@ static irqreturn_t xuartps_isr(int irq, void *dev_id)
 				}
 				spin_lock(&port->lock);
 			}
-
+#endif
 			port->icount.rx++;
 
 			if (isrstatus & XUARTPS_IXR_PARITY) {
-- 
1.7.7.6
