From: Corbin Atkinson <corbinat@gmail.com>
Subject: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Fri,  4 May 2012 12:35:10 -0500
Message-ID: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59386 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab2EDRgL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 May 2012 13:36:11 -0400
Received: by obbtb18 with SMTP id tb18so4238875obb.19
        for <linux-serial@vger.kernel.org>; Fri, 04 May 2012 10:36:11 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Corbin Atkinson <corbin.atkinson@ni.com>

Currently, serial drivers don't report buffer overruns. When a buffer overrun
occurs, tty_insert_flip_char returns 0, and no attempt is made to insert that
same character again (i.e. it is lost). This patch reports buffer overruns via
the buf_overrun field in the port's icount structure.

Signed-off-by: Corbin Atkinson <corbin.atkinson@ni.com>
---
 drivers/tty/serial/serial_core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c4c05b..59fb3ba 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2526,14 +2526,16 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 	struct tty_struct *tty = port->state->port.tty;
 
 	if ((status & port->ignore_status_mask & ~overrun) == 0)
-		tty_insert_flip_char(tty, ch, flag);
+		if (tty_insert_flip_char(tty, ch, flag) == 0)
+			++port->icount.buf_overrun;
 
 	/*
 	 * Overrun is special.  Since it's reported immediately,
 	 * it doesn't affect the current character.
 	 */
 	if (status & ~port->ignore_status_mask & overrun)
-		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+		if (tty_insert_flip_char(tty, 0, TTY_OVERRUN) == 0)
+			++port->icount.buf_overrun;
 }
 EXPORT_SYMBOL_GPL(uart_insert_char);
 
-- 
1.7.5.4

