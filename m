From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Fri, 8 May 2015 09:13:40 +0200
Message-ID: <20150508071340.GA2603@breakpoint.cc>
References: <20150507202439.GA4717@breakpoint.cc>
 <CAOMZO5Dvv2oMujUqtXg0QXZ-VNbwKuRTCOVfcfNYzgWLkHZ1NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dvv2oMujUqtXg0QXZ-VNbwKuRTCOVfcfNYzgWLkHZ1NA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabio Estevam <festevam@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jiwang <jiada_wang@mentor.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton_bondarenko@mentor.com, Dirk Behme <dirk.behme@de.bosch.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-serial@vger.kernel.org

=46rom: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This basically reverts commit 068500e08dc8 ("serial: imx: initialized
DMA w/o HW flow enabled") simply because it does not work.
I tested it on various IMX6 boards and the default SDMA firmware, that =
is
included in ROM, does not work properly. The SDMA interrupt counter doe=
s
not stop increment (which means the SDMA does not stop working) and I s=
ee
a lot of 0x00 (sometimes other bytes) which are added to the tty buffer
which are not part of the data transfer.
Jiada claimed that there is a firmware which makes it work but failed t=
o
provide me a link to the firmware. All he said was that it can not be
shipped as part of the kernel due to license issues. I've found one
firmware in the FSL-tree but this firmware causes only TTY-overflows an=
d
*no* data is transmitted.

Currently I see no other way out.

=46ixes: 068500e08dc8 ("serial: imx: initialized DMA w/o HW flow enable=
d")
Cc: stable@vger.kernel.org
Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jiada Wang <jiada_wang@mentor.com>
Cc: nicolae.rosia@gmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: wording

 drivers/tty/serial/imx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8aff0b4d8ddf..e686c75fa4dc 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1113,11 +1113,6 @@ static int imx_startup(struct uart_port *port)
=20
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
=20
-	/* Can we enable the DMA support? */
-	if (is_imx6q_uart(sport) && !uart_console(port) &&
-	    !sport->dma_is_inited)
-		imx_uart_dma_init(sport);
-
 	spin_lock_irqsave(&sport->port.lock, flags);
 	/* Reset fifo's and state machines */
 	i =3D 100;
@@ -1308,6 +1303,17 @@ imx_set_termios(struct uart_port *port, struct k=
termios *termios,
 			} else {
 				ucr2 |=3D UCR2_CTSC;
 			}
+
+			/*
+			 * Can we enable the DMA support? Be aware that
+			 * at least IMX6 needs to load external SDMA firmware in
+			 * order work properly. The in-ROM firmware is not
+			 * wokring properly.
+			 */
+			if ((ucr2 & UCR2_CTSC) && is_imx6q_uart(sport) &&
+			    !uart_console(port) && !sport->dma_is_inited)
+				imx_uart_dma_init(sport);
+
 		} else {
 			termios->c_cflag &=3D ~CRTSCTS;
 		}
@@ -1424,6 +1430,8 @@ imx_set_termios(struct uart_port *port, struct kt=
ermios *termios,
 	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
 		imx_enable_ms(&sport->port);
=20
+	if (sport->dma_is_inited && !sport->dma_is_enabled)
+		imx_enable_dma(sport);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
=20
--=20
2.1.4
