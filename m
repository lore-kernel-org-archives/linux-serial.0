From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/3] serial: sh-sci: Fix late enablement of AUTORTS
Date: Tue, 28 Mar 2017 11:13:45 +0200
Message-ID: <1490692426-19252-3-git-send-email-geert+renesas@glider.be>
References: <1490692426-19252-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1490692426-19252-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

When changing hardware control flow for a UART with dedicated RTS/CTS
pins, the new AUTORTS state is not immediately reflected in the
hardware, but only when RTS is raised.  However, the serial core does
not call .set_mctrl() after .set_termios(), hence AUTORTS may only
become effective when the port is closed, and reopened later.
Note that this problem does not happen when manually using stty to
change CRTSCTS, as AUTORTS will work fine on next open.

To fix this, call .set_mctrl() from .set_termios() when dedicated
RTS/CTS pins are present, to refresh the AUTORTS or RTS state.
This is similar to what other drivers supporting AUTORTS do (e.g.
omap-serial).

Reported-by: Baumann, Christoph (C.) <cbaumann@visteon.com>
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

v2:
  - Remove the paragraph about sci_init_pins() and reword.
    When hardware control flow is disabled, there can still be small
    glitches in the RTS signal.
    These glitches are now addressed in a separate patch.
---
 drivers/tty/serial/sh-sci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 446a23bee14008bb..6e405fb5a23f0b4a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2372,6 +2372,10 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 		serial_port_out(port, SCFCR, ctrl);
 	}
+	if (port->flags & UPF_HARD_FLOW) {
+		/* Refresh (Auto) RTS */
+		sci_set_mctrl(port, port->mctrl);
+	}
 
 	scr_val |= SCSCR_RE | SCSCR_TE |
 		   (s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0));
-- 
2.7.4
