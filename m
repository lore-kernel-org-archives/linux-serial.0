From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/serial/8250.c: make a variable static
Date: Fri, 15 Apr 2005 17:10:32 +0200
Message-ID: <20050415151032.GG5456@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30738 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261835AbVDOPKd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Apr 2005 11:10:33 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 Mar 2005

--- linux-2.6.11-rc4-mm1-full/drivers/serial/8250.c.old	2005-02-28 23:03:34.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/serial/8250.c	2005-02-28 23:06:55.000000000 +0100
@@ -51,7 +51,7 @@
  *   share_irqs - whether we pass SA_SHIRQ to request_irq().  This option
  *                is unsafe when used on edge-triggered interrupts.
  */
-unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
+static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
 
 /*
  * Debugging.
