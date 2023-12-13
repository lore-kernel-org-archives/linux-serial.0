Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0EDB
	for <linux-serial@vger.kernel.org>; Wed, 13 Dec 2023 09:43:21 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDTGR-0005gK-52; Wed, 13 Dec 2023 18:43:19 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDTGQ-00FcfT-EO; Wed, 13 Dec 2023 18:43:18 +0100
Received: from ukl by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDTGQ-009p0h-1G;
	Wed, 13 Dec 2023 18:43:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] serial: 8250-fsl: Only do the break workaround if IIR signals RLSI
Date: Wed, 13 Dec 2023 18:43:12 +0100
Message-Id: <20231213174312.2341013-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

It can happen that while a break is received the transmitter gets empty
and IIR signals a Transmitter holding register empty (THRI) event. In
this case it's too early for the break workaround. Still doing it then
results in the THRI event not being rereported which makes the driver
miss that and e.g. for RS485 half-duplex communication it fails to
switch back to RX mode.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_fsl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Hello,

I already sent this patch some time ago in a series with two other
patches. One of them got negative review feedback (and wasn't applied)
the other was applied as commit d2d4bd217ccd ("serial: 8250-fsl: Expand
description of the MPC83xx UART's misbehaviour"). This one didn't
receive any feedback (and wasn't applied, too).

So here comes the patch again, rebased to today's next.
See
https://lore.kernel.org/linux-serial/20230524122754.481816-4-u.kleine-koenig@pengutronix.de
for the previous submission.

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 5cf675eadefe..b4ed442082a8 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -51,7 +51,8 @@ int fsl8250_handle_irq(struct uart_port *port)
 	 * immediately and interrupt the CPU again. The hardware clears LSR.BI
 	 * when the next valid char is read.)
 	 */
-	if (unlikely(up->lsr_saved_flags & UART_LSR_BI)) {
+	if (unlikely((iir & UART_IIR_ID) == UART_IIR_RLSI &&
+		     (up->lsr_saved_flags & UART_LSR_BI))) {
 		up->lsr_saved_flags &= ~UART_LSR_BI;
 		port->serial_in(port, UART_RX);
 		uart_port_unlock_irqrestore(&up->port, flags);
-- 
2.39.2

