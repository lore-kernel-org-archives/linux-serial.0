Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C14C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB47611B0
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbhESJ1N (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 05:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237574AbhESJ1N (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 05:27:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07B13611B0;
        Wed, 19 May 2021 09:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416354;
        bh=wh6q/SQB8NakSbz3YHzPKZ6wKHu9TYBpRuDWq6Zwi6g=;
        h=From:To:Cc:Subject:Date:From;
        b=a9i6UMeVKvZfO1Ynf9jEZkt37EO6mRrAZCd/pH0JWvNxS1+TlbHFr2SwQqq/orn7L
         2SQEYFDj4Tz/I4NmvBadQOLHmKS0Ex8GMHfG0+L+xPQkj1yCTWw8EOa9uyrgSywDV0
         zcHwJkNk2fh62lmAOpIT65EWWcCfQjQGJ+MSAwU9C3qXmdJF6ptJPZamMa9sG00cMs
         +CmFPwXXsT8q8mvmF1AihBaBVLKEMCzXbmGBH7sYCpvmAfV9MpbJr3B/6Fw/7fAwcE
         SdEfXArKdNDIGp6QWggmQ3oMUJ7nRdCK+k3OsezKGFZo3nlY5v2frsoDc+VxReXZ4r
         t/9hPVQU36jBw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljISf-0002eE-FR; Wed, 19 May 2021 11:25:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] serial: drop irq-flags initialisations
Date:   Wed, 19 May 2021 11:25:41 +0200
Message-Id: <20210519092541.10137-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There's no need to initialise irq-flags variables before saving the
interrupt state.

Drop the redundant initialisations from drivers that got this wrong.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/amba-pl011.c    |  2 +-
 drivers/tty/serial/imx.c           |  2 +-
 drivers/tty/serial/omap-serial.c   | 10 +++++-----
 drivers/tty/serial/serial_core.c   |  4 ++--
 drivers/tty/serial/st-asc.c        |  2 +-
 drivers/tty/serial/stm32-usart.c   |  2 +-
 drivers/tty/serial/xilinx_uartps.c |  8 ++++----
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 78682c12156a..e14f3378b8a0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1062,7 +1062,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	struct tty_port *port = &uap->port.state->port;
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = uap->dmarx.chan;
-	unsigned long flags = 0;
+	unsigned long flags;
 	unsigned int dmataken = 0;
 	unsigned int size = 0;
 	struct pl011_sgbuf *sgbuf;
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7d5a8dfa3e91..4b838601cdce 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1975,8 +1975,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct imx_port *sport = imx_uart_ports[co->index];
 	struct imx_port_ucrs old_ucr;
+	unsigned long flags;
 	unsigned int ucr1;
-	unsigned long flags = 0;
 	int locked = 1;
 
 	if (sport->port.sysrq)
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 84e8158088cd..9e81b09ba08e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -626,7 +626,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 static unsigned int serial_omap_tx_empty(struct uart_port *port)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 	unsigned int ret = 0;
 
 	pm_runtime_get_sync(up->dev);
@@ -704,7 +704,7 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->port.line);
 	pm_runtime_get_sync(up->dev);
@@ -722,7 +722,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 static int serial_omap_startup(struct uart_port *port)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 	int retval;
 
 	/*
@@ -797,7 +797,7 @@ static int serial_omap_startup(struct uart_port *port)
 static void serial_omap_shutdown(struct uart_port *port)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->port.line);
 
@@ -845,7 +845,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned char cval = 0;
-	unsigned long flags = 0;
+	unsigned long flags;
 	unsigned int baud, quot;
 
 	switch (termios->c_cflag & CSIZE) {
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 87f7127b57e6..a28b51519bff 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -184,8 +184,8 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		int init_hw)
 {
 	struct uart_port *uport = uart_port_check(state);
+	unsigned long flags;
 	unsigned long page;
-	unsigned long flags = 0;
 	int retval = 0;
 
 	if (uport->type == PORT_UNKNOWN)
@@ -275,7 +275,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 {
 	struct uart_port *uport = uart_port_check(state);
 	struct tty_port *port = &state->port;
-	unsigned long flags = 0;
+	unsigned long flags;
 	char *xmit_buf = NULL;
 
 	/*
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index e7048515a79c..f092c11f9d7d 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -478,7 +478,7 @@ static void asc_pm(struct uart_port *port, unsigned int state,
 		unsigned int oldstate)
 {
 	struct asc_port *ascport = to_asc_port(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 	u32 ctl;
 
 	switch (state) {
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index c2ae7b392b86..bf188bdf9717 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -980,7 +980,7 @@ static void stm32_usart_pm(struct uart_port *port, unsigned int state,
 			struct stm32_port, port);
 	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	const struct stm32_usart_config *cfg = &stm32port->info->cfg;
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	switch (state) {
 	case UART_PM_STATE_ON:
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 67a2db621e2b..9bca52ffd84d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -497,8 +497,8 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 	struct uart_port *port;
 	int locked = 0;
 	struct clk_notifier_data *ndata = data;
-	unsigned long flags = 0;
 	struct cdns_uart *cdns_uart = to_cdns_uart(nb);
+	unsigned long flags;
 
 	port = cdns_uart->port;
 	if (port->suspended)
@@ -1210,7 +1210,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 				unsigned int count)
 {
 	struct uart_port *port = console_port;
-	unsigned long flags = 0;
+	unsigned long flags;
 	unsigned int imr, ctrl;
 	int locked = 1;
 
@@ -1308,7 +1308,7 @@ static int cdns_uart_suspend(struct device *device)
 	may_wake = device_may_wakeup(device);
 
 	if (console_suspend_enabled && uart_console(port) && may_wake) {
-		unsigned long flags = 0;
+		unsigned long flags;
 
 		spin_lock_irqsave(&port->lock, flags);
 		/* Empty the receive FIFO 1st before making changes */
@@ -1339,7 +1339,7 @@ static int cdns_uart_resume(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
 	struct cdns_uart *cdns_uart = port->private_data;
-	unsigned long flags = 0;
+	unsigned long flags;
 	u32 ctrl_reg;
 	int may_wake;
 
-- 
2.26.3

