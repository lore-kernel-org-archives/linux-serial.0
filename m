From: V10lator <v10lator@myway.de>
Subject: [PATCH v3] tty: serial: meson: allow baud-rates lower than 9600
Date: Sat, 04 Nov 2017 14:00:00 +0100
Message-ID: <19343ad6-75de-4059-825a-98ed40ecf423@myway.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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
---
 drivers/tty/serial/meson_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c 
b/drivers/tty/serial/meson_uart.c
index 07c0f98be3ac..e281ce5d101d 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -362,7 +362,7 @@ static void meson_uart_set_termios(struct uart_port 
*port,
 
 	writel(val, port->membase + AML_UART_CONTROL);
 
-	baud = uart_get_baud_rate(port, termios, old, 9600, 4000000);
+	baud = uart_get_baud_rate(port, termios, old, 50, 4000000);
 	meson_uart_change_speed(port, baud);
 
 	port->read_status_mask = AML_UART_TX_FIFO_WERR;
-- 
2.13.6
