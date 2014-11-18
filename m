From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] serial: tegra: clean up tty-flag assignments
Date: Tue, 18 Nov 2014 11:18:02 +0100
Message-ID: <1416305882-8713-1-git-send-email-johan@kernel.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The tty break and error flags are not bit masks so do not to use bitwise
OR when assigning them.

Note that there is no functional change due to the if-else construct and
flag having been initialised to zero (TTY_NORMAL).

Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 53d7c31ce098..0b615d8b968a 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -319,16 +319,16 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
 	if (unlikely(lsr & TEGRA_UART_LSR_ANY)) {
 		if (lsr & UART_LSR_OE) {
 			/* Overrrun error */
-			flag |= TTY_OVERRUN;
+			flag = TTY_OVERRUN;
 			tup->uport.icount.overrun++;
 			dev_err(tup->uport.dev, "Got overrun errors\n");
 		} else if (lsr & UART_LSR_PE) {
 			/* Parity error */
-			flag |= TTY_PARITY;
+			flag = TTY_PARITY;
 			tup->uport.icount.parity++;
 			dev_err(tup->uport.dev, "Got Parity errors\n");
 		} else if (lsr & UART_LSR_FE) {
-			flag |= TTY_FRAME;
+			flag = TTY_FRAME;
 			tup->uport.icount.frame++;
 			dev_err(tup->uport.dev, "Got frame errors\n");
 		} else if (lsr & UART_LSR_BI) {
-- 
2.0.4
