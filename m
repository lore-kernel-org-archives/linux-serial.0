From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/3] serial: sh-sci: Fix hang in sci_reset()
Date: Tue, 28 Mar 2017 11:13:44 +0200
Message-ID: <1490692426-19252-2-git-send-email-geert+renesas@glider.be>
References: <1490692426-19252-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1490692426-19252-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

When the .set_termios() callback resets the UART, it first waits (busy
loops) until all characters in the transmit FIFO have been transmitted,
to prevent a port configuration change from impacting these characters.

However, if the UART has dedicated RTS/CTS hardware flow control
enabled, these characters may have been stuck in the FIFO due to CTS not
being asserted by the remote side.

  - When a new user opens the port, .set_termios() is called while
    transmission is still disabled, leading to an infinite loop:

	NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s!

  - When an active user changes port configuration without waiting for
    the draining of the transmit FIFO, this may also block indefinitely,
    until CTS is asserted by the remote side.

This has been observed with SCIFA (on r8a7740/armadillo), and SCIFB and
HSCIF (on r8a7791/koelsch).

To fix this, remove the code that waits for the draining of the transmit
FIFO.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To reproduce:

    stty -echo < /dev/scifb0
    stty crtscts < /dev/scifb0
    echo hello > /dev/scifb0	# returns early (wrote to FIFO)
    echo hello > /dev/scifb0	# hangs

v2:
  - Remove the draining of the transmit FIFO completely, instead of
    skipping it when tranmission was not enabled, as the hang could
    still be reproduced when an active user changes port configuration
    without waiting for the draining of the transmit FIFO.
---
 drivers/tty/serial/sh-sci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1df57461ece4337b..446a23bee14008bb 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2159,10 +2159,6 @@ static void sci_reset(struct uart_port *port)
 	unsigned int status;
 	struct sci_port *s = to_sci_port(port);
 
-	do {
-		status = serial_port_in(port, SCxSR);
-	} while (!(status & SCxSR_TEND(port)));
-
 	serial_port_out(port, SCSCR, 0x00);	/* TE=0, RE=0, CKE1=0 */
 
 	reg = sci_getreg(port, SCFCR);
-- 
2.7.4
