From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 07/12] serial: clps711x: Fix break control handling
Date: Sun, 14 Oct 2012 11:05:29 +0400
Message-ID: <1350198334-18737-7-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:45475 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHGR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:06:17 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 7b0e539..73505c1 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -218,12 +218,14 @@ static void clps711xuart_break_ctl(struct uart_port *port, int break_state)
 	unsigned int ubrlcr;
 
 	spin_lock_irqsave(&port->lock, flags);
+
 	ubrlcr = clps_readl(UBRLCR(port));
-	if (break_state == -1)
+	if (break_state)
 		ubrlcr |= UBRLCR_BREAK;
 	else
 		ubrlcr &= ~UBRLCR_BREAK;
 	clps_writel(ubrlcr, UBRLCR(port));
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-- 
1.7.8.6

