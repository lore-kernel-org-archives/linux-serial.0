From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH] serial: mxs-auart: enable PPS support
Date: Sat, 27 Sep 2014 15:36:38 +0200
Message-ID: <1411824998-24050-1-git-send-email-j.uzycki@elproma.com.pl>
References: <5426B1F0.9050006@cogentembedded.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:53082 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751890AbaI0NeK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Sep 2014 09:34:10 -0400
In-Reply-To: <5426B1F0.9050006@cogentembedded.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

Enables PPS support in mxs-auart serial driver to make PPS API working.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4c238bf..fc262ba 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -782,6 +782,16 @@ static void mxs_auart_settermios(struct uart_port *u,
 		mxs_auart_disable_ms(u);
 }
 
+static void mxs_auart_set_ldisc(struct uart_port *port, int new)
+{
+	if (new == N_PPS) {
+		port->flags |= UPF_HARDPPS_CD;
+		mxs_auart_enable_ms(port);
+	} else {
+		port->flags &= ~UPF_HARDPPS_CD;
+	}
+}
+
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
 	u32 istat;
@@ -949,6 +959,7 @@ static struct uart_ops mxs_auart_ops = {
 	.startup	= mxs_auart_startup,
 	.shutdown       = mxs_auart_shutdown,
 	.set_termios    = mxs_auart_settermios,
+	.set_ldisc      = mxs_auart_set_ldisc,
 	.type	   	= mxs_auart_type,
 	.release_port   = mxs_auart_release_port,
 	.request_port   = mxs_auart_request_port,
-- 
1.7.11.3

