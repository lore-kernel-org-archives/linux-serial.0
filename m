From: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: [PATCH 3/4] serial: mxs-auart: enable PPS support
Date: Fri, 19 Sep 2014 20:13:18 +0200
Message-ID: <1411150399-30902-3-git-send-email-j.uzycki@elproma.com.pl>
References: <1411150399-30902-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411150399-30902-1-git-send-email-j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Enables PPS support in mxs-auart serial driver to make PPS API working.

Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
