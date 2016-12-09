From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] tty: serial: fsl_lpuart: potential NULL dereference
Date: Sat, 10 Dec 2016 01:30:36 +0300
Message-ID: <1481322636-30847-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

tty_port_tty_get() might return a tty which is NULL
if the port is not associated with a tty
(e.g. due to close or hangup).
But lpuart_start_rx_dma() dereferences tty without any check.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/tty/serial/fsl_lpuart.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 76103f2c4a80..9945b37c914a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -833,9 +833,16 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	struct circ_buf *ring = &sport->rx_ring;
 	int ret, nent;
 	int bits, baud;
-	struct tty_struct *tty = tty_port_tty_get(&sport->port.state->port);
-	struct ktermios *termios = &tty->termios;
+	struct tty_struct *tty;
+	struct ktermios *termios;
 
+	tty = tty_port_tty_get(&sport->port.state->port);
+	if (!tty) {
+		dev_err(sport->port.dev, "Port is not associated with a tty\n");
+		return -ENODEV;
+	}
+
+	termios = &tty->termios;
 	baud = tty_get_baud_rate(tty);
 
 	bits = (termios->c_cflag & CSIZE) == CS7 ? 9 : 10;
-- 
2.7.4
