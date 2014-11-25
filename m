From: Arianna Avanzini <avanzini.arianna@gmail.com>
Subject: [PATCH] tty, serial, 8250: remove __init from function serial8250_console_setup()
Date: Tue, 25 Nov 2014 23:21:22 +0100
Message-ID: <1416954082-1755-1-git-send-email-avanzini.arianna@gmail.com>
References: <20141125175121.GA32573@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34943 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaKYWV1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2014 17:21:27 -0500
In-Reply-To: <20141125175121.GA32573@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: avanzini.arianna@gmail.com

Some RS232 adapters handled by this driver are hotpluggable. The function
serial8250_console_setup() is called during device init and is defined with
the __init macro. In case the driver is built-in, hotplugging the device after
the initialization phase has been completed (and the related memory has been
freed) results in a kernel crash.
This commit fixes the issue by removing __init from the function definition.

Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ca5cfdc..ca8108d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3237,7 +3237,7 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
 	serial8250_rpm_put(up);
 }
 
-static int __init serial8250_console_setup(struct console *co, char *options)
+static int serial8250_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 9600;
-- 
2.1.3

