Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4062C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FC9611AF
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbhDPOMB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244276AbhDPOLx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Apr 2021 10:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C85DB6103D;
        Fri, 16 Apr 2021 14:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618582288;
        bh=cB7pOqyX3kDiJGQgNeGx64fouOP7XpEJg59geFJmqW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZ9dw420XEpYbU4bvHdp9iyRKql4POb2DNFAKZgGiXQKbgHQUjI+oSUOItXm6+WY+
         u6hqpUWPzL3yp51Z6vE4G5v/9+2f2aEOCKlgmNR7x2WPhr99XqZkXkPS3SoIrtn9Al
         Ii+54rZ63J8qU1okbZxYNyQcUD+LYQ6TdbF3TW8ohRyf5YvdIJKP8tAxP8KeddRDkn
         +F8RlMYW2NZx/vxuEfrV+9p+tLX7WzNFT2a73HA7UWKZdb4MZ/PY8bwv9R1Wz/bwvr
         onj0AdTkRcSE8LOehYsZ7rMsYQcWeevquZQA0Q9d+ugvu7c/DZhtD/PVeosy6qL1E/
         J1L/TVbG1ZHvg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lXPBx-0006aA-DW; Fri, 16 Apr 2021 16:11:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dillon.minfei@gmail.com, Erwan Le Ray <erwan.leray@foss.st.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 1/3] serial: do not restore interrupt state in sysrq helper
Date:   Fri, 16 Apr 2021 16:05:55 +0200
Message-Id: <20210416140557.25177-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210416140557.25177-1-johan@kernel.org>
References: <20210416140557.25177-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The uart_unlock_and_check_sysrq() helper can be used to defer processing
of sysrq until the interrupt handler has released the port lock and is
about to return.

Since commit 81e2073c175b ("genirq: Disable interrupts for force
threaded handlers") interrupt handlers that are not explicitly requested
as threaded are always called with interrupts disabled and there is no
need to save the interrupt state when taking the port lock.

Instead of adding another sysrq helper for when the interrupt state has
not needlessly been saved, drop the state parameter from
uart_unlock_and_check_sysrq() and update its callers to no longer
explicitly disable interrupts in their interrupt handlers.

Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  5 ++---
 drivers/tty/serial/8250/8250_fsl.c          | 11 ++++++-----
 drivers/tty/serial/8250/8250_omap.c         |  6 +++---
 drivers/tty/serial/8250/8250_port.c         |  6 +++---
 drivers/tty/serial/qcom_geni_serial.c       |  6 +++---
 include/linux/serial_core.h                 | 10 +++++-----
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 3c239d98747f..61550f24a2d3 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -320,7 +320,6 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int iir, lsr;
-	unsigned long flags;
 	int space, count;
 
 	iir = serial_port_in(port, UART_IIR);
@@ -328,7 +327,7 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	lsr = serial_port_in(port, UART_LSR);
 
@@ -364,7 +363,7 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 	if (lsr & UART_LSR_THRE)
 		serial8250_tx_chars(up);
 
-	uart_unlock_and_check_sysrq(port, flags);
+	uart_unlock_and_check_sysrq(port);
 
 	return 1;
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index cd19400b65ae..4e75d2e4f87c 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -30,15 +30,14 @@ struct fsl8250_data {
 int fsl8250_handle_irq(struct uart_port *port)
 {
 	unsigned char lsr, orig_lsr;
-	unsigned long flags;
 	unsigned int iir;
 	struct uart_8250_port *up = up_to_u8250p(port);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	spin_lock(&up->port.lock);
 
 	iir = port->serial_in(port, UART_IIR);
 	if (iir & UART_IIR_NO_INT) {
-		spin_unlock_irqrestore(&up->port.lock, flags);
+		spin_unlock(&up->port.lock);
 		return 0;
 	}
 
@@ -46,7 +45,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if (unlikely(up->lsr_saved_flags & UART_LSR_BI)) {
 		up->lsr_saved_flags &= ~UART_LSR_BI;
 		port->serial_in(port, UART_RX);
-		spin_unlock_irqrestore(&up->port.lock, flags);
+		spin_unlock(&up->port.lock);
 		return 1;
 	}
 
@@ -82,7 +81,9 @@ int fsl8250_handle_irq(struct uart_port *port)
 		serial8250_tx_chars(up);
 
 	up->lsr_saved_flags = orig_lsr;
-	uart_unlock_and_check_sysrq(&up->port, flags);
+
+	uart_unlock_and_check_sysrq(&up->port);
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 23e0decde33e..8ac11eaeca51 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1143,7 +1143,6 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = up->port.private_data;
 	unsigned char status;
-	unsigned long flags;
 	u8 iir;
 
 	serial8250_rpm_get(up);
@@ -1154,7 +1153,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 		return IRQ_HANDLED;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	status = serial_port_in(port, UART_LSR);
 
@@ -1179,7 +1178,8 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 		}
 	}
 
-	uart_unlock_and_check_sysrq(port, flags);
+	uart_unlock_and_check_sysrq(port);
+
 	serial8250_rpm_put(up);
 	return 1;
 }
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 9019f8f626bb..d45dab1ab316 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1879,14 +1879,13 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
 	unsigned char status;
-	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	bool skip_rx = false;
 
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	status = serial_port_in(port, UART_LSR);
 
@@ -1912,7 +1911,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		(up->ier & UART_IER_THRI))
 		serial8250_tx_chars(up);
 
-	uart_unlock_and_check_sysrq(port, flags);
+	uart_unlock_and_check_sysrq(port);
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(serial8250_handle_irq);
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0d85b55ea823..00bb88a71606 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -818,7 +818,6 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	u32 s_irq_status;
 	u32 geni_status;
 	struct uart_port *uport = dev;
-	unsigned long flags;
 	bool drop_rx = false;
 	struct tty_port *tport = &uport->state->port;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
@@ -826,7 +825,8 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	if (uport->suspended)
 		return IRQ_NONE;
 
-	spin_lock_irqsave(&uport->lock, flags);
+	spin_lock(&uport->lock);
+
 	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
 	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
 	geni_status = readl(uport->membase + SE_GENI_STATUS);
@@ -861,7 +861,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		qcom_geni_serial_handle_rx(uport, drop_rx);
 
 out_unlock:
-	uart_unlock_and_check_sysrq(uport, flags);
+	uart_unlock_and_check_sysrq(uport);
 
 	return IRQ_HANDLED;
 }
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index e1b684e33841..d7ed00f1594e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -500,19 +500,19 @@ static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int c
 	return 0;
 }
 
-static inline void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
 {
 	int sysrq_ch;
 
 	if (!port->has_sysrq) {
-		spin_unlock_irqrestore(&port->lock, irqflags);
+		spin_unlock(&port->lock);
 		return;
 	}
 
 	sysrq_ch = port->sysrq_ch;
 	port->sysrq_ch = 0;
 
-	spin_unlock_irqrestore(&port->lock, irqflags);
+	spin_unlock(&port->lock);
 
 	if (sysrq_ch)
 		handle_sysrq(sysrq_ch);
@@ -526,9 +526,9 @@ static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int c
 {
 	return 0;
 }
-static inline void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
 {
-	spin_unlock_irqrestore(&port->lock, irqflags);
+	spin_unlock(&port->lock);
 }
 #endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
 
-- 
2.26.3

