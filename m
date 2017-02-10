From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] serial: efm32: Fix parity management in 'efm32_uart_console_get_options()'
Date: Fri, 10 Feb 2017 22:06:40 +0100
Message-ID: <20170210210640.17749-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, kernel@pengutronix.de
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-serial@vger.kernel.org

UARTn_FRAME_PARITY_ODD is 0x0300
UARTn_FRAME_PARITY_EVEN is 0x0200
So if the UART is configured for EVEN parity, it would be reported as ODD.
Fix it by testing if the 2 bits are set in the ODD case.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Un-tested
---
 drivers/tty/serial/efm32-uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index ebd8569f9ad5..84034ef20c88 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -572,9 +572,9 @@ static void efm32_uart_console_get_options(struct efm32_uart_port *efm_port,
 			16 * (4 + (clkdiv >> 6)));
 
 	frame = efm32_uart_read32(efm_port, UARTn_FRAME);
-	if (frame & UARTn_FRAME_PARITY_ODD)
+	if ((frame & UARTn_FRAME_PARITY_ODD) == UARTn_FRAME_PARITY_ODD)
 		*parity = 'o';
-	else if (frame & UARTn_FRAME_PARITY_EVEN)
+	else if ((frame & UARTn_FRAME_PARITY_EVEN) == UARTn_FRAME_PARITY_EVEN)
 		*parity = 'e';
 	else
 		*parity = 'n';
-- 
2.9.3
