From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 2/4] serial: xuartps: Do not handle overrun errors under IGNPAR option
Date: Mon, 17 Aug 2015 09:22:32 +0200
Message-ID: <41df6eb35d69801afa5b686a6974e3c3bf65178a.1439796149.git.michal.simek@xilinx.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
In-Reply-To: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Anirudha Sarangi <anirudha.sarangi@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>

The existing implementation includes overrun errors under IGNPAR
option. This patch fixes it by including only parity and framing
error under IGNPAR option.

Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a3020344ac9d..c4437e8929ff 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -691,7 +691,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
 
 	if (termios->c_iflag & IGNPAR)
 		port->ignore_status_mask |= CDNS_UART_IXR_PARITY |
-			CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN;
+					    CDNS_UART_IXR_FRAMING;
 
 	/* ignore all characters if CREAD is not set */
 	if ((termios->c_cflag & CREAD) == 0)
-- 
2.3.5
