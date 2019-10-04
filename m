From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 05/10] serial: stm32: Use of_device_get_match_data()
Date: Fri,  4 Oct 2019 14:43:29 -0700
Message-ID: <20191004214334.149976-6-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This driver casts away the constness of struct stm32_usart_info that is
pointed to by the of match table. Use of_device_get_match_data() instead
of of_match_device() here and push the const throughout the code so that
we don't cast away const. This nicely avoids referencing the match table
when it is undefined with configurations where CONFIG_OF=n and fixes the
const issues.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-serial@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 drivers/tty/serial/stm32-usart.c | 71 +++++++++++++++-----------------
 drivers/tty/serial/stm32-usart.h |  2 +-
 2 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index df90747ee3a8..b837aa6e89a4 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -102,8 +102,8 @@ static int stm32_config_rs485(struct uart_port *port,
 			      struct serial_rs485 *rs485conf)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 usartdiv, baud, cr1, cr3;
 	bool over8;
 
@@ -171,7 +171,7 @@ static int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
 			    bool threaded)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	enum dma_status status;
 	struct dma_tx_state state;
 
@@ -196,7 +196,7 @@ static unsigned long stm32_get_char(struct uart_port *port, u32 *sr,
 				    int *last_res)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long c;
 
 	if (stm32_port->rx_ch) {
@@ -216,7 +216,7 @@ static void stm32_receive_chars(struct uart_port *port, bool threaded)
 {
 	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long c;
 	u32 sr;
 	char flag;
@@ -287,7 +287,7 @@ static void stm32_tx_dma_complete(void *arg)
 {
 	struct uart_port *port = arg;
 	struct stm32_port *stm32port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 
 	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 	stm32port->tx_dma_busy = false;
@@ -299,7 +299,7 @@ static void stm32_tx_dma_complete(void *arg)
 static void stm32_tx_interrupt_enable(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	/*
 	 * Enables TX FIFO threashold irq when FIFO is enabled,
@@ -314,7 +314,7 @@ static void stm32_tx_interrupt_enable(struct uart_port *port)
 static void stm32_tx_interrupt_disable(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	if (stm32_port->fifoen)
 		stm32_clr_bits(port, ofs->cr3, USART_CR3_TXFTIE);
@@ -325,7 +325,7 @@ static void stm32_tx_interrupt_disable(struct uart_port *port)
 static void stm32_transmit_chars_pio(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (stm32_port->tx_dma_busy) {
@@ -352,7 +352,7 @@ static void stm32_transmit_chars_pio(struct uart_port *port)
 static void stm32_transmit_chars_dma(struct uart_port *port)
 {
 	struct stm32_port *stm32port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_async_tx_descriptor *desc = NULL;
 	dma_cookie_t cookie;
@@ -413,7 +413,7 @@ static void stm32_transmit_chars_dma(struct uart_port *port)
 static void stm32_transmit_chars(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (port->x_char) {
@@ -453,7 +453,7 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 
 	spin_lock(&port->lock);
@@ -500,7 +500,7 @@ static irqreturn_t stm32_threaded_interrupt(int irq, void *ptr)
 static unsigned int stm32_tx_empty(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	return readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE;
 }
@@ -508,7 +508,7 @@ static unsigned int stm32_tx_empty(struct uart_port *port)
 static void stm32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
 		stm32_set_bits(port, ofs->cr3, USART_CR3_RTSE);
@@ -543,7 +543,7 @@ static void stm32_start_tx(struct uart_port *port)
 static void stm32_throttle(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -558,7 +558,7 @@ static void stm32_throttle(struct uart_port *port)
 static void stm32_unthrottle(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -573,7 +573,7 @@ static void stm32_unthrottle(struct uart_port *port)
 static void stm32_stop_rx(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	stm32_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
 	if (stm32_port->cr3_irq)
@@ -589,7 +589,7 @@ static void stm32_break_ctl(struct uart_port *port, int break_state)
 static int stm32_startup(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	const char *name = to_platform_device(port->dev)->name;
 	u32 val;
 	int ret;
@@ -625,8 +625,8 @@ static int stm32_startup(struct uart_port *port)
 static void stm32_shutdown(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 val, isr;
 	int ret;
 
@@ -682,8 +682,8 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	struct serial_rs485 *rs485conf = &port->rs485;
 	unsigned int baud, bits;
 	u32 usartdiv, mantissa, fraction, oversampling;
@@ -876,8 +876,8 @@ static void stm32_pm(struct uart_port *port, unsigned int state,
 {
 	struct stm32_port *stm32port = container_of(port,
 			struct stm32_port, port);
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32port->info->cfg;
 	unsigned long flags = 0;
 
 	switch (state) {
@@ -1010,7 +1010,7 @@ MODULE_DEVICE_TABLE(of, stm32_match);
 static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 				 struct platform_device *pdev)
 {
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	struct uart_port *port = &stm32port->port;
 	struct device *dev = &pdev->dev;
 	struct dma_slave_config config;
@@ -1082,7 +1082,7 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 static int stm32_of_dma_tx_probe(struct stm32_port *stm32port,
 				 struct platform_device *pdev)
 {
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	struct uart_port *port = &stm32port->port;
 	struct device *dev = &pdev->dev;
 	struct dma_slave_config config;
@@ -1132,7 +1132,6 @@ static int stm32_of_dma_tx_probe(struct stm32_port *stm32port,
 
 static int stm32_serial_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct stm32_port *stm32port;
 	int ret;
 
@@ -1140,10 +1139,8 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	if (!stm32port)
 		return -ENODEV;
 
-	match = of_match_device(stm32_match, &pdev->dev);
-	if (match && match->data)
-		stm32port->info = (struct stm32_usart_info *)match->data;
-	else
+	stm32port->info = of_device_get_match_data(&pdev->dev);
+	if (!stm32port->info)
 		return -EINVAL;
 
 	ret = stm32_init_port(stm32port, pdev);
@@ -1202,7 +1199,7 @@ static int stm32_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	int err;
 
 	pm_runtime_get_sync(&pdev->dev);
@@ -1247,7 +1244,7 @@ static int stm32_serial_remove(struct platform_device *pdev)
 static void stm32_console_putchar(struct uart_port *port, int ch)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	while (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
 		cpu_relax();
@@ -1259,8 +1256,8 @@ static void stm32_console_write(struct console *co, const char *s, unsigned cnt)
 {
 	struct uart_port *port = &stm32_ports[co->index].port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	unsigned long flags;
 	u32 old_cr1, new_cr1;
 	int locked = 1;
@@ -1346,8 +1343,8 @@ static void __maybe_unused stm32_serial_enable_wakeup(struct uart_port *port,
 						      bool enable)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 val;
 
 	if (stm32_port->wakeirq <= 0)
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index a175c1094dc8..2aa4d1149d97 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -259,7 +259,7 @@ struct stm32_usart_info stm32h7_info = {
 struct stm32_port {
 	struct uart_port port;
 	struct clk *clk;
-	struct stm32_usart_info *info;
+	const struct stm32_usart_info *info;
 	struct dma_chan *rx_ch;  /* dma rx channel            */
 	dma_addr_t rx_dma_buf;   /* dma rx buffer bus address */
 	unsigned char *rx_buf;   /* dma rx buffer cpu address */
-- 
Sent by a computer through tubes
