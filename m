From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] serial: mxs: fix buffer overflow
Date: Fri, 19 Apr 2013 21:12:17 +0200
Message-ID: <1366398737-28928-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34010 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504Ab3DSTMY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Apr 2013 15:12:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huang Shijie <b32955@freescale.com>, kernel@pengutronix.de, Wolfram Sang <wsa@the-dreams.de>

SMATCH correctly found an off-by-one error:

drivers/tty/serial/mxs-auart.c:889 auart_console_write() error: buffer overflow 'auart_port' 5 <= 5

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

I'd say this is suitable for stable.

 drivers/tty/serial/mxs-auart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 3c2d8be..62e7d3b 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -883,7 +883,7 @@ auart_console_write(struct console *co, const char *str, unsigned int count)
 	unsigned int old_ctrl0, old_ctrl2;
 	unsigned int to = 1000;
 
-	if (co->index >	MXS_AUART_PORTS || co->index < 0)
+	if (co->index >= MXS_AUART_PORTS || co->index < 0)
 		return;
 
 	s = auart_port[co->index];
-- 
1.7.10.4

