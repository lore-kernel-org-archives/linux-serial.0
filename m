From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 33/79] TTY: use tty_wait_until_sent_from_close in tty_port_close_start
Date: Wed, 26 Oct 2011 14:12:38 +0200
Message-ID: <1319631204-23262-33-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60994 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932871Ab1JZMNm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:42 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E95A18FC93
	for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2011 14:13:41 +0200 (CEST)
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Let's use the newly added helper to avoid stalls in drivers which are
already ported to tty_port helpers.

We have to ensure here, that there is no user of tty_port_close_start
and tty_port_close which holds port->mutex (or other) lock over them.
And sure, there is none.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
1.7.7

