From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 14/33] serial: sh-sci: Improve comments for DMA timeout calculation
Date: Fri, 21 Aug 2015 20:02:38 +0200
Message-ID: <1440180177-6924-15-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Reformat, grammar improvements, use "ms" instead of "msec".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 340700a11b152952..cfef543df25271f5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2015,13 +2015,13 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	/*
 	 * Calculate delay for 2 DMA buffers (4 FIFO).
-	 * See serial_core.c::uart_update_timeout(). With 10
-	 * bits (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above function
-	 * calculates 1 jiffie for the data plus 5 jiffies for the "slop(e)."
-	 * Then below we calculate 5 jiffies (20ms) for 2 DMA buffers (4 FIFO
-	 * sizes), but when performing a faster transfer, value obtained by
-	 * this formula is may not enough. Therefore, if value is smaller than
-	 * 20msec, this sets 20msec as timeout of DMA.
+	 * See serial_core.c::uart_update_timeout().
+	 * With 10 bits (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above
+	 * function calculates 1 jiffie for the data plus 5 jiffies for the
+	 * "slop(e)." Then below we calculate 5 jiffies (20ms) for 2 DMA
+	 * buffers (4 FIFO sizes), but when performing a faster transfer, the
+	 * value obtained by this formula is too small. Therefore, if the value
+	 * is smaller than 20ms, use 20ms as the timeout value for DMA.
 	 */
 	if (s->chan_rx) {
 		unsigned int bits;
-- 
1.9.1

