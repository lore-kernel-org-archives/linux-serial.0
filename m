From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: sccnxp: Improve verify_port
Date: Tue, 14 May 2013 19:27:29 +0400
Message-ID: <1368545249-29374-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:47412 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab3ENP2G (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 May 2013 11:28:06 -0400
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [94.100.177.113])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id D5F6DE0CE39F
	for <linux-serial@vger.kernel.org>; Tue, 14 May 2013 19:28:00 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index c773041..92e6195 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -713,8 +713,8 @@ static void sccnxp_config_port(struct uart_port *port, int flags)
 
 static int sccnxp_verify_port(struct uart_port *port, struct serial_struct *s)
 {
-	if ((s->type == PORT_UNKNOWN) || (s->type == PORT_SC26XX))
-		return 0;
+	if ((s->type != PORT_UNKNOWN) && (s->type != PORT_SC26XX))
+		return -EINVAL;
 	if (s->irq == port->irq)
 		return 0;
 
-- 
1.8.1.5

