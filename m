From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH] tty: xuartps: Properly guard sysrq specific code
Date: Mon,  2 Dec 2013 11:38:38 -0800
Message-ID: <1386013118-25280-1-git-send-email-soren.brinkmann@xilinx.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:37738 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab3LBTi7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Dec 2013 14:38:59 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Vlad Lungu <vlad.lungu@windriver.com>

Commit 'tty: xuartps: Implement BREAK detection, add SYSRQ support'
(0c0c47bc40a2e358d593b2d7fb93b50027fbfc0c) introduced sysrq support
without properly guarding sysrq specific code which results in build
errors when sysrq is disabled:
	DNAME=KBUILD_STR(xilinx_uartps)" -c -o
	drivers/tty/serial/.tmp_xilinx_uartps.o
	drivers/tty/serial/xilinx_uartps.c
	drivers/tty/serial/xilinx_uartps.c: In function 'xuartps_isr':
	drivers/tty/serial/xilinx_uartps.c:247:5: error: 'struct uart_port'
	has no member named 'sysrq'
	drivers/tty/serial/xilinx_uartps.c:247:5: error: 'struct uart_port'
	has no member named 'sysrq'
	drivers/tty/serial/xilinx_uartps.c:247:5: error: 'struct uart_port'
	has no member named 'sysrq'
	make[3]: *** [drivers/tty/serial/xilinx_uartps.o] Error 1

Reported-by: Masanari Iida <standby24x7@gmail.com>
Cc: Vlad Lungu <vlad.lungu@windriver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e46e9f3f19b9..f619ad5b5eae 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -240,6 +240,7 @@ static irqreturn_t xuartps_isr(int irq, void *dev_id)
 					continue;
 			}
 
+#ifdef SUPPORT_SYSRQ
 			/*
 			 * uart_handle_sysrq_char() doesn't work if
 			 * spinlocked, for some reason
@@ -253,6 +254,7 @@ static irqreturn_t xuartps_isr(int irq, void *dev_id)
 				}
 				spin_lock(&port->lock);
 			}
+#endif
 
 			port->icount.rx++;
 
-- 
1.8.4.4

