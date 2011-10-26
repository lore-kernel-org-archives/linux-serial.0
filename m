From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 78/79] tty/serial: atmel_serial: bootconsole removed from auto-enumerates
Date: Wed, 26 Oct 2011 14:13:23 +0200
Message-ID: <1319631204-23262-78-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32887 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932977Ab1JZMOG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:06 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Auto-enumerate mechanism conflicts with bootconsoles: remove
the usage counter for this type of consoles.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/atmel_serial.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index fc4081e..358bbb2 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1674,7 +1674,6 @@ static int __init atmel_console_init(void)
 		int id = atmel_default_console_device->id;
 		struct atmel_uart_port *port = &atmel_ports[id];
 
-		set_bit(id, &atmel_ports_in_use);
 		port->backup_imr = 0;
 		port->uart.line = id;
 
-- 
1.7.7

