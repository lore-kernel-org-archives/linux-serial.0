From: Martin Michlmayr <tbm@cyrius.com>
Subject: Update zilog timeout
Date: Mon, 21 May 2007 11:11:11 +0200
Message-ID: <20070521091111.GA31429@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:3147 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512AbXEUJa6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 May 2007 05:30:58 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk, Peter Fuerst <pf@net.alphadv.de>

The following patch has been in the linux-mips tree July 2005 and has
been in Debian for quite a while.  Can it be added to mainline?


From: Thiemo Seufer <ths@networkno.de>
Date: Sun, 3 Jul 2005 18:00:33 +0000 (+0000)
Subject: Update zilog timeout, thanks Peter Fuerst.
X-Git-Tag: linux-2.6.12~42
X-Git-Url: http://www.linux-mips.org/git?p=linux.git;a=commitdiff_plain;h=105487b1c7b5e84023725790d0c9383490d7d8a0;hp=89829912fe22a77f71e4d0a0fffad230d8de4fad

Update zilog timeout, thanks Peter Fuerst.

Signed-off-by: Thiemo Seufer <ths@networkno.de>

---

diff --git a/drivers/serial/ip22zilog.c b/drivers/serial/ip22zilog.c
index 3ea46c0..907ccf7 100644
--- a/drivers/serial/ip22zilog.c
+++ b/drivers/serial/ip22zilog.c
@@ -881,6 +881,7 @@ ip22zilog_set_termios(struct uart_port *port, struct termios *termios,
 	up->cflag = termios->c_cflag;
 
 	ip22zilog_maybe_update_regs(up, ZILOG_CHANNEL_FROM_PORT(port));
+	uart_update_timeout(port, termios->c_cflag, baud);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
@@ -1047,6 +1048,8 @@ ip22serial_console_termios(struct console *con, char *options)
 	}
 
 	con->cflag = cflag | CS8;			/* 8N1 */
+
+	uart_update_timeout(&ip22zilog_port_table[con->index].port, cflag, baud);
 }
 
 static int __init ip22zilog_console_setup(struct console *con, char *options)

-- 
Martin Michlmayr
http://www.cyrius.com/
