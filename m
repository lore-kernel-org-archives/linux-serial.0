From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 1/2] tty: 8250: export serial8250_handle_irq
Date: Fri, 26 Aug 2011 19:04:49 +0100
Message-ID: <1314381890-32691-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43667 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab1HZSFI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 14:05:08 -0400
Received: by wwf5 with SMTP id 5so3766573wwf.1
        for <linux-serial@vger.kernel.org>; Fri, 26 Aug 2011 11:05:07 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Arnd Bergmann <arnd@arndb.de>, Greg KH <greg@kroah.com>

Allow modules to use the normal 8250 irq handler inside their own.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/tty/serial/8250.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 6f594d2..435ce14 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1588,6 +1588,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(serial8250_handle_irq);
 
 static int serial8250_default_handle_irq(struct uart_port *port)
 {
-- 
1.7.4.1

