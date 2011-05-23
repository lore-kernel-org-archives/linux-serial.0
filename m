From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 17/48] Char: moxa, do not touch NORMAL_ACTIVE bit
Date: Mon, 23 May 2011 12:10:23 -0700
Message-ID: <1306177854-18172-17-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47294 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTKq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:46 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

The bit is set in tty_port_block_til_ready (via moxa_open) and unset
in tty_port_close (via moxa_close). No need to pin it in the driver.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/moxa.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index ffdaab3..a290e9e 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1129,7 +1129,6 @@ static void moxa_shutdown(struct tty_port *port)
 	struct moxa_port *ch = container_of(port, struct moxa_port, port);
         MoxaPortDisable(ch);
 	MoxaPortFlushData(ch, 2);
-	clear_bit(ASYNCB_NORMAL_ACTIVE, &port->flags);
 }
 
 static int moxa_carrier_raised(struct tty_port *port)
@@ -1155,7 +1154,6 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 	struct moxa_board_conf *brd;
 	struct moxa_port *ch;
 	int port;
-	int retval;
 
 	port = tty->index;
 	if (port == MAX_PORTS) {
@@ -1190,10 +1188,7 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 	mutex_unlock(&ch->port.mutex);
 	mutex_unlock(&moxa_openlock);
 
-	retval = tty_port_block_til_ready(&ch->port, tty, filp);
-	if (retval == 0)
-	        set_bit(ASYNCB_NORMAL_ACTIVE, &ch->port.flags);
-	return retval;
+	return tty_port_block_til_ready(&ch->port, tty, filp);
 }
 
 static void moxa_close(struct tty_struct *tty, struct file *filp)
-- 
1.7.4.2

