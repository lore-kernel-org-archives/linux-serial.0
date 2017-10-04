From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH v2] serial: imx: Correct comment imx_flush_buffer()
Date: Wed,  4 Oct 2017 17:13:27 +0100
Message-ID: <1507133607-22966-1-git-send-email-martyn.welch@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Martyn Welch <martyn.welch@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

The comment in imx_flush_buffer() states that the state of 4 registers
are to be saved/restored, then only saves and restores 3 registers. The
missing register (UBRC) is read only and thus can't be restored.

Update the comment to reflect reality.

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---

v2: Remove trailing whitespace.

 drivers/tty/serial/imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b697c1e..76818a2 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1417,10 +1417,14 @@ static void imx_flush_buffer(struct uart_port *port)
 
 	/*
 	 * According to the Reference Manual description of the UART SRST bit:
+	 *
 	 * "Reset the transmit and receive state machines,
 	 * all FIFOs and register USR1, USR2, UBIR, UBMR, UBRC, URXD, UTXD
-	 * and UTS[6-3]". As we don't need to restore the old values from
-	 * USR1, USR2, URXD, UTXD, only save/restore the other four registers
+	 * and UTS[6-3]".
+	 *
+	 * We don't need to restore the old values from USR1, USR2, URXD and
+	 * UTXD. UBRC is read only, so only save/restore the other three
+	 * registers.
 	 */
 	ubir = readl(sport->port.membase + UBIR);
 	ubmr = readl(sport->port.membase + UBMR);
-- 
1.8.3.1
