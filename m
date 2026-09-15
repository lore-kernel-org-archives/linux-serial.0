Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95BD456E03;
	Tue, 15 Sep 2026 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502686; cv=none; b=PwGljrF2G/pSBa0L2qP2Uioc7PPc8iPe4SMEu5xQ6rdi2K2PDKMIoB1KgqI6nr6X296C3eMJ5y4T6Hg+/vMVdPLqc70jkig0VDhuisVzHKnhaWYeznL2Yp0zhgqBFERUBQoi+xZuj1I8LbUtHRnnpUZ152lBLo2GEJnPDxL4JWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502686; c=relaxed/simple;
	bh=vlF93fqZgzjB9CFcevEyM2vWZFBAhMHI9qyOl+lZ9Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mou6bx8Bl+5vVyoIeno1x8c3AVTIp0Z3fMqR//jIny8EVXbBj8iN9SOpzgrzOxmFZTQ95K0PJv6OKDn2Wq5GaZwyx6+0tJ2cwMBjawPrWI+MXjWHqX+TRVadjfM43uld+DpN//Ke3OIw05JZyRfVEN3uvnEMHticobM+SHC29C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThaJ56Sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThaJ56Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872B81F000FF;
	Tue, 15 Sep 2026 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789502681;
	bh=q78L4/vDO6Lu8fPZFSYnJqNi8VQABd/NBnCciOQTVW0=;
	h=From:To:Cc:Subject:Date;
	b=ThaJ56SgqF2eWSPt87Sk3LTcRnaG0V21fUl40tuHXJo4oK/ydCm17boIRl8DS7Opm
	 cLhf4O+K/+ol1wCaHD/NOHEUD4K4Xq07wv2F2uEy22EFY0MYi0K1AUASVIIHAXSmm9
	 hoKgwuKoQuZJS2B4VxGTuQj2BRk3dlXPUc++jHBUMDEMGBd9F2ojHUmvq3QIr5/Ui5
	 PCanTCL1Q46uMo2bH4K+Tb8TaBhudfk0DwK0ds2NfHYUGdYQkHbfVvZ7M4OhBgCNEU
	 sDU9hmf4Wy+G7rGqZpmGgtkGMK5BqZh6PBHQQzZr8YjooB+4fkph+RXMSKR56ghS/E
	 QrP3+qgFRj4Mg==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Aniket Randive <aniket.randive@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: qcom-geni: avoid unused-function warning
Date: Tue, 15 Sep 2026 22:04:11 +0200
Message-ID: <20260915200435.3524505-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The qcom_geni_serial_poll_rx_fifo_locked() function is only
used for console support, but defined outside of the #ifdef block:

drivers/tty/serial/qcom_geni_serial.c:918:13: error: 'qcom_geni_serial_poll_rx_fifo_locked' defined but not used [-Werror=unused-function]
  918 | static void qcom_geni_serial_poll_rx_fifo_locked(struct uart_port *uport)

Move the function definition to a more appropriate place that
avoids the warning.

Fixes: 8200871327d1 ("serial: qcom-geni: Keep FIFO RX active during console TX")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/qcom_geni_serial.c | 190 +++++++++++++-------------
 1 file changed, 96 insertions(+), 94 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..21213f5546b5 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -171,7 +171,6 @@ static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
 static int qcom_geni_serial_port_setup(struct uart_port *uport);
 static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport);
 static void qcom_geni_serial_resume_tx(struct uart_port *uport);
-static void qcom_geni_serial_poll_rx_fifo_locked(struct uart_port *uport);
 
 static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
 {
@@ -467,6 +466,102 @@ static int qcom_geni_serial_poll_init(struct uart_port *uport)
 #endif
 
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
+static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
+{
+	u32 i;
+	unsigned char buf[sizeof(u32)];
+	struct tty_port *tport;
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
+	tport = &uport->state->port;
+	for (i = 0; i < bytes; ) {
+		int c;
+		int chunk = min_t(int, bytes - i, BYTES_PER_FIFO_WORD);
+
+		ioread32_rep(uport->membase + SE_GENI_RX_FIFOn, buf, 1);
+		i += chunk;
+		if (drop)
+			continue;
+
+		for (c = 0; c < chunk; c++) {
+			int sysrq;
+
+			uport->icount.rx++;
+			if (port->brk && buf[c] == 0) {
+				port->brk = false;
+				if (uart_handle_break(uport))
+					continue;
+			}
+
+			sysrq = uart_prepare_sysrq_char(uport, buf[c]);
+
+			if (!sysrq)
+				tty_insert_flip_char(tport, buf[c], TTY_NORMAL);
+		}
+	}
+	if (!drop)
+		tty_flip_buffer_push(tport);
+}
+#else
+static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
+{
+
+}
+#endif
+
+static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
+{
+	u32 status;
+	u32 word_cnt;
+	u32 last_word_byte_cnt;
+	u32 last_word_partial;
+	u32 total_bytes;
+
+	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
+	word_cnt = status & RX_FIFO_WC_MSK;
+	last_word_partial = status & RX_LAST;
+	last_word_byte_cnt = (status & RX_LAST_BYTE_VALID_MSK) >>
+						RX_LAST_BYTE_VALID_SHFT;
+
+	if (!word_cnt)
+		return;
+	total_bytes = BYTES_PER_FIFO_WORD * (word_cnt - 1);
+	if (last_word_partial && last_word_byte_cnt)
+		total_bytes += last_word_byte_cnt;
+	else
+		total_bytes += BYTES_PER_FIFO_WORD;
+	handle_rx_console(uport, total_bytes, drop);
+}
+
+#ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
+/* Caller holds the UART port lock. */
+static void qcom_geni_serial_poll_rx_fifo_locked(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct tty_port *tport = &uport->state->port;
+	u32 s_irq_status;
+	bool drop_rx = false;
+
+	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
+	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
+
+	if (s_irq_status & S_RX_FIFO_WR_ERR_EN) {
+		uport->icount.overrun++;
+		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
+	}
+
+	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
+		if (s_irq_status & S_GP_IRQ_0_EN)
+			uport->icount.parity++;
+		drop_rx = true;
+	} else if (s_irq_status & (S_GP_IRQ_2_EN | S_GP_IRQ_3_EN)) {
+		uport->icount.brk++;
+		port->brk = true;
+	}
+
+	qcom_geni_serial_handle_rx_fifo(uport, drop_rx);
+}
+
 static void qcom_geni_serial_drain_fifo(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
@@ -676,47 +771,6 @@ static void qcom_geni_serial_console_device_unlock(struct console *co,
 #endif
 }
 
-static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
-{
-	u32 i;
-	unsigned char buf[sizeof(u32)];
-	struct tty_port *tport;
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
-
-	tport = &uport->state->port;
-	for (i = 0; i < bytes; ) {
-		int c;
-		int chunk = min_t(int, bytes - i, BYTES_PER_FIFO_WORD);
-
-		ioread32_rep(uport->membase + SE_GENI_RX_FIFOn, buf, 1);
-		i += chunk;
-		if (drop)
-			continue;
-
-		for (c = 0; c < chunk; c++) {
-			int sysrq;
-
-			uport->icount.rx++;
-			if (port->brk && buf[c] == 0) {
-				port->brk = false;
-				if (uart_handle_break(uport))
-					continue;
-			}
-
-			sysrq = uart_prepare_sysrq_char(uport, buf[c]);
-
-			if (!sysrq)
-				tty_insert_flip_char(tport, buf[c], TTY_NORMAL);
-		}
-	}
-	if (!drop)
-		tty_flip_buffer_push(tport);
-}
-#else
-static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
-{
-
-}
 #endif /* CONFIG_SERIAL_QCOM_GENI_CONSOLE */
 
 static void handle_rx_uart(struct uart_port *uport, u32 bytes)
@@ -890,58 +944,6 @@ static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
 	port->tx_queued = 0;
 }
 
-static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
-{
-	u32 status;
-	u32 word_cnt;
-	u32 last_word_byte_cnt;
-	u32 last_word_partial;
-	u32 total_bytes;
-
-	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
-	word_cnt = status & RX_FIFO_WC_MSK;
-	last_word_partial = status & RX_LAST;
-	last_word_byte_cnt = (status & RX_LAST_BYTE_VALID_MSK) >>
-						RX_LAST_BYTE_VALID_SHFT;
-
-	if (!word_cnt)
-		return;
-	total_bytes = BYTES_PER_FIFO_WORD * (word_cnt - 1);
-	if (last_word_partial && last_word_byte_cnt)
-		total_bytes += last_word_byte_cnt;
-	else
-		total_bytes += BYTES_PER_FIFO_WORD;
-	handle_rx_console(uport, total_bytes, drop);
-}
-
-/* Caller holds the UART port lock. */
-static void qcom_geni_serial_poll_rx_fifo_locked(struct uart_port *uport)
-{
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	struct tty_port *tport = &uport->state->port;
-	u32 s_irq_status;
-	bool drop_rx = false;
-
-	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
-	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
-
-	if (s_irq_status & S_RX_FIFO_WR_ERR_EN) {
-		uport->icount.overrun++;
-		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-	}
-
-	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
-		if (s_irq_status & S_GP_IRQ_0_EN)
-			uport->icount.parity++;
-		drop_rx = true;
-	} else if (s_irq_status & (S_GP_IRQ_2_EN | S_GP_IRQ_3_EN)) {
-		uport->icount.brk++;
-		port->brk = true;
-	}
-
-	qcom_geni_serial_handle_rx_fifo(uport, drop_rx);
-}
-
 static void qcom_geni_serial_stop_rx_fifo(struct uart_port *uport)
 {
 	u32 irq_en;
-- 
2.53.0

