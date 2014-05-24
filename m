From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] serial: sccnxp: Add IGNPAR flag handling
Date: Sat, 24 May 2014 12:50:27 +0400
Message-ID: <1400921427-17365-2-git-send-email-shc_work@mail.ru>
References: <1400921427-17365-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.179.22]:48736 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750848AbaEXJyT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 24 May 2014 05:54:19 -0400
Received: from smtp9.mail.ru (smtp9.mail.ru [94.100.181.97])
	by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id 5A9F2399E378
	for <linux-serial@vger.kernel.org>; Sat, 24 May 2014 12:50:52 +0400 (MSK)
In-Reply-To: <1400921427-17365-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch add IGNPAR flag handling for the driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 3f5d40a..5443b46 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -672,6 +672,8 @@ static void sccnxp_set_termios(struct uart_port *port,
 	port->ignore_status_mask = 0;
 	if (termios->c_iflag & IGNBRK)
 		port->ignore_status_mask |= SR_BRK;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= SR_PE;
 	if (!(termios->c_cflag & CREAD))
 		port->ignore_status_mask |= SR_PE | SR_OVR | SR_FE | SR_BRK;
 
-- 
1.8.5.5

