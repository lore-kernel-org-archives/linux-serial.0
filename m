From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 4/5] serial: sprd: Change 'int' to 'unsigned int'
Date: Mon, 17 Sep 2018 11:33:43 -0700
Message-ID: <7167a2917e6469e7d7a04fa4558f3486b8294722.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, broonie@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The register offset value should be 'unsigned int' type.

Moreover, prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
Changes from v1:
 - Add acked tag from Chunyan.
---
 drivers/tty/serial/sprd_serial.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 03b0cd4..8d5c9cd 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -109,12 +109,14 @@ struct sprd_uart_port {
 static struct sprd_uart_port *sprd_port[UART_NR_MAX];
 static int sprd_ports_num;
 
-static inline unsigned int serial_in(struct uart_port *port, int offset)
+static inline unsigned int serial_in(struct uart_port *port,
+				     unsigned int offset)
 {
 	return readl_relaxed(port->membase + offset);
 }
 
-static inline void serial_out(struct uart_port *port, int offset, int value)
+static inline void serial_out(struct uart_port *port, unsigned int offset,
+			      int value)
 {
 	writel_relaxed(value, port->membase + offset);
 }
@@ -598,8 +600,7 @@ static void sprd_putc(struct uart_port *port, int c)
 	writeb(c, port->membase + SPRD_TXD);
 }
 
-static void sprd_early_write(struct console *con, const char *s,
-				    unsigned n)
+static void sprd_early_write(struct console *con, const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
-- 
1.9.1
