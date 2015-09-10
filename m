From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] tty/serial: at91: move ATMEL_MAX_UART
Date: Thu, 10 Sep 2015 11:29:03 +0200
Message-ID: <1441877343-20248-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

Move ATMEL_MAX_UART from platform_data/atmel.h to atmel_serial.c as this is
the only file using it and it is common practise from tty/serial drivers to
define it directly in the driver file.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c   | 6 ++++++
 include/linux/platform_data/atmel.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5ca5cf3e9359..98c84038518e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -112,6 +112,12 @@ struct atmel_uart_char {
 #define ATMEL_SERIAL_RINGSIZE 1024
 
 /*
+ * at91: 6 USARTs and one DBGU port (SAM9260)
+ * avr32: 4
+ */
+#define ATMEL_MAX_UART		7
+
+/*
  * We wrap our port structure around the generic uart_port.
  */
 struct atmel_uart_port {
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 527a85c61924..c4bc90bfebe0 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -19,12 +19,6 @@
 #include <linux/serial.h>
 #include <linux/platform_data/macb.h>
 
-/*
- * at91: 6 USARTs and one DBGU port (SAM9260)
- * avr32: 4
- */
-#define ATMEL_MAX_UART	7
-
  /* USB Device */
 struct at91_udc_data {
 	int	vbus_pin;		/* high == host powering us */
-- 
2.1.4
