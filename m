From: David Miller <davem@davemloft.net>
Subject: [PATCH 1/2]: serial: Make uart_port's ioport "unsigned long".
Date: Fri, 12 Sep 2008 21:18:56 -0700 (PDT)
Message-ID: <20080912.211856.146245018.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34981
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751304AbYIMETD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Sep 2008 00:19:03 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, joy@entuzijast.net


serial: Make uart_port's ioport "unsigned long".

Otherwise the top 32-bits of the resource value get chopped
off on 64-bit systems, and the resulting I/O accesses go to
random places.

Thanks to testing and debugging by Josip Rodin, which helped
track this down.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 include/linux/serial_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3b2f6c0..e27f216 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -241,7 +241,7 @@ typedef unsigned int __bitwise__ upf_t;
 
 struct uart_port {
 	spinlock_t		lock;			/* port lock */
-	unsigned int		iobase;			/* in/out[bwl] */
+	unsigned long		iobase;			/* in/out[bwl] */
 	unsigned char __iomem	*membase;		/* read/write[bwl] */
 	unsigned int		irq;			/* irq number */
 	unsigned int		uartclk;		/* base uart clock */
-- 
1.5.6.5.GIT

