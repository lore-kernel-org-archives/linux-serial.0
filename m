From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] tty/serial: atmel: increase ATMEL_MAX_UART
Date: Tue, 21 Feb 2017 13:03:56 +0100
Message-ID: <20170221120357.13623-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

The samx7 family uses the same UART/USART IP as the at91/sama5 families but
has 8 of those.

Suggested-by: Szemző András <sza@esh.hu>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index f0d4894267c2..8cc152e67bfb 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -119,8 +119,9 @@ struct atmel_uart_char {
 /*
  * at91: 6 USARTs and one DBGU port (SAM9260)
  * avr32: 4
+ * samx7: 3 USARTs and 5 UARTs
  */
-#define ATMEL_MAX_UART		7
+#define ATMEL_MAX_UART		8
 
 /*
  * We wrap our port structure around the generic uart_port.
-- 
2.11.0
