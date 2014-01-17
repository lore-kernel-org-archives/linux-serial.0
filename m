From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers: tty: serial: xilinx_uartps: check related config
 macro before processing 'sysrq'
Date: Fri, 17 Jan 2014 23:03:56 +0800
Message-ID: <52D9465C.9000207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48973 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbaAQPD6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Jan 2014 10:03:58 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so4097431pdi.35
        for <linux-serial@vger.kernel.org>; Fri, 17 Jan 2014 07:03:58 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jslaby@suse.cz
Cc: gregkh@linuxfoundation.org, James Hogan <james.hogan@imgtec.com>, linux-serial@vger.kernel.org

Hello Maintainers:

Please help check this patch, when you have time, thanks.

And now I find it is already fixed, but I still feel it can be
improved: "add defined(CONFIG_SERIAL_CORE_CONSOLE)".

Thanks.

-------- Original Message --------
Subject: [PATCH] drivers: tty: serial: xilinx_uartps: check related config macro before processing 'sysrq'
Date: Tue, 10 Dec 2013 13:21:49 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
To: Jiri Slaby <jslaby@suse.cz>
CC: Greg KH <gregkh@linuxfoundation.org>,  James Hogan <james.hogan@imgtec.com>, linux-serial@vger.kernel.org

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



Thanks.
-- 
Chen Gang

Open, share and attitude like air, water and life which God blessed
