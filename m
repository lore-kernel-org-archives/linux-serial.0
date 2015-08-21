From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 06/33] serial: sh-sci: Drop path in reference to serial_core.c
Date: Fri, 21 Aug 2015 20:02:30 +0200
Message-ID: <1440180177-6924-7-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

serial_core.c was moved from drivers/serial/ to drivers/tty/serial/ a
while ago. Remove the path to make it move-proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 206673f44a2943af..dbb4bbdac37ce0d8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2014,7 +2014,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	/*
 	 * Calculate delay for 2 DMA buffers (4 FIFO).
-	 * See drivers/serial/serial_core.c::uart_update_timeout(). With 10
+	 * See serial_core.c::uart_update_timeout(). With 10
 	 * bits (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above function
 	 * calculates 1 jiffie for the data plus 5 jiffies for the "slop(e)."
 	 * Then below we calculate 5 jiffies (20ms) for 2 DMA buffers (4 FIFO
-- 
1.9.1

