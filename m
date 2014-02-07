From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 4/6] serial: max310x: Remove excess port configure at startup
Date: Fri,  7 Feb 2014 18:16:06 +0400
Message-ID: <1391782568-19442-5-git-send-email-shc_work@mail.ru>
References: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:37330 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbaBGOQk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 09:16:40 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id C6289F7E21F4
	for <linux-serial@vger.kernel.org>; Fri,  7 Feb 2014 18:16:38 +0400 (MSK)
In-Reply-To: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

Serial core calls set_termios() after port startup, so there are
no reason to setup port twice.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 202c1fb..1fb3895 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -896,12 +896,6 @@ static int max310x_startup(struct uart_port *port)
 
 	s->devtype->power(port, 1);
 
-	/* Configure baud rate, 9600 as default */
-	max310x_set_baud(port, 9600);
-
-	/* Configure LCR register, 8N1 mode by default */
-	max310x_port_write(port, MAX310X_LCR_REG, MAX310X_LCR_WORD_LEN_8);
-
 	/* Configure MODE1 register */
 	max310x_port_update(port, MAX310X_MODE1_REG,
 			    MAX310X_MODE1_TRNSCVCTRL_BIT,
-- 
1.8.3.2

