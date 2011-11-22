From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] serial/mxs-auart: only wake up tty layer once
Date: Tue, 22 Nov 2011 14:22:56 +0100
Message-ID: <1321968177-16039-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1321968177-16039-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43005 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab1KVNXd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Nov 2011 08:23:33 -0500
In-Reply-To: <1321968177-16039-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: kernel@pengutronix.de, linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>

There is no need to call uart_write_wakeup after each character send.
Once at the end of the write sequence is enough.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/mxs-auart.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-au=
art.c
index 7e02c9c..076169f 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -145,11 +145,12 @@ static inline void mxs_auart_tx_chars(struct mxs_=
auart_port *s)
 			writel(xmit->buf[xmit->tail],
 				     s->port.membase + AUART_DATA);
 			xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-			if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-				uart_write_wakeup(&s->port);
 		} else
 			break;
 	}
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&s->port);
+
 	if (uart_circ_empty(&(s->port.state->xmit)))
 		writel(AUART_INTR_TXIEN,
 			     s->port.membase + AUART_INTR_CLR);
--=20
1.7.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
