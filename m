From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 29/76] atmel_serial: enable PPS support
Date: Wed, 16 Mar 2011 14:11:59 -0700
Message-ID: <1300309966-5745-29-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33007 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab1CPVNv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:51 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Viktar Palstsiuk <viktar.palstsiuk@promwad.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Viktar Palstsiuk <viktar.palstsiuk@promwad.com>

Enables PPS support in atmel serial driver to make PPS API working.

Signed-off-by: Viktar Palstsiuk <viktar.palstsiuk@promwad.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/atmel_serial.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2a1d52f..f119d17 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1240,6 +1240,21 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static void atmel_set_ldisc(struct uart_port *port, int new)
+{
+	int line = port->line;
+
+	if (line >= port->state->port.tty->driver->num)
+		return;
+
+	if (port->state->port.tty->ldisc->ops->num == N_PPS) {
+		port->flags |= UPF_HARDPPS_CD;
+		atmel_enable_ms(port);
+	} else {
+		port->flags &= ~UPF_HARDPPS_CD;
+	}
+}
+
 /*
  * Return string describing the specified port
  */
@@ -1380,6 +1395,7 @@ static struct uart_ops atmel_pops = {
 	.shutdown	= atmel_shutdown,
 	.flush_buffer	= atmel_flush_buffer,
 	.set_termios	= atmel_set_termios,
+	.set_ldisc	= atmel_set_ldisc,
 	.type		= atmel_type,
 	.release_port	= atmel_release_port,
 	.request_port	= atmel_request_port,
-- 
1.7.4.1

