From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/12] drivers/serial/ucc_uart.c: Fix compiler warning
Date: Fri, 26 Aug 2011 13:58:12 -0700
Message-ID: <1314392301-25140-3-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37770 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab1HZU6q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:58:46 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Kumar Gala <galak@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Kumar Gala <galak@kernel.crashing.org>

drivers/tty/serial/ucc_uart.c: In function 'qe2cpu_addr':
drivers/tty/serial/ucc_uart.c:238:2: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'dma_addr_t'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Acked-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/ucc_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index c327218..9af9f08 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -235,7 +235,7 @@ static inline void *qe2cpu_addr(dma_addr_t addr, struct uart_qe_port *qe_port)
 		return qe_port->bd_virt + (addr - qe_port->bd_dma_addr);
 
 	/* something nasty happened */
-	printk(KERN_ERR "%s: addr=%x\n", __func__, addr);
+	printk(KERN_ERR "%s: addr=%llx\n", __func__, (u64)addr);
 	BUG();
 	return NULL;
 }
-- 
1.7.6.1

