From: Su Kang Yin <cantona@cantona.net>
Subject: [PATCH] serial: max310x: Fix out of bounds access
Date: Wed, 12 Aug 2015 13:33:52 +0800
Message-ID: <1439357632-14745-1-git-send-email-cantona@cantona.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Su Kang Yin <cantona@cantona.net>
List-Id: linux-serial@vger.kernel.org

Max310x driver supports up to 4 UART devices but array size of
"struct max310x_one" is set to 1. That leads to out of bounds
access on UART port registration.

This patch fixed it by increase the array size to 4 which is
maximum supported UART.
---
 drivers/tty/serial/max310x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 182549f..b523552 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -33,6 +33,9 @@
 #define MAX310X_MAJOR			204
 #define MAX310X_MINOR			209
 
+/* Maximum supported device */
+#define MAX_DEVICE			4
+
 /* MAX310X register definitions */
 #define MAX310X_RHR_REG			(0x00) /* RX FIFO */
 #define MAX310X_THR_REG			(0x00) /* TX FIFO */
@@ -273,7 +276,7 @@ struct max310x_port {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gpio;
 #endif
-	struct max310x_one	p[0];
+	struct max310x_one	p[MAX_DEVICE];
 };
 
 static u8 max310x_port_read(struct uart_port *port, u8 reg)
-- 
1.9.1
