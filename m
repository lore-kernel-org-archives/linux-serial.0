From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial: use DIV_ROUND_CLOSEST instead of open coding it
Date: Tue, 20 Dec 2011 11:47:44 +0100
Message-ID: <1324378064-7208-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40583 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab1LTKrs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Dec 2011 05:47:48 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/serial_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
index 0406d7f..a05afc3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -423,7 +423,7 @@ uart_get_divisor(struct uart_port *port, unsigned i=
nt baud)
 	if (baud =3D=3D 38400 && (port->flags & UPF_SPD_MASK) =3D=3D UPF_SPD_=
CUST)
 		quot =3D port->custom_divisor;
 	else
-		quot =3D (port->uartclk + (8 * baud)) / (16 * baud);
+		quot =3D DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
=20
 	return quot;
 }
--=20
1.7.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
