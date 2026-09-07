Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147337E316
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802225; cv=none; b=DAYv9CYVD8AlYLxbvKdgwzfUCCCpSw9urOWGXTXJcvBGhZmjs+9D8IMrV2jKvKiio0iAnVQbjFcU1kY6de9VTbip0d6NkYoIvYqwkQDvdhPujZIuWD/yzH6O0QtAP1O6qn0rzyXwFkEBETCUUZ3KX84ZjoU6s4GgLGAyFv4nhd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802225; c=relaxed/simple;
	bh=T4JwvNiKyKe1vIFy4XFJVYqOHV8iMgDhRVjX5xCltyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q2HLLmnRM/7cdAZEPe799ys9Kt2aY1+d9xl6DkuCbzuhfJ/dIXmcnwgL8T1T5L19P8XCYpIz2NP5VoJq2CDv+X9GeiP5EGL+KMGKX/vvZObwitFnjTH7QW+Z9Zb9AxStyidvGcd8dTM49PKIGH7e52nNaffkhn6e2DPMkycrR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa8rSJVC; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa8rSJVC"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so1969295e9.1
        for <linux-serial@vger.kernel.org>; Mon, 07 Sep 2026 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788802222; x=1789407022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZ86GWxn7cMIjKY1gWNPGGldMktBFPiJBaQxAJalFVE=;
        b=Fa8rSJVCRDbKIO7HtKyTbp3hkSDzb9J8FtTa55yjn6giHRgN2Y/ubgNFJ6m4D355hZ
         tDskQGq+j0imtotHytqjKyUeIMM/upinoKiqQXmv9yv4e8xSHytRxha+CcpWNpnJdDuk
         CG1ytZofHnv6vBgpVg0LH8eCPokiDIrHviI0dvDW5lDmQIW5TwYPO2YW1QWYQbBae9jv
         isPCiUVeZ6DXhrhbwg2iyz/21weuHSYdtTU5yhigxdFEUSldyDSnqcSu/EFcZ40aSCV+
         FpBqYl+E7F+FB2bd+p1swrxWWd7AHMDCfuKDa3CmlkUsmbQaM1qZTdR35cp/tnuBPq/N
         3fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788802222; x=1789407022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZ86GWxn7cMIjKY1gWNPGGldMktBFPiJBaQxAJalFVE=;
        b=tDX0wK9+YD5rLH+t6S2JZ0HrfZ/ZU/aWpt4m3yhNg9INogp/f+Ol01bK58cyBLUrY8
         Me5Z3sITQF59fhJjZth+5ClhNjAO3qeosQXUflX4KGKJO9MlA8z12xTip76amhpYzMhz
         ji+EOyUuu6/Mqas5kAj5L5xdUK7FwQw3E+m7plw6j27d+5O9Be7kNVw85F4xDsSEGBqg
         4OIl3pw4CMeWItjZYvisqeMfoY32GB4ahmzVDX4GaQOwuqeThinSKRAVQaeC24IAsc1M
         bcACAq+q3YYx+1zw+sPw11IhbdzQaQ/o7t68YLiaTLXlFXviwn5PrULfg7L4vaxCM29P
         aISQ==
X-Gm-Message-State: AFuF++kjsu0DhV7MhqdzHJKARg5F5I5MkNUj2ivWTb6LFX13QC49nsLU
	ypE2+wglnebTejGIOIvSpies+m8gzj+PcbGNUK81SO9mEYVBt9t8Mvp/z70YXNO6HHw=
X-Gm-Gg: AYBFou0cxkZbmOUVqYP8H1C8gTxD6a1lfRh5l4XN3QcfRjiYnLHCnaiP0XYlVD6VTCc
	53m6IoPSsx9QMBTeePTK+OeJgTzkvYRqEW5hjvg3EnBtotn5ezJDHoAi0jFdcV7XskjeF0d1AjP
	fzWrLEQksVYTMvOz748jVKt36uInZhELOu40yt9UymQC791evCQh+doG/JHtlIW+N1XWj3RVj9r
	JB7yMcMZJ7DeK/X0cB8D9eOn8ngGlqbuT/fU6KUA/EAmk1MrD4CIL9/VSiIVwaowZWPB6aGE/hp
	7dD/Nkjbohnt4Qy2CUUq/gh7JT7EQFqaZyyixuIeh0INAMsvTe/5VVUft9iAes6CkG26TnScqZq
	aj/rZEopQL6aLEjpO7Q7MjegtMOfq28RDzDlHaGZsGGuZn2GQoma3RG/nNP96KH0PYu7mZswDyE
	t5xFIbLZTtMGJRYtq5kGFcBzm+pQqvQbqhYkIEaQGESWkDlK4oEuyXtxYzOwNqwiTDFePEXcBEj
	Jap5t63tuSGMiBFYwkGt0NNd/ie0vGZR/zextTxtBI8VZEaQIFkC9BTtkhKntkap3zsLr5mSgSj
	d2I=
X-Received: by 2002:a05:600c:4fd6:b0:49b:4eb6:6ffd with SMTP id 5b1f17b1804b1-49d1754ecbfmr25475085e9.5.1788802221462;
        Mon, 07 Sep 2026 10:30:21 -0700 (PDT)
Received: from MYL150-3871.localdomain (80.151.89.79.rev.sfr.net. [79.89.151.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm444595195e9.14.2026.09.07.10.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 10:30:21 -0700 (PDT)
From: Nicolas Thibert <nithibert@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_of: set UART_CAP_NOTEMT for rts-gpios RS485 direction
Date: Mon,  7 Sep 2026 19:30:00 +0200
Message-Id: <20260907173000.1254045-1-nithibert@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__stop_tx() (8250_port.c) only calls the RS485 rs485_stop_tx() hook
(which de-asserts the direction GPIO/RTS line) once it has observed
both UART_LSR_THRE and UART_LSR_TEMT for the last byte. If TEMT is
never seen and the driver hasn't set UART_CAP_NOTEMT, the function
returns without scheduling any retry -- the direction line is left
asserted (driver enabled) forever, with nothing to un-stick it short
of another kernel-visible LSR event.

of_platform_serial_setup()/of_platform_serial_probe() unconditionally
wire up the generic em485 GPIO-RTS RS485 support
(rs485_config/rs485_start_tx/rs485_stop_tx) for every port they
register, but never set UART_CAP_NOTEMT, so any board using this
driver whose 16550-compatible core doesn't reliably surface TEMT for
its shift register hits the stuck-direction-GPIO case above.

Confirmed live on an ath79 QCA9531 board (SoC-internal ns16550a-
compatible UART, RS485 transceiver DE/RE tied together on a GPIO via
rts-gpios, linux,rs485-enabled-at-boot-time): the direction GPIO
correctly asserts for the duration of a transmit, but never
de-asserts afterwards -- confirmed by sampling the GPIO's debugfs
state through and after a multi-hundred-byte write, on both the first
transmit and repeated back-to-back transmits. Setting
UART_CAP_NOTEMT, which makes __stop_tx() fall back to a frame-time-
based timer instead of waiting indefinitely on TEMT, makes the
direction GPIO reliably return low right after each transmit
completes.

Scope the fix to ports that declare a GPIO-controlled direction line
(rts-gpios), rather than setting it unconditionally for every port
this driver registers: this is the class of hardware actually
affected (RTS state has to be explicitly un-stuck by software, unlike
a UART's native RTS pin), and it avoids adding the extra frame-time
margin to ports relying on the native RTS pin, which this has not
been observed to need.

Set it in of_platform_serial_probe(), after the existing
"if (port8250.port.fifosize) port8250.capabilities = UART_CAP_FIFO;"
assignment, rather than in of_platform_serial_setup(): that later
plain assignment (not "|=") unconditionally overwrites
port8250.capabilities on any port whose "fifo-size" DT property is
set, silently discarding a capability bit set earlier in setup(). Not
observed on the reporter's own board (it has no "fifo-size" property,
so port.fifosize stays 0 and that assignment is skipped), but a real
regression waiting to happen on any other of_platform_serial user
that does set "fifo-size" -- which is a common, documented property
for this binding.

Signed-off-by: Nicolas Thibert <nithibert@gmail.com>
Assisted-by: LLM (Claude Sonnet 5, Anthropic)
---
 drivers/tty/serial/8250/8250_of.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -233,6 +233,24 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 			&port8250.overrun_backoff_time_ms) != 0)
 		port8250.overrun_backoff_time_ms = 0;

+	/*
+	 * This generic driver never enables a dedicated line-status
+	 * interrupt on TEMT, so for ports whose RS485 direction is
+	 * controlled via a GPIO (rts-gpios) rather than the native RTS
+	 * pin, __stop_tx() (8250_port.c) can see THRE without TEMT on the
+	 * last byte and bail out without ever retrying -- leaving the
+	 * direction GPIO stuck asserted after the last byte sent, on
+	 * hardware whose shift register doesn't reliably surface TEMT.
+	 * UART_CAP_NOTEMT makes it fall back to a frame-time-based timer
+	 * instead of waiting on that interrupt. Scoped to rts-gpios users
+	 * only, to avoid changing timing for ports relying on the native
+	 * RTS pin, which this has not been observed to affect. Set here,
+	 * after the fifosize-based capabilities assignment above, so it
+	 * isn't clobbered by it.
+	 */
+	if (of_property_present(ofdev->dev.of_node, "rts-gpios"))
+		port8250.capabilities |= UART_CAP_NOTEMT;
+
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
 		goto err_dispose;
