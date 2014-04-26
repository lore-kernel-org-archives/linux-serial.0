From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH] tty: serial: 8250_core.c Bug fix for Exar chips.
Date: Fri, 25 Apr 2014 19:27:48 -0500
Message-ID: <1398472068-11762-1-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:55272 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbaDZA2E (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 20:28:04 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Michael Welling <mwelling@ieee.org>

The sleep function was updated to put the serial port to sleep only whe=
n necessary.
This appears to resolve the errant behavior of the driver as described =
in
Kernel Bug 61961 =E2=80=93 "My Exar Corp. XR17C/D152 Dual PCI UART mode=
m does not
work with 3.8.0".

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/tty/serial/8250/8250_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
index 81f909c..1d32355 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -555,7 +555,7 @@ static void serial8250_set_sleep(struct uart_8250_p=
ort *p, int sleep)
 	 */
 	if ((p->port.type =3D=3D PORT_XR17V35X) ||
 	   (p->port.type =3D=3D PORT_XR17D15X)) {
-		serial_out(p, UART_EXAR_SLEEP, 0xff);
+		serial_out(p, UART_EXAR_SLEEP, sleep ? 0xff : 0);
 		return;
 	}
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
