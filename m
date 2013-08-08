From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 01/10] serial: samsung: fix casting warning
Date: Thu, 08 Aug 2013 17:29:48 +0900
Message-ID: <005901ce9411$7201ab70$56050250$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:15119 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416Ab3HHI3u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 04:29:50 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR700EVEE9M4980@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 08 Aug 2013 17:29:49 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

port->membase is (unsigned char __iomem *), not (unsigned long *)
__set_bit() uses (unsigned long *) as the second argument.
Thus, casting (unsigned long *)(unsigned long) is necessary
to fix the following sparse warnings.

drivers/tty/serial/samsung.c:142:33: warning: cast removes address space of expression
drivers/tty/serial/samsung.c:161:33: warning: cast removes address space of expression
drivers/tty/serial/samsung.c:176:33: warning: cast removes address space of expression
drivers/tty/serial/samsung.c:526:40: warning: cast removes address space of expression

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/samsung.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 00a499e..aaa617a 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -68,7 +68,8 @@ struct s3c24xx_uart_port {
 /* register access controls */
 
 #define portaddr(port, reg) ((port)->membase + (reg))
-#define portaddrl(port, reg) ((unsigned long *)((port)->membase + (reg)))
+#define portaddrl(port, reg) \
+	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
 #define rd_regb(port, reg) (__raw_readb(portaddr(port, reg)))
 #define rd_regl(port, reg) (__raw_readl(portaddr(port, reg)))
-- 
1.7.10.4


