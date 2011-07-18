From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/3] MIPS: lantiq: set timeout in uart_port
Date: Mon, 18 Jul 2011 22:04:13 +0200
Message-ID: <1311019453-21277-3-git-send-email-blogic@openwrt.org>
References: <1311019453-21277-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:49945 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab1GRUDG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jul 2011 16:03:06 -0400
In-Reply-To: <1311019453-21277-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <blogic@openwrt.org>, Thomas Langer <thomas.langer@lantiq.com>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

Without this patch apps using readline hang.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/lantiq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 58cf279..bc95f52 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -478,8 +478,10 @@ lqasc_set_termios(struct uart_port *port,
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 
 	/* Don't rewrite B0 */
-        if (tty_termios_baud_rate(new))
+	if (tty_termios_baud_rate(new))
 		tty_termios_encode_baud_rate(new, baud, baud);
+
+	uart_update_timeout(port, cflag, baud);
 }
 
 static const char*
-- 
1.7.2.3

