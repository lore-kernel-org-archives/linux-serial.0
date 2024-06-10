Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F711527AC
	for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058359; cv=none; b=sWGiXWPqf1jwMbrZekAzJY1z2T2xQxVYkUgSLJdN9BNsKd4mrFdwoBxevrObbhO+na1WzT08jQrrQxTTApzCsKuXzMa6Lpu4HVsmMM2iF9dtlGW0qaC/Pfya6DZ+Aw6/D0d8WKQEEJz4NCtRPXvXwT1KF0Pq5WhpUvx+HO6An9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058359; c=relaxed/simple;
	bh=W5k61dIOmXHnbyezQtKZayb/ED5DHMlBXk1KBn/42dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EidlW9nIhNXL88zTlcYcFh+En8MDOeGHhTDkOh4vy/diP0joq3JIuA/dOkIdezZf/LXiWoi/3e0cYzmmK1BzFnEyUlfT2iUTWPf25agy4UdtOCc0Od5/p0ASzs9wIcTJHC7rmVeWiru2zEVEiMgRCLVF1Tehev+oK3PP/54AwQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UQfudMbf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UQfudMbf"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f44b441b08so2998825ad.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058356; x=1718663156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9co72bpjsMlKfOD8v7UyjxW/E48JEzikY+FywvWUpE=;
        b=UQfudMbflWSXKS5LOtDVH/SHJ5/YGwccEaIn24TLt+LJM4SiBcFPmA2lq4cuHRk6DO
         ecd5NQYKVsjzqagypVTo3ku5AI0leVS38vya4ADunlXCAN2oWxuzry5T8hRvnqRQXnxW
         LyRw43phEEG0ulwpq3uTB5eS4rN9y6q9XFwaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058356; x=1718663156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9co72bpjsMlKfOD8v7UyjxW/E48JEzikY+FywvWUpE=;
        b=NNt7hTv6HdQfyjyLx9Hmgc6Pync7kxKuCa8Q1PpE2z5t8tgq+zRlGcezjftYDFlo0D
         qUZ7a+0p3uAbYaqBdZtFp6NJRNtcS+xLgyjfZWnnoljOP8oPBi+USai+2yzNPPfrlEPE
         9Q6kO5k7PQWREQwsFddYvLYd1ysQeag5AYfqpzqCjz7nHYTTzPmbaG5rChs0ZVi4s3ho
         saMxRWR+8MUg7eO0yGHjNyyQq1USh9Z+I06kzWj3ezcQxe7MTKAJgP6nEwmrAe65yNs2
         0xhF6goyinrtasz0fHMU26c98nTHXTMaIOVUXy1fkyTH0A2pKD8uhnOqZaNwCwa+OCtA
         sbKw==
X-Forwarded-Encrypted: i=1; AJvYcCVO2WOLSoC69v/0uKkn5lqCLb7+fJtv42MK23TIoXd5yA/Iz9eOIq4WwLhOg7h52mNKeHueEpGkt8XQ7Ze/SL9zDl/jN6LsqXjA1/XY
X-Gm-Message-State: AOJu0Yy7HgitVG3EBkqUwfk5ZSYxdG0JKhUTYv4jpAigq7PyG4oYta+0
	PudMBBnK8qZ7EkVjWc9nLVIOcptTZ85njvTsbrgCrHoW/ibqpwUSckuIQL+3uQ==
X-Google-Smtp-Source: AGHT+IH59R6MplWj1s33haI8ahEhNVx+aUxBf3hIb++l1A06aH/X0DYqh1F8lzQAZpNaObW7K7b7+w==
X-Received: by 2002:a17:903:2311:b0:1f7:22a8:4f8a with SMTP id d9443c01a7336-1f722a851fcmr19328425ad.57.1718058355796;
        Mon, 10 Jun 2024 15:25:55 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:bba2:69f4:1b51:d0f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71029e223sm29212325ad.170.2024.06.10.15.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:25:54 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 7/8] serial: qcom-geni: Fix suspend while active UART xfer
Date: Mon, 10 Jun 2024 15:24:25 -0700
Message-ID: <20240610152420.v4.7.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240610222515.3023730-1-dianders@chromium.org>
References: <20240610222515.3023730-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On devices using Qualcomm's GENI UART it is possible to get the UART
stuck such that it no longer outputs data. Specifically, logging in
via an agetty on the debug serial port (which was _not_ used for
kernel console) and running:
  cat /var/log/messages
...and then (via an SSH session) forcing a few suspend/resume cycles
causes the UART to stop transmitting.

The root of the problems was with qcom_geni_serial_stop_tx_fifo()
which is called as part of the suspend process. Specific problems with
that function:
- When an in-progress "tx" command is cancelled it doesn't appear to
  fully drain the FIFO. That meant qcom_geni_serial_tx_empty()
  continued to report that the FIFO wasn't empty. The
  qcom_geni_serial_start_tx_fifo() function didn't re-enable
  interrupts in this case so the driver would never start transferring
  again.
- When the driver cancelled the current "tx" command but it forgot to
  zero out "tx_remaining". This confused logic elsewhere in the
  driver.
- From experimentation, it appears that cancelling the "tx" command
  could drop some of the queued up bytes.

While qcom_geni_serial_stop_tx_fifo() could be fixed to drain the FIFO
and shut things down properly, stop_tx() isn't supposed to be a slow
function. It is run with local interrupts off and is documented to
stop transmitting "as soon as possible". Change the function to just
stop new bytes from being queued. In order to make this work, change
qcom_geni_serial_start_tx_fifo() to remove some conditions. It's
always safe to enable the watermark interrupt and the IRQ handler will
disable it if it's not needed.

For system suspend the queue still needs to be drained. Failure to do
so means that the hardware won't provide new interrupts until a
"cancel" command is sent. Add draining logic (fixing the issues noted
above) at suspend time.

NOTE: It would be ideal if qcom_geni_serial_stop_tx_fifo() could
"pause" the transmitter right away. There is no obvious way to do this
in the docs and experimentation didn't find any tricks either, so
stopping TX "as soon as possible" isn't very soon but is the best
possible.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
There are still a number of problems with GENI UART after this but
I've kept this change separate to make it easier to understand.
Specifically on mainline just hitting "Ctrl-C" after dumping
/var/log/messages to the serial port hangs things after the kfifo
changes. Those issues will be addressed in future patches.

It should also be noted that the "Fixes" tag here is a bit of a
swag. I haven't gone and tested on ancient code, but at least the
problems exist on kernel 5.15 and much of the code touched here has
been here since the beginning, or at least since as long as the driver
was stable.

Changes in v4:
- Fix indentation.
- GENMASK(31, 0) -> GP_LENGTH.

Changes in v3:
- 0xffffffff => GENMASK(31, 0)
- Reword commit message.

Changes in v2:
- Totally rework / rename patch to handle suspend while active xfer

 drivers/tty/serial/qcom_geni_serial.c | 97 +++++++++++++++++++++------
 1 file changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 132669a2da34..1a66424f0f5f 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -130,6 +130,7 @@ struct qcom_geni_serial_port {
 	bool brk;
 
 	unsigned int tx_remaining;
+	unsigned int tx_total;
 	int wakeup_irq;
 	bool rx_tx_swap;
 	bool cts_rts_swap;
@@ -310,11 +311,14 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 
 static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
 {
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 m_cmd;
 
 	writel(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
 	m_cmd = UART_START_TX << M_OPCODE_SHFT;
 	writel(m_cmd, uport->membase + SE_GENI_M_CMD0);
+
+	port->tx_total = xmit_size;
 }
 
 static void qcom_geni_serial_poll_tx_done(struct uart_port *uport)
@@ -334,6 +338,64 @@ static void qcom_geni_serial_poll_tx_done(struct uart_port *uport)
 	writel(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
+static void qcom_geni_serial_drain_tx_fifo(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
+	/*
+	 * If the main sequencer is inactive it means that the TX command has
+	 * been completed and all bytes have been sent. Nothing to do in that
+	 * case.
+	 */
+	if (!qcom_geni_serial_main_active(uport))
+		return;
+
+	/*
+	 * Wait until the FIFO has been drained. We've already taken bytes out
+	 * of the higher level queue in qcom_geni_serial_send_chunk_fifo() so
+	 * if we don't drain the FIFO but send the "cancel" below they seem to
+	 * get lost.
+	 */
+	qcom_geni_serial_poll_bitfield(uport, SE_GENI_M_GP_LENGTH, GP_LENGTH,
+				       port->tx_total - port->tx_remaining);
+
+	/*
+	 * If clearing the FIFO made us inactive then we're done--no need for
+	 * a cancel.
+	 */
+	if (!qcom_geni_serial_main_active(uport))
+		return;
+
+	/*
+	 * Cancel the current command. After this the main sequencer will
+	 * stop reporting that it's active and we'll have to start a new
+	 * transfer command.
+	 *
+	 * If we skip doing this cancel and then continue with a system
+	 * suspend while there's an active command in the main sequencer
+	 * then after resume time we won't get any more interrupts on the
+	 * main sequencer until we send the cancel.
+	 */
+	geni_se_cancel_m_cmd(&port->se);
+	if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
+				       M_CMD_CANCEL_EN, true)) {
+		/* The cancel failed; try an abort as a fallback. */
+		geni_se_abort_m_cmd(&port->se);
+		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
+					  M_CMD_ABORT_EN, true);
+		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+	}
+	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+
+	/*
+	 * We've cancelled the current command. "tx_remaining" stores how
+	 * many bytes are left to finish in the current command so we know
+	 * when to start a new command. Since the command was cancelled we
+	 * need to zero "tx_remaining".
+	 */
+	port->tx_remaining = 0;
+}
+
 static void qcom_geni_serial_abort_rx(struct uart_port *uport)
 {
 	u32 irq_clear = S_CMD_DONE_EN | S_CMD_ABORT_EN;
@@ -654,37 +716,18 @@ static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
 {
 	u32 irq_en;
 
-	if (qcom_geni_serial_main_active(uport) ||
-	    !qcom_geni_serial_tx_empty(uport))
-		return;
-
 	irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
 	irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
-
 	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 }
 
 static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 {
 	u32 irq_en;
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	/* Possible stop tx is called multiple times. */
-	if (!qcom_geni_serial_main_active(uport))
-		return;
-
-	geni_se_cancel_m_cmd(&port->se);
-	if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-						M_CMD_CANCEL_EN, true)) {
-		geni_se_abort_m_cmd(&port->se);
-		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-						M_CMD_ABORT_EN, true);
-		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
-	}
-	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
 static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
@@ -1066,7 +1109,15 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
 }
 
 
-static void qcom_geni_serial_shutdown(struct uart_port *uport)
+static void qcom_geni_serial_shutdown_dma(struct uart_port *uport)
+{
+	disable_irq(uport->irq);
+
+	qcom_geni_serial_stop_tx(uport);
+	qcom_geni_serial_stop_rx(uport);
+}
+
+static void qcom_geni_serial_shutdown_fifo(struct uart_port *uport)
 {
 	disable_irq(uport->irq);
 
@@ -1075,6 +1126,8 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 
 	qcom_geni_serial_stop_tx(uport);
 	qcom_geni_serial_stop_rx(uport);
+
+	qcom_geni_serial_drain_tx_fifo(uport);
 }
 
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
@@ -1532,7 +1585,7 @@ static const struct uart_ops qcom_geni_console_pops = {
 	.startup = qcom_geni_serial_startup,
 	.request_port = qcom_geni_serial_request_port,
 	.config_port = qcom_geni_serial_config_port,
-	.shutdown = qcom_geni_serial_shutdown,
+	.shutdown = qcom_geni_serial_shutdown_fifo,
 	.type = qcom_geni_serial_get_type,
 	.set_mctrl = qcom_geni_serial_set_mctrl,
 	.get_mctrl = qcom_geni_serial_get_mctrl,
@@ -1554,7 +1607,7 @@ static const struct uart_ops qcom_geni_uart_pops = {
 	.startup = qcom_geni_serial_startup,
 	.request_port = qcom_geni_serial_request_port,
 	.config_port = qcom_geni_serial_config_port,
-	.shutdown = qcom_geni_serial_shutdown,
+	.shutdown = qcom_geni_serial_shutdown_dma,
 	.type = qcom_geni_serial_get_type,
 	.set_mctrl = qcom_geni_serial_set_mctrl,
 	.get_mctrl = qcom_geni_serial_get_mctrl,
-- 
2.45.2.505.gda0bf45e8d-goog

