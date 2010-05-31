From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/2] serial: bfin_5xx: fix typo in IER check
Date: Mon, 31 May 2010 07:29:32 -0400
Message-ID: <1275305372-20523-2-git-send-email-vapier@gentoo.org>
References: <1275305372-20523-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:37691 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516Ab0EaLZS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 31 May 2010 07:25:18 -0400
In-Reply-To: <1275305372-20523-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

This most likely won't cause problems on systems as people don't typically
enable GPIO RTS/CTS if they don't actually use it.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/serial/bfin_5xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index a78652b..511cbf6 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -797,7 +797,7 @@ static void bfin_serial_shutdown(struct uart_port *port)
 		gpio_free(uart->rts_pin);
 #endif
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
-	if (UART_GET_IER(uart) && EDSSI)
+	if (UART_GET_IER(uart) & EDSSI)
 		free_irq(uart->status_irq, uart);
 #endif
 }
-- 
1.7.1

