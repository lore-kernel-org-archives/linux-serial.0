Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614396;
	b=V5HlDyBZvrBd2JRaLxW/DYwDDggde3MU3+V9eNwrSTfOKLWkAEU9HUkqAv1/gp2OcItv
	 o1e3eEJpJz1bggzfqjJXaPCA021jAdZTXdtjks9njrgX+z6x9JFghPeBNjeHbPnTOhtTw
	 DUHUdgWA8znJaesIQlXwmzYipLvrUioVYdAd5K91ONN+4zd89aMmnGaX47ZjzxIYIumEr
	 hnXC8W5kt2xpv1CFR3LS3DZt1wU9i5kUb+56/IMpxfbRzqjJb4vUkenalJkuwm+C2Uxxg
	 Dzde5qb0wBU5oJ57lmUZzlwmmPQlyfGQDcq9yIQmjzcBGPdOMTBuLqMSBfUfN3VVYNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614396;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=E2pTPMKUQJD5SV65KUhENq72igG4uuAAoV5xy1VuYmA=;
	b=UVZBbXnh1Y3h8EyeS1yYv8svAuEl+BBJ4Vx3WbrGnYFlblco1TypJzxTRR+vpOvL0Fpw
	 +oeTefUA7ysGPcjyYJecVsCXR1GilB8oIc619gJO1H+FPLivcgKFkM4gEVSW+jO/imgWA
	 tr0x3gAH8edt+xv3RMJUOY/a4ZKBG9EO6AN6Ocuh7juHe0pptltpYS9koyMPVadxa70t8
	 rCy4JYuKh85Hi/6/GCP+qvtjQXn0In6pn7iRI3iFeXlR84E2ELCyk6eH+Blcy0chm+xK0
	 HPeUvgqfLZ+DgCCyKdfUYT53y1H6t09sWLbpqrGWoXccKZVjG97R6fxppn/6bpY1T1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=3EIwuN13;
	arc=none smtp.remote-ip=109.224.244.107
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFC606A323;
	Wed, 21 Oct 2026 20:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADAFC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=3EIwuN13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1792614391; x=1792873591;
	bh=E2pTPMKUQJD5SV65KUhENq72igG4uuAAoV5xy1VuYmA=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=3EIwuN13mRx60PgDwUFijdHtb2b+vrGxOONLJ84KBuHkxbvrlTvXiP/GrDXMHMYnJ
	 iBlDRH9E7UzxG5kukFXg2dbsqfljpjrDzTXoIJTmdY0y1kZxtJ2fmXRotM/Hykr6/7
	 9WJAG0GJCfIpclPTmVUdBYh21RkzcAr5y/rH8XM7to03gz2MCeMpQ8dmArPyimApNN
	 bEWlTFZcLqtr2P1U0l26pLqi7uLoyzYI0AVsjOmM635YYnsvkHKexAvptEFFaYDxja
	 85mb76usdedOfCu4p2jr0JkOWLH6tOO62YYgEPktw3Yfg8dnBv7h3IVnyOff08wgSO
	 W1+4MNpWydR/Q==
X-Pm-Submission-Id: 4j915f1BsSz2Sccv
From: Michael McAllister <me@michaelmcallister.org>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: qcom-geni: Set UPSTAT_AUTOCTS for hardware flow control
Date: Wed, 21 Oct 2026 21:26:03 +0100
Message-ID: <20261021202603.42888-1-me@michaelmcallister.org>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qcom_geni_serial_set_termios() clears UART_CTS_MASK when CRTSCTS is set,
enabling hardware CTS flow control. However, it never sets UPSTAT_AUTOCTS,
so uart_softcts_mode() also selects software-assisted CTS flow control.

If CTS is deasserted when uart_change_line_settings() samples the modem
status, serial core sets hw_stopped and stops transmission. The GENI
driver does not handle CTS-change interrupts, so asserting CTS again does
not clear hw_stopped or restart the transmitter.

On a Motorola Moto G10 with WCN3950, this can stall Bluetooth setup in
tty_wait_until_sent() while qca_setup() closes the serial port. A captured
stall had one byte left in the software transmit queue, hw_stopped set,
and CTS asserted, with the UART powered and its interrupt enabled.

Set UPSTAT_AUTOCTS under the port lock when CRTSCTS is enabled, and clear
it when CRTSCTS is disabled, to match the hardware configuration.

Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for flow control")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Hardware validation used the same change in the Motorola Moto G10 Linux
7.2.9 port.

Before the fix, a Bluetooth power-cycle test captured qca_setup() blocked
in tty_wait_until_sent() through serdev_device_close(), with:

  software TX pending: 1 byte
  hw_stopped:          1
  UART status:        0x1 (UPSTAT_CTS_ENABLE without UPSTAT_AUTOCTS)
  SE_GENI_IOS:         0x1 (IO2_DATA_IN clear, CTS asserted)
  UART IRQ disabled:  0
  UART IRQ masked:    0

After the fix RTC suspend/resume worked, followed by Bluetooth discovery.

Built drivers/tty/serial/qcom_geni_serial.o for arm64 with W=1 and
CONFIG_SERIAL_QCOM_GENI_CONSOLE=y against the base below.

AI assistance: Codex analyzed the saved UART diagnostics and serial-core
source and ran the build and style checks. 

 drivers/tty/serial/qcom_geni_serial.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a851b8f0ef..5782b89c84 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1503,6 +1503,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	unsigned int baud;
 	unsigned long timeout;
+	unsigned long flags;
 	u32 bits_per_char;
 	u32 tx_trans_cfg;
 	u32 tx_parity_cfg;
@@ -1596,6 +1597,14 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
 	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
 
+	/* CTS gates TX in hardware; no CTS interrupt updates hw_stopped. */
+	uart_port_lock_irqsave(uport, &flags);
+	if (termios->c_cflag & CRTSCTS)
+		uport->status |= UPSTAT_AUTOCTS;
+	else
+		uport->status &= ~UPSTAT_AUTOCTS;
+	uart_port_unlock_irqrestore(uport, flags);
+
 	trace_geni_serial_set_termios(uport->dev, baud, bits_per_char,
 				      tx_trans_cfg, tx_parity_cfg, rx_trans_cfg,
 				      rx_parity_cfg, stop_bit_len);

base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.50.1 (Apple Git-155)

