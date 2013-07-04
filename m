From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial/mxs-auart: fix race condition in interrupt handler
Date: Thu,  4 Jul 2013 11:28:51 +0200
Message-ID: <1372930141-20126-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The handler needs to ack the pending events before actually handling th=
em.
Otherwise a new event might come in after it it considered non-pending =
or
handled and is acked then without being handled. So this event is only
noticed when the next interrupt happens.

Without this patch an i.MX28 based machine running an rt-patched kernel
regularly hangs during boot.

Cc: stable@vger.kernel.org # v2.6.39+
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/mxs-auart.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-au=
art.c
index 7645079..f85b8e6 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -678,11 +678,18 @@ static void mxs_auart_settermios(struct uart_port=
 *u,
=20
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
-	u32 istatus, istat;
+	u32 istat;
 	struct mxs_auart_port *s =3D context;
 	u32 stat =3D readl(s->port.membase + AUART_STAT);
=20
-	istatus =3D istat =3D readl(s->port.membase + AUART_INTR);
+	istat =3D readl(s->port.membase + AUART_INTR);
+
+	/* ack irq */
+	writel(istat & (AUART_INTR_RTIS
+		| AUART_INTR_TXIS
+		| AUART_INTR_RXIS
+		| AUART_INTR_CTSMIS),
+			s->port.membase + AUART_INTR_CLR);
=20
 	if (istat & AUART_INTR_CTSMIS) {
 		uart_handle_cts_change(&s->port, stat & AUART_STAT_CTS);
@@ -702,12 +709,6 @@ static irqreturn_t mxs_auart_irq_handle(int irq, v=
oid *context)
 		istat &=3D ~AUART_INTR_TXIS;
 	}
=20
-	writel(istatus & (AUART_INTR_RTIS
-		| AUART_INTR_TXIS
-		| AUART_INTR_RXIS
-		| AUART_INTR_CTSMIS),
-			s->port.membase + AUART_INTR_CLR);
-
 	return IRQ_HANDLED;
 }
=20
--=20
1.8.3.2
