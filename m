From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/2] serial: sirf: fix the amount of serial ports
Date: Sun, 25 Aug 2013 20:18:41 +0800
Message-ID: <1377433121-11411-2-git-send-email-Baohua.Song@csr.com>
References: <1377433121-11411-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:58202 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab3HYMTF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Aug 2013 08:19:05 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so2374023pbb.24
        for <linux-serial@vger.kernel.org>; Sun, 25 Aug 2013 05:19:04 -0700 (PDT)
In-Reply-To: <1377433121-11411-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

SiRFprimaII has three uart ports and three USP-based ports, so there
are totally six lines instead of five.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 7 +++++++
 drivers/tty/serial/sirfsoc_uart.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 37aa0dd..1231afe 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -96,6 +96,13 @@ static struct sirfsoc_uart_port sirfsoc_uart_ports[SIRFSOC_UART_NR] = {
 			.line		= 4,
 		},
 	},
+	[5] = {
+		.port = {
+			.iotype		= UPIO_MEM,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 5,
+		},
+	},
 };
 
 static inline struct sirfsoc_uart_port *to_sirfport(struct uart_port *port)
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index c43333d..fb8d0a0 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -365,7 +365,7 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 #define SIRFSOC_UART_MINOR			0
 #define SIRFUART_PORT_NAME			"sirfsoc-uart"
 #define SIRFUART_MAP_SIZE			0x200
-#define SIRFSOC_UART_NR				5
+#define SIRFSOC_UART_NR				6
 #define SIRFSOC_PORT_TYPE			0xa5
 
 /* Baud Rate Calculation */
-- 
1.8.2.3

