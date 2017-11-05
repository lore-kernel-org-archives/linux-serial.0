From: Thomas Rohloff <v10lator@myway.de>
Subject: [PATCH] tty: serial: meson: allow baud-rates lower than 9600
Date: Sun,  5 Nov 2017 20:35:14 +0100
Message-ID: <20171105193514.7833-1-v10lator@myway.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Devices like DCF77 receivers need the baud-rate to be as low as 50.

I have tested this on a Meson GXL device with uart_A.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Rohloff <v10lator@myway.de>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 07c0f98be3ac..e281ce5d101d 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -362,7 +362,7 @@ static void meson_uart_set_termios(struct uart_port *port,
 
 	writel(val, port->membase + AML_UART_CONTROL);
 
-	baud = uart_get_baud_rate(port, termios, old, 9600, 4000000);
+	baud = uart_get_baud_rate(port, termios, old, 50, 4000000);
 	meson_uart_change_speed(port, baud);
 
 	port->read_status_mask = AML_UART_TX_FIFO_WERR;
-- 
2.13.6
