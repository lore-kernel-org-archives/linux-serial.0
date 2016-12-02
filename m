From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] serial: sh-sci: Fix early deassertion of dedicated RTS
Date: Fri,  2 Dec 2016 13:35:10 +0100
Message-ID: <1480682111-9299-2-git-send-email-geert+renesas@glider.be>
References: <1480682111-9299-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480682111-9299-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

If a UART has dedicated RTS/CTS pins, there are some issues:

1. When changing hardware control flow, the new AUTORTS state is not
   immediately reflected in the hardware, but only when RTS is raised.
   However, the serial core doesn't call .set_mctrl() after
   .set_termios(), hence AUTORTS may only become effective when the port
   is closed, and reopened later.
   Note that this problem does not happen when manually using stty to
   change CRTSCTS, as AUTORTS will work fine on next open.

2. When hardware control flow is disabled (or AUTORTS is not yet
   effective), changing any serial port configuration deasserts RTS, as
   .set_termios() calls sci_init_pins().

To fix both issues, call .set_mctrl() from .set_termios() when dedicated
RTS/CTS pins are present, to refresh the AUTORTS or RTS state.
This is similar to what other drivers supporting AUTORTS do (e.g.
omap-serial).

Reported-by: Baumann, Christoph (C.) <cbaumann@visteon.com> (issue 1)
Fixes: 33f50ffc253854cf ("serial: sh-sci: Fix support for hardware-assisted RTS/CTS")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on r8a7791/koelsch with HSCIF1 (GPIO hardware flow control),
and HSCIF2 and SCIFB0 (dedicated hardware flow control).

A simple test program (basically "cat" with CRTSCTS configuration
capability) can be found at https://github.com/geertu/sercat

Without this patch the following will fail:

  1. sercat -f /dev/hscif2 &
     seq 100 120 | sercat -f -w /dev/hscif1 # hangs

  2. seq 200 220 | sercat -f -w /dev/hscif2 &
     sercat -f /dev/hscif1 # no data received
---
 drivers/tty/serial/sh-sci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 91e7dddbf72cd3de..c503db1900f003ed 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2340,6 +2340,10 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 		serial_port_out(port, SCFCR, ctrl);
 	}
+	if (port->flags & UPF_HARD_FLOW) {
+		/* Refresh (Auto) RTS */
+		sci_set_mctrl(port, port->mctrl);
+	}
 
 	scr_val |= s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0);
 	dev_dbg(port->dev, "SCSCR 0x%x\n", scr_val);
-- 
1.9.1
