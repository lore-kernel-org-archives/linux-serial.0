From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 3/3] tty: Flush tty buffers after hardware shutdown
Date: Wed,  5 Nov 2014 12:40:05 -0500
Message-ID: <1415209205-16309-4-git-send-email-peter@hurleysoftware.com>
References: <1415209205-16309-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:57118 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754949AbaKERkT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 12:40:19 -0500
In-Reply-To: <1415209205-16309-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

The line discipline buffer and the tty buffers must be flushed again
after hardware shutdown; otherwise, a brief window exists between the
ldisc flush in tty_port_close_start() and the subsequent
tty_port_shutdown(), during which more data could be received into the
tty buffers. A racing open might then be able to receive data from the
previous session.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 3b641d1..4d9abaa 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -520,6 +520,7 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 {
 	unsigned long flags;
 
+	tty_ldisc_flush(tty);
 	tty->closing = 0;
 
 	spin_lock_irqsave(&port->lock, flags);
-- 
2.1.3

