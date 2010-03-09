From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/13] serial: bfin_sport_uart: drop
	useless status masks
Date: Tue,  9 Mar 2010 12:25:36 -0500
Message-ID: <1268155540-8241-10-git-send-email-vapier@gentoo.org>
References: <1268155540-8241-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1268155540-8241-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

These were all copied over from the Blackfin UART driver, but they don't
make sense here because these bits are all specific to the Blackfin UART.

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/serial/bfin_sport_uart.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/drivers/serial/bfin_sport_uart.c b/drivers/serial/bfin_sport_uart.c
index 871f6fd..1b22c59 100644
--- a/drivers/serial/bfin_sport_uart.c
+++ b/drivers/serial/bfin_sport_uart.c
@@ -499,27 +499,12 @@ static void sport_set_termios(struct uart_port *port,
 
 	spin_lock_irqsave(&up->port.lock, flags);
 
-	port->read_status_mask = OE;
-	if (termios->c_iflag & INPCK)
-		port->read_status_mask |= (FE | PE);
-	if (termios->c_iflag & (BRKINT | PARMRK))
-		port->read_status_mask |= BI;
+	port->read_status_mask = 0;
 
 	/*
 	 * Characters to ignore
 	 */
 	port->ignore_status_mask = 0;
-	if (termios->c_iflag & IGNPAR)
-		port->ignore_status_mask |= FE | PE;
-	if (termios->c_iflag & IGNBRK) {
-		port->ignore_status_mask |= BI;
-		/*
-		 * If we're ignoring parity and break indicators,
-		 * ignore overruns too (for real raw support).
-		 */
-		if (termios->c_iflag & IGNPAR)
-			port->ignore_status_mask |= OE;
-	}
 
 	/* RX extract mask */
 	up->rxmask = 0x01 | (((up->csize + up->stopb) * 2 - 1) << 0x8);
-- 
1.7.0.2
