From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH] serial: stm32: mark symbols static where possible
Date: Mon, 26 Sep 2016 19:58:56 +0800
Message-ID: <1474891136-16602-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, han.fei@zte.com.cn, tang.qiang007@zte.com.cn
List-Id: linux-serial@vger.kernel.org

We get 2 warnings when building kernel with W=1:
drivers/tty/serial/stm32-usart.c:63:5: warning: no previous prototype for 'stm32_pending_rx' [-Wmissing-prototypes]
drivers/tty/serial/stm32-usart.c:88:15: warning: no previous prototype for 'stm32_get_char' [-Wmissing-prototypes]

In fact, these two functions are only used in the file in which they are
declared and don't need a declaration, but can be made static.

So this patch marks these functions with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/tty/serial/stm32-usart.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4d3001b..bb9b5e9 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -60,8 +60,8 @@ static void stm32_clr_bits(struct uart_port *port, u32 reg, u32 bits)
 	writel_relaxed(val, port->membase + reg);
 }
 
-int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
-		     bool threaded)
+static int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
+			    bool threaded)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
@@ -85,7 +85,8 @@ int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
 	return 0;
 }
 
-unsigned long stm32_get_char(struct uart_port *port, u32 *sr, int *last_res)
+static unsigned long
+stm32_get_char(struct uart_port *port, u32 *sr, int *last_res)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-- 
2.7.4
