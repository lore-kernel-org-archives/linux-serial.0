From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] serial: sh-sci: Fix hang in sci_reset()
Date: Fri,  2 Dec 2016 13:35:11 +0100
Message-ID: <1480682111-9299-3-git-send-email-geert+renesas@glider.be>
References: <1480682111-9299-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1480682111-9299-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

When the .set_termios() callback resets the UART, it first waits until
all characters in the transmit FIFO have been transmitted, to prevent a
port configuration change from impacting these characters.

However, if the previous user of the UART had dedicated RTS/CTS hardware
flow control enabled, these characters may have been stuck in the FIFO
due to CTS not being asserted. When the new user opens the port,
.set_termios() is called while transmission is still disabled, leading
to an infinite loop:

    NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s!

This has been observed with SCIFA (on r8a7740/armadillo) and SCIFB (on
r8a7791/koelsch).

The issue does not seem to happen when using:
  - GPIO RTS/CTS hardware flow control,
  - No hardware flow control,
  - HSCIF (on r8a7791/koelsch).

To fix this, wait for the draining of the transmit FIFO only if
transmission is already enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To reproduce:

    stty -echo < /dev/scifb0
    stty crtscts < /dev/scifb0
    echo hello > /dev/scifb0	# returns early (wrote to FIFO)
    echo hello > /dev/scifb0	# hangs

 drivers/tty/serial/sh-sci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c503db1900f003ed..db5de80c5399a7bd 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2137,9 +2137,11 @@ static void sci_reset(struct uart_port *port)
 	const struct plat_sci_reg *reg;
 	unsigned int status;
 
-	do {
-		status = serial_port_in(port, SCxSR);
-	} while (!(status & SCxSR_TEND(port)));
+	if (serial_port_in(port, SCSCR) & SCSCR_TE) {
+		do {
+			status = serial_port_in(port, SCxSR);
+		} while (!(status & SCxSR_TEND(port)));
+	}
 
 	serial_port_out(port, SCSCR, 0x00);	/* TE=0, RE=0, CKE1=0 */
 
-- 
1.9.1
