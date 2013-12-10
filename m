From: James Hogan <james@albanarts.com>
Subject: [PATCH] serial: 8250_dw: Fix LCR workaround regression
Date: Tue, 10 Dec 2013 22:28:04 +0000
Message-ID: <1386714484-30251-1-git-send-email-james@albanarts.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, James Hogan <james.hogan@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Tim Kryger <tim.kryger@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matt Porter <matt.porter@linaro.org>, Markus Mayer <markus.mayer@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

From: James Hogan <james.hogan@imgtec.com>

Commit c49436b657d0 (serial: 8250_dw: Improve unwritable LCR workaround)
caused a regression. It added a check that the LCR was written properly
to detect and workaround the busy quirk, but the behaviour of bit 5
(UART_LCR_SPAR) differs between IP versions 3.00a and 3.14c per the
docs. On older versions this caused the check to fail and it would
repeatedly force idle and rewrite the LCR register, causing delays and
preventing any input from serial being received.

This is fixed by masking out UART_LCR_SPAR before making the comparison.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Tim Kryger <tim.kryger@linaro.org>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Matt Porter <matt.porter@linaro.org>
Cc: Markus Mayer <markus.mayer@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Tim Kryger <tim.kryger@linaro.org>
Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/tty/serial/8250/8250_dw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 4658e3e..5f096c7 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -96,7 +96,8 @@ static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 	if (offset == UART_LCR) {
 		int tries = 1000;
 		while (tries--) {
-			if (value == p->serial_in(p, UART_LCR))
+			unsigned int lcr = p->serial_in(p, UART_LCR);
+			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 				return;
 			dw8250_force_idle(p);
 			writeb(value, p->membase + (UART_LCR << p->regshift));
@@ -132,7 +133,8 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 	if (offset == UART_LCR) {
 		int tries = 1000;
 		while (tries--) {
-			if (value == p->serial_in(p, UART_LCR))
+			unsigned int lcr = p->serial_in(p, UART_LCR);
+			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 				return;
 			dw8250_force_idle(p);
 			writel(value, p->membase + (UART_LCR << p->regshift));
-- 
1.8.3.2
