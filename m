From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] tty/serial: atmel: remove cache when unnecessary
Date: Tue, 21 Feb 2017 13:03:57 +0100
Message-ID: <20170221120357.13623-2-alexandre.belloni@free-electrons.com>
References: <20170221120357.13623-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170221120357.13623-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

struct cache is only used in suspend/resume. Exclude it when PM is not
selected.

Suggested-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index dcebb28ffbc4..f0d4894267c2 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -175,6 +175,7 @@ struct atmel_uart_port {
 	unsigned int		pending_status;
 	spinlock_t		lock_suspended;
 
+#ifdef CONFIG_PM
 	struct {
 		u32		cr;
 		u32		mr;
@@ -185,6 +186,7 @@ struct atmel_uart_port {
 		u32		fmr;
 		u32		fimr;
 	} cache;
+#endif
 
 	int (*prepare_rx)(struct uart_port *port);
 	int (*prepare_tx)(struct uart_port *port);
-- 
2.11.0
