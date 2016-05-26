From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] serial: sh-sci: Stop transfers in sci_shutdown()
Date: Thu, 26 May 2016 20:18:36 +0200
Message-ID: <1464286718-10745-3-git-send-email-geert+renesas@glider.be>
References: <1464286718-10745-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1464286718-10745-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Make sure the transmitter and receiver are stopped when shutting down
the port, and related interrupts are disabled.

Without this:
  - New input data may be received into the RX FIFO, possibly
    triggering a new RX DMA completion,
  - Transfers will still be enabled on a subsequent startup of the UART,
    before the UART's FIFOs have been reset, causing reading of stale
    data.

Inspired by a patch in the BSP by Koji Matsuoka
<koji.matsuoka.xm@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Extracted from "[PATCH/RFC v3 0/4] serial: sh-sci: Add DT DMA support".
The issues with the serial console seen before on r8a7740/armadillo and
sh73a0/kzm9g seem to be gone.

Changes after resurrection:
  - Write zero to also disable related interrupts, as suggested by
    Laurent Pinchart,
  - Enhanced patch description.
---
 drivers/tty/serial/sh-sci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d6ba90c572f7475c..4d2f916f45277e20 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1896,6 +1896,8 @@ static void sci_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
 	sci_stop_tx(port);
+	/* Stop RX and TX, disable related interrupts */
+	serial_port_out(port, SCSCR, 0);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-- 
1.9.1
