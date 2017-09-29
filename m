From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH] serial: imx: Correct comment imx_flush_buffer()
Date: Fri, 29 Sep 2017 10:22:19 +0100
Message-ID: <1506676939-20940-1-git-send-email-martyn.welch@collabora.co.uk>
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
 drivers/tty/serial/imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 474b5bc..63f544e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1415,10 +1415,14 @@ static void imx_flush_buffer(struct uart_port *port)
 
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
