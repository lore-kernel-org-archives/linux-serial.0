From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/3] serial: diminish usage of struct serial_uart_config
Date: Mon, 20 Aug 2012 19:56:28 -0400
Message-ID: <1345506988-15390-4-git-send-email-paul.gortmaker@windriver.com>
References: <1345506988-15390-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:57547 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2HTX7n (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 19:59:43 -0400
In-Reply-To: <1345506988-15390-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>

This structure might have made sense many years ago, but at this
point it is only used in one specific driver, and referenced in
stale comments elsewhere.  Rather than change the sunsu.c driver,
simply move the struct to be within the exclusive domain of that
driver, so it won't get inadvertently picked up and used by other
serial drivers going forward.  The comments referencing the now
driver specific struct are updated accordingly.

Note that 8250.c has a struct that is similar in usage, with the
name serial8250_config; but is 100% independent and untouched here.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/staging/speakup/serialio.h | 3 +--
 drivers/tty/serial/8250/8250.h     | 3 ---
 drivers/tty/serial/sunsu.c         | 6 ++++++
 include/linux/serial.h             | 6 ------
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/speakup/serialio.h b/drivers/staging/speakup/serialio.h
index 614271f..55d68b5 100644
--- a/drivers/staging/speakup/serialio.h
+++ b/drivers/staging/speakup/serialio.h
@@ -1,8 +1,7 @@
 #ifndef _SPEAKUP_SERIAL_H
 #define _SPEAKUP_SERIAL_H
 
-#include <linux/serial.h>	/* for rs_table, serial constants &
-				   serial_uart_config */
+#include <linux/serial.h>	/* for rs_table, serial constants */
 #include <linux/serial_reg.h>	/* for more serial constants */
 #ifndef __sparc__
 #include <asm/serial.h>
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 972b521..0c5e908 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -26,9 +26,6 @@ struct old_serial_port {
 	unsigned long irqflags;
 };
 
-/*
- * This replaces serial_uart_config in include/linux/serial.h
- */
 struct serial8250_config {
 	const char	*name;
 	unsigned short	fifo_size;
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index d919095..b97913d 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -58,6 +58,12 @@
 enum su_type { SU_PORT_NONE, SU_PORT_MS, SU_PORT_KBD, SU_PORT_PORT };
 static char *su_typev[] = { "su(???)", "su(mouse)", "su(kbd)", "su(serial)" };
 
+struct serial_uart_config {
+	char	*name;
+	int	dfl_xmit_fifo_size;
+	int	flags;
+};
+
 /*
  * Here we define the default xmit fifo size used for each type of UART.
  */
diff --git a/include/linux/serial.h b/include/linux/serial.h
index 90e9f98..11f365c 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -83,12 +83,6 @@ struct serial_struct {
 #define SERIAL_IO_HUB6	1
 #define SERIAL_IO_MEM	2
 
-struct serial_uart_config {
-	char	*name;
-	int	dfl_xmit_fifo_size;
-	int	flags;
-};
-
 #define UART_CLEAR_FIFO		0x01
 #define UART_USE_FIFO		0x02
 #define UART_STARTECH		0x04
-- 
1.7.11.1

