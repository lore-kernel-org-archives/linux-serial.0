From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [RESEND PATCH 3/4] tty/serial: atmel: add comment for the ring buffer size macro
Date: Fri, 17 Jun 2016 12:05:48 +0200
Message-ID: <ef01731cec3eb55e7f0d662ca249eda9c5bc633b.1466157015.git.nicolas.ferre@atmel.com>
References: <cover.1466157015.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466157015.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

There is a macro named ATMEL_SERIAL_RINGSIZE which suggesting that it
corresponds to the real size of the ring buffer. Let warn people that
there is a factor of four since allocation size is
sizeof(struct atmel_uart_char) * ATMEL_SERIAL_RINGSIZE.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 6c1ec7d0d497..857016367a7a 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -108,6 +108,12 @@ struct atmel_uart_char {
 	u16		ch;
 };
 
+/*
+ * Be careful, the real size of the ring buffer is
+ * sizeof(atmel_uart_char) * ATMEL_SERIAL_RINGSIZE. It means that ring buffer
+ * can contain up to 1024 characters in PIO mode and up to 4096 characters in
+ * DMA mode.
+ */
 #define ATMEL_SERIAL_RINGSIZE 1024
 
 /*
-- 
2.9.0
