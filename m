From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 3/4] serial: mxs-auart: enable PPS support
Date: Fri, 19 Sep 2014 20:08:55 +0200
Message-ID: <1411150136-30791-3-git-send-email-j.uzycki@elproma.com.pl>
References: <1411150136-30791-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:52421 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756626AbaISSG2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 14:06:28 -0400
In-Reply-To: <1411150136-30791-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

Enables PPS support in mxs-auart serial driver to make PPS API working.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index c2f24f8..9381732 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -797,6 +797,15 @@ static void mxs_auart_settermios(struct uart_port *u,
 		mxs_auart_disable_ms(u);
 }
 
+static void mxs_auart_set_ldisc(struct uart_port *port, int new)
+{
+	if (new == N_PPS) {
+		port->flags |= UPF_HARDPPS_CD;
+		mxs_auart_enable_ms(port);
+	} else
+		port->flags &= ~UPF_HARDPPS_CD;
+}
+
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
 	u32 istat;
@@ -963,6 +972,7 @@ static struct uart_ops mxs_auart_ops = {
 	.startup	= mxs_auart_startup,
 	.shutdown       = mxs_auart_shutdown,
 	.set_termios    = mxs_auart_settermios,
+	.set_ldisc      = mxs_auart_set_ldisc,
 	.type	   	= mxs_auart_type,
 	.release_port   = mxs_auart_release_port,
 	.request_port   = mxs_auart_request_port,
-- 
1.7.11.3

