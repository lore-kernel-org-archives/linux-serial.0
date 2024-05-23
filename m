Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F231292E5
	for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506567; cv=none; b=dk/u9EgyY1cfoqHsTxbyqVTUtVau1VAMyG1uunGZckUJUQeIESK8eN7ghopJSCD4jPNq/x2LXaeI7apivxzaDWfe+3GUlvzoS+KkdkB1neHnVEtblAEyW7OsBvkkaZEAi71NxoQwLky2ke7YIdaescq4JAw1KQP3R+qhKajnfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506567; c=relaxed/simple;
	bh=oV1Rfj+qKyPdHTzJSmq+wfpP0m/pXfeqpjvSIitjMtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DX5aPpPJKAA5iqrq7mKkGLHuUpUHpyMfRZ9+LqZUKn7IaFfE1Ft4RfnwRkPycWtpyoypYcDlhj8S7PFybI1B2MNmR4R6PQdsSWMJMDVxOePWUSbwhEe8COJHpme1vJcZTNykR8hGzqlmPON/loPE9TAV6GKf3SXXqzx6LYyKs0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SruNbPq6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SruNbPq6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b594deeso1675365ad.2
        for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716506565; x=1717111365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2cndOyPusWD60XrwWYL/VwafNE0FrOs0G8XlptnnkQ=;
        b=SruNbPq6CfDND7ZWpZKM/xov5+ElNuMX0r2YpZMdQUy0DjfVHrMuv27feV8gEu1hxi
         HmI6aE7aSdi9Lt2RKdj+ZFBjwEtk19XxF2t14U430l99lDkDpPuoKerdxxXxSiVPTFCX
         S7w9qygItxt9Tk6sTmMyUn+N0iYVO45LHYyvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716506565; x=1717111365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2cndOyPusWD60XrwWYL/VwafNE0FrOs0G8XlptnnkQ=;
        b=HlCndN6c44JsZAu0AmNuld4flniPLs0lNfv/uwPGVs/BP0NAPNADBLCwO1IWC1Wu/W
         FrWSUzr8tp1jRlUNZv2xZ2c4w+8Tj7x2QOpsyXP0uz9QYxFOJsbYMBEx5ow0+8s0Mjg1
         KK17MRxXg/ae58LUqn37YRyl2tzMD7bMKxXQkBckyiCO4tLZDndt6Tid/DpCDrGsU27k
         322hJBE0upu1///Vpg+yKSkvHVQDwjXRezA16jp816VhxAuVZE1awMurLCjt8aVsDo0k
         8gGIwsoJxyNy2XWtkEY3CNyhFZUAGUJp6mTLRXR+j/FWxhwommJm6UcFyPYpXQM1tKVO
         i9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXnO53FeUhRfWttmuS2/5kBXP873ayZTNPp9X++qb7m3L46KQVOGg3MUFIQfqIx0KewaBXlS2Z+oLBg9WaAlrpKU1+YzYry+BljWi8O
X-Gm-Message-State: AOJu0Yz2/5XLgKXzM5BapxW0khO/a+aqP59RUkWX5oFEBYkk2WSDC0Xl
	3nEbt7+5bg25+7g/iKBZXcf+C0giNDoRvWvZ+gggaQqxhghh8Yp9g459cUj+oQ==
X-Google-Smtp-Source: AGHT+IHumt/MN1WgDMPiG970IBz7UzTszuFv7QPc41T4yeFO+pUdGKncQVg5TJZDuSajZ38nDHv2fA==
X-Received: by 2002:a17:902:f68d:b0:1f2:fccf:32d1 with SMTP id d9443c01a7336-1f4486dc807mr9531725ad.17.1716506565523;
        Thu, 23 May 2024 16:22:45 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:b835:ba86:8e6d:41c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c797938sm1279545ad.64.2024.05.23.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:22:44 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	linux-arm-msm@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Douglas Anderson <dianders@chromium.org>,
	James Clark <james.clark@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/2] serial: qcom-geni: Fix qcom_geni_serial_stop_tx_fifo() while xfer
Date: Thu, 23 May 2024 16:22:13 -0700
Message-ID: <20240523162207.2.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240523232216.3148367-1-dianders@chromium.org>
References: <20240523232216.3148367-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If qcom_geni_serial_stop_tx_fifo() was called while a transfer was
happening then the UART would be effectively stuck and wouldn't
transmit again. Specifically, I could reproduce these problem by
logging in via an agetty on the debug serial port (which was _not_
used for kernel console) and running:
  cat /var/log/messages
...and then (via an SSH session) forcing a few suspend/resume cycles.

Digging into this showed a number of problems. One problem was that we
cancelled the current "tx" command but we forgot to zero out
"tx_remaining". Another problem was that we didn't drain the buffer
before cancelling the "tx" command and thus those bytes were
lost. Another problem was that failing to drain the buffer meant that
the hardware still reported something in the FIFO and that caused
qcom_geni_serial_start_tx_fifo() to be a no-op, since it doesn't do
anything if the TX FIFO is not empty.

Though I haven't gone back and validated on ancient code, it appears
from code inspection that many of these problems have existed since
the start of the driver. In the very least, I could reproduce the
problems on vanilla v5.15. The problems don't seem to reproduce when
using the serial port for kernel console output and also don't seem to
reproduce if nothing is being printed to the console at suspend time,
so this is presumably why they were not noticed until now.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 45 +++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2bd25afe0d92..9110ac4bdbbf 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -265,8 +265,8 @@ static bool qcom_geni_serial_secondary_active(struct uart_port *uport)
 	return readl(uport->membase + SE_GENI_STATUS) & S_GENI_CMD_ACTIVE;
 }
 
-static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
-				int offset, int field, bool set)
+static bool qcom_geni_serial_poll_bitfield(struct uart_port *uport,
+					   int offset, int field, u32 val)
 {
 	u32 reg;
 	struct qcom_geni_serial_port *port;
@@ -295,7 +295,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
 	while (timeout_us) {
 		reg = readl(uport->membase + offset);
-		if ((bool)(reg & field) == set)
+		if ((reg & field) == val)
 			return true;
 		udelay(10);
 		timeout_us -= 10;
@@ -303,6 +303,12 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	return false;
 }
 
+static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
+				      int offset, int field, bool set)
+{
+	return qcom_geni_serial_poll_bitfield(uport, offset, field, set ? field : 0);
+}
+
 static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
 {
 	u32 m_cmd;
@@ -675,6 +681,31 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 	if (!qcom_geni_serial_main_active(uport))
 		return;
 
+	/*
+	 * Wait until the FIFO has been drained. We've already taken bytes out
+	 * of the higher level queue in qcom_geni_serial_send_chunk_fifo() so
+	 * if we don't drain the FIFO but send the "cancel" below they seem to
+	 * get lost.
+	 */
+	qcom_geni_serial_poll_bitfield(uport, SE_GENI_TX_FIFO_STATUS, TX_FIFO_WC, 0);
+
+	/*
+	 * If we send the cancel immediately after the FIFO reports that it's
+	 * empty then bytes still seem to get lost. From trial and error, it
+	 * appears that a small delay here keeps bytes from being lost and
+	 * there is (apparently) no bit that we can poll instead of this.
+	 * Specifically it can be noted that the sequencer is still "active"
+	 * if it's waiting for us to send it more bytes from the current
+	 * transfer.
+	 */
+	mdelay(1);
+
+	/*
+	 * Cancel the current command. After this the main sequencer will
+	 * stop reporting that it's active and we'll have to start a new
+	 * transfer command. If the cancel doesn't take, we'll also send an
+	 * abort.
+	 */
 	geni_se_cancel_m_cmd(&port->se);
 	if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_CANCEL_EN, true)) {
@@ -684,6 +715,14 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	}
 	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+
+	/*
+	 * We've cancelled the current command. "tx_remaining" stores how
+	 * many bytes are left to finish in the current command so we know
+	 * when to start a new command. Since the command was cancelled we
+	 * need to zero "tx_remaining".
+	 */
+	port->tx_remaining = 0;
 }
 
 static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
-- 
2.45.1.288.g0e0cd299f1-goog

