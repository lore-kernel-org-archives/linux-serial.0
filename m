From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/48] Char: moxa, remove unused variables
Date: Mon, 23 May 2011 12:06:25 -0700
Message-ID: <1306177625-17885-8-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177625-17885-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47302 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932747Ab1EWTQV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:16:21 -0400
In-Reply-To: <1306177625-17885-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

drivers/tty/moxa.c:1287:2: warning: Value stored to 'port' is never read
        port = tty->index;
        ^      ~~~~~~~~~~
drivers/tty/moxa.c:1763:2: warning: Value stored to 'cflag' is never read
        cflag = termio->c_cflag;        /* termio->c_cflag */
        ^       ~~~~~~~~~~~~~~~

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/moxa.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 35b0c38..ffdaab3 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1281,10 +1281,8 @@ static int moxa_tiocmset(struct tty_struct *tty,
 			 unsigned int set, unsigned int clear)
 {
 	struct moxa_port *ch;
-	int port;
 	int dtr, rts;
 
-	port = tty->index;
 	mutex_lock(&moxa_openlock);
 	ch = tty->driver_data;
 	if (!ch) {
@@ -1756,11 +1754,9 @@ static int MoxaPortSetTermio(struct moxa_port *port, struct ktermios *termio,
 		speed_t baud)
 {
 	void __iomem *ofsAddr;
-	tcflag_t cflag;
 	tcflag_t mode = 0;
 
 	ofsAddr = port->tableAddr;
-	cflag = termio->c_cflag;	/* termio->c_cflag */
 
 	mode = termio->c_cflag & CSIZE;
 	if (mode == CS5)
-- 
1.7.4.2

