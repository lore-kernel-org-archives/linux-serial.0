From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH V2] serial: efm32: Fix parity management in 'efm32_uart_console_get_options()'
Date: Fri, 12 May 2017 16:35:45 +0200
Message-ID: <20170512143545.15394-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, kernel@pengutronix.de
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-serial@vger.kernel.org

UARTn_FRAME_PARITY_ODD is 0x0300
UARTn_FRAME_PARITY_EVEN is 0x0200
So if the UART is configured for EVEN parity, it would be reported as ODD.
Fix it by correctly testing if the 2 bits are set.

Fixes: 3afbd89c9639 ("serial/efm32: add new driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Add UARTn_FRAME_PARITY__MASK
    Test the 2 parity bits in the EVEN case

v1 and related comment are quite old and can be found at:
   http://marc.info/?t=148676095800005&r=1&w=4
I also added a __MASK to the proposed constant name to be consistent with
UARTn_FRAME_DATABITS__MASK
---
 drivers/tty/serial/efm32-uart.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index ebd8569f9ad5..9fff25be87f9 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -27,6 +27,7 @@
 #define UARTn_FRAME		0x04
 #define UARTn_FRAME_DATABITS__MASK	0x000f
 #define UARTn_FRAME_DATABITS(n)		((n) - 3)
+#define UARTn_FRAME_PARITY__MASK	0x0300
 #define UARTn_FRAME_PARITY_NONE		0x0000
 #define UARTn_FRAME_PARITY_EVEN		0x0200
 #define UARTn_FRAME_PARITY_ODD		0x0300
@@ -572,12 +573,16 @@ static void efm32_uart_console_get_options(struct efm32_uart_port *efm_port,
 			16 * (4 + (clkdiv >> 6)));
 
 	frame = efm32_uart_read32(efm_port, UARTn_FRAME);
-	if (frame & UARTn_FRAME_PARITY_ODD)
+	switch (frame & UARTn_FRAME_PARITY__MASK) {
+	case UARTn_FRAME_PARITY_ODD:
 		*parity = 'o';
-	else if (frame & UARTn_FRAME_PARITY_EVEN)
+		break;
+	case UARTn_FRAME_PARITY_EVEN:
 		*parity = 'e';
-	else
+		break;
+	default:
 		*parity = 'n';
+	}
 
 	*bits = (frame & UARTn_FRAME_DATABITS__MASK) -
 			UARTn_FRAME_DATABITS(4) + 4;
-- 
2.11.0
