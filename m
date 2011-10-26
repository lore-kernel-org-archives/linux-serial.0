From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 43/79] tty: 8250: export serial8250_handle_irq
Date: Wed, 26 Oct 2011 14:12:48 +0200
Message-ID: <1319631204-23262-43-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32786 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932871Ab1JZMNr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:47 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jamie Iles <jamie@jamieiles.com>

Allow modules to use the normal 8250 irq handler inside their own.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
1.7.7

