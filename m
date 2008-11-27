From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] 8250: when waking, PM hook should be called before accessing port
Date: Wed, 26 Nov 2008 16:25:23 -0800
Message-ID: <1227745523-5408-2-git-send-email-khilman@deeprootsystems.com>
References: <1227745523-5408-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:60969 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbYK0AZa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Nov 2008 19:25:30 -0500
Received: by mail-qy0-f11.google.com with SMTP id 4so1008608qyk.13
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2008 16:25:30 -0800 (PST)
In-Reply-To: <1227745523-5408-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org

The UART suspend hook may have disabled the UART clocks such that
accesses to the port may fail.  So before accessing the port
call the PM hook so it has a chance to enable clocks.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/serial/8250.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 993a242..a181667 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2334,10 +2334,18 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 	      unsigned int oldstate)
 {
 	struct uart_8250_port *p = (struct uart_8250_port *)port;
+	int sleep = state != 0;
 
-	serial8250_set_sleep(p, state != 0);
+	/* If we're waking up, call the PM hook before waking up
+	 * so port can be properly activated/enabled if necessary */
+	if (p->pm && !sleep)
+		p->pm(port, state, oldstate);
+
+	serial8250_set_sleep(p, sleep);
 
-	if (p->pm)
+	/* If we're going to sleep, PM hook should be called after
+	 * to deactivate/disable port */
+	if (p->pm && sleep)
 		p->pm(port, state, oldstate);
 }
 
-- 
1.6.0.3

