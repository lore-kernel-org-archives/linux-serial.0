From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/4] serial: sh-sci: Stop transfers in sci_shutdown()
Date: Fri, 24 Jun 2016 16:59:14 +0200
Message-ID: <1466780356-12623-3-git-send-email-geert+renesas@glider.be>
References: <1466780356-12623-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1466780356-12623-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <damm+renesas@opensource.se>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Geert Uytterhoeven <geert+renesas@glider.be>
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
v2:
  - Do not clear clock source bits, since the serial console relies on
    them, as reported by Shimoda-san.

v1 was extracted from "[PATCH/RFC v3 0/4] serial: sh-sci: Add DT DMA
support".  The issues with the serial console seen before on
r8a7740/armadillo and sh73a0/kzm9g seem to be gone.  Changes after
resurrection:
  - Write zero to also disable related interrupts, as suggested by
    Laurent Pinchart,
  - Enhanced patch description.
---
 drivers/tty/serial/sh-sci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d6ba90c572f7475c..eecace576c3b758f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1890,12 +1890,17 @@ static void sci_shutdown(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
 	unsigned long flags;
+	u16 scr;
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
 	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
 	sci_stop_tx(port);
+	/* Stop RX and TX, disable related interrupts, keep clock source */
+	scr = serial_port_in(port, SCSCR);
+	serial_port_out(port, SCSCR, scr & (SCSCR_CKE1 | SCSCR_CKE0));
+
 	spin_unlock_irqrestore(&port->lock, flags);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-- 
1.9.1

