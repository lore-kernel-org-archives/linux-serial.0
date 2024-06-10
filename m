Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56006152194
	for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058345; cv=none; b=bBN9r3npfU+q4GpQrdALU4FE9i7JYqtVaIMnsgUYMBW1JkpB0DgIEBZGEFQPFyuzUijkSyW5XCFIGeHKKR5eEXeQF9R3xztyEUrYPZ47DBrOUhr+7Im42CHsCrDo625Qs2Pb4QtgLe3nzAIi7rukrUxew6a3uoz2FEWS+PSJ7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058345; c=relaxed/simple;
	bh=RnoS6zqB2gyVXpDH7o8NAhawIEmf5hxfeG4UQ9Vryho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+b5vletckN6JvuBpYc3i/QqXJJHfPl5pMEAans/N2R6XJHNzNHaItkVaSDsPLm2jJ95LvsqHAUbhpcM+CxWNFCgKEWA5HPdBs0fnY0Hh0Vd4BXd46rOnkihxbo9MaC9Xlr/ZSj2xOoEWXndtVj5mqhIdzu1H2GvtiNAaoySE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dpAulJ3k; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dpAulJ3k"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e3ff7c4cc8so2423172a12.3
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058344; x=1718663144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nETmm5OPAIBFKuCxX5lk0WXDKemFgz1e5JKkxgmYsSE=;
        b=dpAulJ3k1wazpryXdvK8eeVfAZ6ERxMmRwFjUnsIxWcb1jJCeSlbvcd4u3WBbO5LSs
         zYfWtnejBW57crKgTcLebLx4lHZvCvqodPV3q3U+6o/Awc8V+pb6ysonKrDhaumYg5WZ
         JHPXCaP57hHSeH/ZG5ZPr3jwbt2RStEnqUB8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058344; x=1718663144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nETmm5OPAIBFKuCxX5lk0WXDKemFgz1e5JKkxgmYsSE=;
        b=MW9cmSwctoeBfFKafRvIdMCP0GFw3IcdkZ+XQGSI5P3+wfpl7C5oiypgQtebFcgKW8
         TJqdMZ2+W9ApF3X+4OVk4mr/ofbdF9E0CRHLPpsqyodLFI8RR9eT5wmrxbpJq/QAvMOP
         BYsVaFP2EGfOQeuedFa3Xo4uYBLj79C7yw84Ce3ZjuQMWQ2206c0wXF5iNyth6mUk998
         AnZrqQMYtJLywhVWMspjTvfznQ83GoPAzDR6Yyj1XfTESYu9WA8GF2vPTkdq89PdIOa/
         YTz3HzfrAxjtNtFaAbXJbVfwXeqlmJR5wlTBwuN8DrfKKGpDc2YdlE7J1FmZXdPzYwRc
         s9tw==
X-Forwarded-Encrypted: i=1; AJvYcCW6WRrbTcKohxz6O9nzHeUXtS7i8DNtDpRVkFkknbkBgdNpmJsuXqv662398A7Z0GDJsWoGzEVuLTlMRuCSEovHM8dI/C0VKbGRfFhz
X-Gm-Message-State: AOJu0YwRPho9rfLDSv9wJloD4jozpNPuiMk6T9uEyqZSMblgJgOHjYwD
	Ndpm+INdXGt8kgjxJUU6jRpXmQssKjAgCd74D+nGVFB8TiTPXVNU9+QTsngj5w==
X-Google-Smtp-Source: AGHT+IFUuuWsoC+D5uqvA710tXTDxYwnjRmz/kAVL0BbDvyHZAIO2Sc1o7cBH4lIgZ+bMm5fuhoJKA==
X-Received: by 2002:a17:902:d510:b0:1f7:1bdf:6ce with SMTP id d9443c01a7336-1f71bdf0893mr29298045ad.27.1718058343698;
        Mon, 10 Jun 2024 15:25:43 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:bba2:69f4:1b51:d0f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71029e223sm29212325ad.170.2024.06.10.15.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:25:41 -0700 (PDT)
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
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v4 3/8] serial: qcom-geni: Fix the timeout in qcom_geni_serial_poll_bit()
Date: Mon, 10 Jun 2024 15:24:21 -0700
Message-ID: <20240610152420.v4.3.I3e1968bbeee67e28fd4e15509950805b6665484a@changeid>
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

The qcom_geni_serial_poll_bit() is supposed to be able to be used to
poll a bit that's will become set when a TX transfer finishes. Because
of this it tries to set its timeout based on how long the UART will
take to shift out all of the queued bytes. There are two problems
here:
1. There appears to be a hidden extra word on the firmware side which
   is the word that the firmware has already taken out of the FIFO and
   is currently shifting out. We need to account for this.
2. The timeout calculation was assuming that it would only need 8 bits
   on the wire to shift out 1 byte. This isn't true. Typically 10 bits
   are used (8 data bits, 1 start and 1 stop bit), but as much as 13
   bits could be used (14 if we allowed 9 bits per byte, which we
   don't).

The too-short timeout was seen causing problems in a future patch
which more properly waited for bytes to transfer out of the UART
before cancelling.

Rather than fix the calculation, replace it with the core-provided
uart_fifo_timeout() function.

NOTE: during earlycon, uart_fifo_timeout() has the same limitations
about not being able to figure out the exact timeout that the old
function did. Luckily uart_fifo_timeout() returns the same default
timeout of 20ms in this case. We'll add a comment about it, though, to
make it more obvious what's happening.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- Use uart_fifo_timeout_ms() for timeout.

Changes in v3:
- Use uart_fifo_timeout() for timeout.

Changes in v2:
- New

 drivers/tty/serial/qcom_geni_serial.c | 38 +++++++++++++--------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2bd25afe0d92..e44edf63db78 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -124,7 +124,6 @@ struct qcom_geni_serial_port {
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
 	bool setup;
-	unsigned int baud;
 	unsigned long clk_rate;
 	void *rx_buf;
 	u32 loopback;
@@ -269,30 +268,30 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 				int offset, int field, bool set)
 {
 	u32 reg;
-	struct qcom_geni_serial_port *port;
-	unsigned int baud;
-	unsigned int fifo_bits;
-	unsigned long timeout_us = 20000;
-	struct qcom_geni_private_data *private_data = uport->private_data;
+	unsigned long timeout_us;
 
-	if (private_data->drv) {
-		port = to_dev_port(uport);
-		baud = port->baud;
-		if (!baud)
-			baud = 115200;
-		fifo_bits = port->tx_fifo_depth * port->tx_fifo_width;
-		/*
-		 * Total polling iterations based on FIFO worth of bytes to be
-		 * sent at current baud. Add a little fluff to the wait.
-		 */
-		timeout_us = ((fifo_bits * USEC_PER_SEC) / baud) + 500;
-	}
+	/*
+	 * This function is used to poll bits, some of which (like CMD_DONE)
+	 * might take as long as it takes for the FIFO plus the temp register
+	 * on the geni side to drain. The Linux core calculates such a timeout
+	 * for us and we can get it from uart_fifo_timeout().
+	 *
+	 * It should be noted that during earlycon the variables that
+	 * uart_fifo_timeout() makes use of in "uport" may not be setup yet.
+	 * It's difficult to set things up for earlycon since it can't
+	 * necessarily figure out the baud rate and reading the FIFO depth
+	 * from the wrapper means some extra MMIO maps that we don't get by
+	 * default. This isn't a big problem, though, since uart_fifo_timeout()
+	 * gives back its "slop" of 20ms as a minimum and that should be
+	 * plenty of time for earlycon unless we're running at an extremely
+	 * low baud rate.
+	 */
+	timeout_us = uart_fifo_timeout_ms(uport) * USEC_PER_MSEC;
 
 	/*
 	 * Use custom implementation instead of readl_poll_atomic since ktimer
 	 * is not ready at the time of early console.
 	 */
-	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
 	while (timeout_us) {
 		reg = readl(uport->membase + offset);
 		if ((bool)(reg & field) == set)
@@ -1224,7 +1223,6 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	qcom_geni_serial_stop_rx(uport);
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 4000000);
-	port->baud = baud;
 
 	sampling_rate = UART_OVERSAMPLING;
 	/* Sampling rate is halved for IP versions >= 2.5 */
-- 
2.45.2.505.gda0bf45e8d-goog

