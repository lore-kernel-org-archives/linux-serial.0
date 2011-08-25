From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/5] TTY: use tty_wait_until_sent_from_close in tty_port_close_start
Date: Thu, 25 Aug 2011 15:12:07 +0200
Message-ID: <1314277928-13388-4-git-send-email-jslaby@suse.cz>
References: <4E556CB7.2010102@suse.cz>
 <1314277928-13388-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.pripojeni.net ([178.22.112.14]:49566 "EHLO
	smtp.pripojeni.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab1HYNMR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Aug 2011 09:12:17 -0400
In-Reply-To: <1314277928-13388-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: Arnd Bergmann <arnd@arndb.de>, alan@linux.intel.com, linux-serial@vger.kernel.org, jirislaby@gmail.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

Let's use the newly added helper to avoid stalls in drivers which are
already ported to tty_port helpers.

We have to ensure here, that there is no user of tty_port_close_start
and tty_port_close which holds port->mutex (or other) lock over them.
And sure, there is none.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_port.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 33d37d2..ef9dd62 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -350,7 +350,7 @@ int tty_port_close_start(struct tty_port *port,
 		tty_driver_flush_buffer(tty);
 	if (test_bit(ASYNCB_INITIALIZED, &port->flags) &&
 			port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, port->closing_wait);
+		tty_wait_until_sent_from_close(tty, port->closing_wait);
 	if (port->drain_delay) {
 		unsigned int bps = tty_get_baud_rate(tty);
 		long timeout;
-- 
1.7.6


