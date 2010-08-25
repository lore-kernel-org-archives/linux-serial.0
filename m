From: Michal Simek <monstr@monstr.eu>
Subject: [PATCH] serial: uartlite: Remove obscure loop from ulite_get_poll_char
Date: Wed, 25 Aug 2010 14:55:04 +0200
Message-ID: <1282740904-1244-2-git-send-email-monstr@monstr.eu>
References: <1282740904-1244-1-git-send-email-monstr@monstr.eu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49501 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab0HYMzL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Aug 2010 08:55:11 -0400
In-Reply-To: <1282740904-1244-1-git-send-email-monstr@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, gregkh@suse.de, Michal Simek <monstr@monstr.eu>, Peter Korsgaard <jacmet@sunsite.dk>

The previous patch
"serial: Add CONSOLE_POLL support for uartlite"
(sha1 id 52ea4a7ef12f286bd68d13a93daaa688f56a1e14)
contained obcure loop in ulite_get_poll_char function.

Signed-off-by: Michal Simek <monstr@monstr.eu>
Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/serial/uartlite.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index c0fae0d..c4bf54b 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -325,7 +325,7 @@ static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
 #ifdef CONFIG_CONSOLE_POLL
 static int ulite_get_poll_char(struct uart_port *port)
 {
-	while (!(ioread32be(port->membase + ULITE_STATUS)
+	if (!(ioread32be(port->membase + ULITE_STATUS)
 						& ULITE_STATUS_RXVALID))
 		return NO_POLL_CHAR;
 
-- 
1.5.5.6

