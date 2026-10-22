Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697849;
	b=EMaupWH82yepOhgj18RJA82Y8cnCC5IRDPUo/WIRweCcBrXMCSK+3V5rSoAMxBZukpCZ
	 eJGXb2HyFTXBWKIfqT0Z1bTzkCuGJjdUMUa6mGliltIsKAIKcfxMicnTbNTmIqEtRaNe7
	 Ys+oXYoM1lwlNzmcncnA9NkfQse33Ekc3ug81sMOdW/WE1FgRZvcdZkKO6u0nb4i04Uaa
	 6gvsR+waYV+nE9jpyypsa6TMrWhoTF+sVk3HMvxRTreIsEPAqyRggE9de00cVHsZid6Dm
	 K8irXlYEfaCNUhpV0xo3n5fBhCJc7o7xH9Bp9Tu9QKp9oP8jH5QwVIDbbCv6tPRaUQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697849;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Subject:To:Cc:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zruHm+Z4bL+3axK6aqnpOgZvWXYiNs30pnk8GtDEznU=;
	b=WLAj8vpFUjrM/lQsnR2Np2A4ZguxvrJPsd0e4pAA1xb1Wg1rrPSwstN+vyO6WulJCFaJ
	 qRe6qRvddeL2unnSzcNOpOQX1HEPzFg44Xdbzmz+mx/vYgqTQSzEEh3LeipUfjqFc9aKE
	 S5As/O3P1SJeKKshGx3478o/sytn8BRcA05YpYVc9Xssg+JOkumJ4oi2aBDlMJjNd2RXz
	 FQYrtqrM5F5LwDZACuepQCrRgtkd1yrZHBa4FjYnzpRxRF/cwqDKAtGAtWGBIIkTWPATV
	 sPDjA5G2Q/gH+7ovzEepAP9JbTRxRXJPHF9zJ1XjuU4uh624QYUjz9UK5SkqXpc/gQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=knzvP4VL;
	arc=none smtp.remote-ip=185.70.43.171
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A5606A324;
	Thu, 22 Oct 2026 19:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D44A5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=knzvP4VL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1792697847; x=1792957047;
	bh=zruHm+Z4bL+3axK6aqnpOgZvWXYiNs30pnk8GtDEznU=;
	h=From:Subject:To:Cc:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=knzvP4VLCE90UhcdR7hbEXmAP8NeNXIA70LCHJf/OdPewE83CQMlPvtbqKHbF1woK
	 2o5JrrA5PLTBRS0/dSaq74kdwXAA+M7Fa5remjy3lrNBveD+YjstkKDSmoFgDbNw3j
	 Y5xs+YU8zVBULnU5SySVn5gzk3D7U0v6CDZEF1hjuZYlWVm8fwTyAf79HlG5Z8Rh5X
	 olpDi5hHGG0EKC50CZotUUbSVRU/y/ZhB4d1HzKNPSlLbT4yJsvp1XtM+7nn/2AqAD
	 JYA3F9K+5mLci6u1ppQ4qHAMdHkcubsum0lgKBzSDTvND8dI79A1jkeRmz0dYDjx8D
	 VX4ug37y6Y+gg==
X-Pm-Submission-Id: 4j9byY4Qypz1DDrL
From: Michael McAllister <me@michaelmcallister.org>
Subject:
 [PATCH v2] serial: qcom-geni: Set UPSTAT_AUTOCTS for hardware flow control
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 20:36:39 +0100
Message-ID: <179269779969.81501.3877980314174207182.geni-autocts-v2@michaelmcallister.org>
In-Reply-To: <20261021202603.42888-1-me@michaelmcallister.org>
References: <20261021202603.42888-1-me@michaelmcallister.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

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
Changes in v2:
- Use scoped_guard(uart_port_lock_irqsave, uport), as suggested by Jiri Slaby,
  removing the flags variable and explicit lock/unlock calls.

v1: https://lore.kernel.org/linux-serial/20261021202603.42888-1-me@michaelmcallister.org/

Hardware validation used v1 with explicit lock/unlock calls in the Motorola
Moto G10 Linux 7.2.9 port. This revision preserves the same lock scope.

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

 drivers/tty/serial/qcom_geni_serial.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a851b8f0ef..aff26a8351 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1596,6 +1596,14 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
 	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
 
+	/* CTS gates TX in hardware; no CTS interrupt updates hw_stopped. */
+	scoped_guard(uart_port_lock_irqsave, uport) {
+		if (termios->c_cflag & CRTSCTS)
+			uport->status |= UPSTAT_AUTOCTS;
+		else
+			uport->status &= ~UPSTAT_AUTOCTS;
+	}
+
 	trace_geni_serial_set_termios(uport->dev, baud, bits_per_char,
 				      tx_trans_cfg, tx_parity_cfg, rx_trans_cfg,
 				      rx_parity_cfg, stop_bit_len);

base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.50.1 (Apple Git-155)

