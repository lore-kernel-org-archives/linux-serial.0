Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873359;
	b=rxx8OkI0WvJtnoh+MPeMxCnxRgpom5A3jrQbce0p3mdkh4tNVvNAFoWNSSP1VdLaVvuq
	 +8SMC9yVU6iAkgjg6/SbPoF/5Q6VyCUosn8k3oDdyFddLcRshGTdTapJNnsUaae18WZdr
	 RnUyevFaJiaFq/aV6XY3Anygq+kPCJik+GE4LlpKOAgWMvD/3LUxRV04n7QnKPPktSMWp
	 EqumqoOsywmlrBpP7fkDfgaNYV8PWQjCSnEevSg/BbxR5EBQIVRm0Vn0/H0cT91UJbViC
	 bNUrA2fb6oFYfaTemP/1Y+vPFRA2XEL0yU1+TWKGRZ/Rl2/d4T+5dEKzeVUbwVcfadA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=quBdTCWmyLOutiiqlKg+zE0eUur6E5vFRS0ZQQJBF/Y=;
	b=Q1R3EqF1fZXSxt8qKPjV+v+XOD+O1NvZ/agCUrnO05ahrnuQvuZ2oKJX2x8eBALgkCIK
	 yBYixAUiTewWzAf89OFBfYDdm6Z6+DeimOfTpttIec31zWAU0c/UUAN7te/65iUYUpi83
	 hk+Cs4qLFZsDRIfk7pKKaRaMHGe/3C5fLIop+p6m7rpkMvXZzbepbF5q1pL2LdjLjAUya
	 RmDOhcIOkPuraMPKRK7r/dMuyAoPO+eijRo+d852Gz1rBviOVAXLE4vEjaTFC8CUeyAm2
	 Hh4KdJfTGam3kxgVZP1qFQMQYgziGteAjarhJxEA0PC+/qsVKKP0Aj5XYbhMSJ/vbFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TaMzDOtb;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413F60A261C
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4413F60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TaMzDOtb
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-823b938464fso1395824a34.2
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792873358; x=1793478158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quBdTCWmyLOutiiqlKg+zE0eUur6E5vFRS0ZQQJBF/Y=;
        b=TaMzDOtbipq3H0hMxrTqLEGpvgLxunR40KiGs827LUA4QZZMMUolHwo+b4Fgo1gjoN
         HBYyl7hhKUNJC8hXczwBGPkSvfDuUva7TPoxIlWAY9Fbu9UKBtYr0k1oC7q3hvI+IGyS
         tZex8M27oBhp/SqxZxhUelQ+zdb7oX/tK7enj3VgvblWFCiUVczdOD47tmbfV3Vn+mNu
         c+vLcma9+71iaRPITXF4kraotzk31MUiTxf69nioako7JvHo2dtV+nLqlcsay0FpxSpA
         adOjC1splw50rM1yNvw70nQdwH9pdc5Fii4H6vI4tkRX8YXfk1QpP89JSMdIwFE8RSNr
         ixbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792873358; x=1793478158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=quBdTCWmyLOutiiqlKg+zE0eUur6E5vFRS0ZQQJBF/Y=;
        b=VktSvkrswWFkYoik9VlgRKUMFMZvMwy9Vei4msHHGbfqyUlH74YPmgvWBMVPHM6b2n
         HZ1AKJUmr/y2tHE+C7DP4w/TzmLM5nrAish52pUpTY/NyFuln6oNzvKAndRBpMMGDcYj
         pJpbkr1K4T0unzUDf9v80qu0XXiz34FeX/VIJQHboz8vLUBcVqVanW0nsNs+HThf8XnU
         dOADasUtl0b1OYf6eehh2o6TBwWus4CCV1gB5kiX22u0bwAQWAudUn1iNduQfIh/r45b
         phh+dbLl3yP4MAbBnDnpQARlff1464/Hhoz61Y31ZgTgI3YVQS2J2BaOF8BzmZkAXlfe
         IEHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIYvAfYop43ED3LhXA8vOVwKWG+wsnHNTNcD+jaZyHfEqRpMxQDUXDj4x4HCZad9bH/FA4a67tKgcJp6s=@vger.kernel.org
X-Gm-Message-State: AFq9FYImf3vPK16hrssyyRFHNlGY8bI9p+OcOjZlfrrXlod7Il2vU6Av
	lPpKHTQ6+pE8UIRR844JJBUVWIUB6uUhFIjUKyfnY1Xn2cdfHMhybrIb
X-Gm-Gg: AYBFou38v28iB51L5Q2SWOmrTW7Vb44YnrQHkedB12WsBFS9RyrKFrtQfXjXz0eC8iA
	+RyezrUJO21vqzh2XCMi9WtrKNraWdb0awiroGNdurYBSXJXLKCgjEDTXf2fM2sGiHGsB3tqOfW
	ETslzsjLcXlF9w/xHicW0SUbftmT4VTVWfHW/pBGkcs+K5ajXWym8XfvrgdaqlVOzIcA6M4ujLG
	QJC/j32Wt1U1TB0xZCaE26fY7T8nOUpT5J0p8UCDlI34Xpz8hTv0nTPPXl7k/GjBRlfuchwkHi0
	eRvmw8yIVx3E8iB85ZQvfWL6MZpoGNtAZgFNK4d+cg74xgSe2solBeVy0CkIcI74C/8Xxjd0qEU
	ij8/6d+3CaP+snh/3WKbe5VJVxd//IHToUNNkFNHafNCWxLjOpEvSrbTJtbNKTV0CucXAAtbF3T
	v7bggskBgTvX5Int7ER5mk4XI8+4lYmkDG9XLZ5MS1spd/vwbwRtMEpYHbKcvtxt19hics2y3kv
	hnY79uJm6FPcWKNFzk0uJGVKL7LaF+JkiqWR/IT7shi6Lx/N9rcJjm4vADLf1HeN0qtBtuEElnb
	fAIjlzYaFFPG3sAy17Z5BWabsRZ2axIQQQgN+t/bV4ArKNjJ19cZ77YiKBQmQVX1u4GGQWbaB6I
	GYJ5Los9LiVh969IMQJiDMBMD7eDQRGg8xGcelwFTtGFoS3rX+dT6PcOatpemyKh5W7z6stEIbC
	6Q6omGF3uyR1YcwYAHSXt6BMUX
X-Received: by 2002:a05:6808:1982:b0:4f4:3790:65fd with SMTP id 5614622812f47-55c002b7e97mr1918256b6e.29.1792873358250;
        Sat, 24 Oct 2026 13:22:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0424775dsm1815063b6e.5.2026.10.24.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:22:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 14:22:25 -0600
Subject: [PATCH v3 3/4] serial: 8250_dw: configure the Allwinner H616 UART
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-h616-uart-fifo-v1-v3-3-286fc1b8c3c1@gmail.com>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
component parameter register reads as zero. Generic 16550 probing leaves
the port using the 16-byte FIFO configuration and its trigger-level table.

Keep PORT_16550A and preserve the FIFO size read from firmware by
uart_read_port_properties(). Use it for the transmit load and derive the
receive thresholds from the documented 1-byte, quarter-full, half-full
and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 128 and 254
bytes; the normal 16550A half-full FCR setting selects 128 bytes.

Serialize trigger changes with termios and hold a runtime PM reference
while programming FCR, preserving the FIFO contents. Propagate runtime
resume errors before changing either the FCR shadow or the hardware.

Advertise automatic flow control so CRTSCTS enables MCR.AFCE. The
DesignWare termios path selects hardware CTS handling, so the capability
must be present for the corresponding hardware control to be enabled.

Select the fixed configuration through the platform setup callback.
H616 has debug-divisor and RS485 control registers at the offsets used to
detect DesignWare hardware RS485 and fractional-divisor support. Avoid
those probes and retain the BUSY-safe integer divisor hook and software
RS485 handling.

Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled during
termios changes. Its clock is a gate on the shared APB2 source, rather than
an independent baud-rate generator.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 75 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 9c171c5775a6..557832254c37 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/lockdep.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -648,6 +649,73 @@ static void dw8250_setup(struct uart_port *p)
 	dw8250_setup_dma(p);
 }
 
+static unsigned int dw8250_sunxi_rxtrig_bytes(struct uart_port *p, unsigned int trigger)
+{
+	switch (trigger) {
+	case 0:
+		return 1;
+	case 1:
+		return p->fifosize / 4;
+	case 2:
+		return p->fifosize / 2;
+	default:
+		return p->fifosize - 2;
+	}
+}
+
+static int dw8250_sunxi_get_rxtrig(struct uart_port *p)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	guard(uart_port_lock_irqsave)(p);
+
+	return dw8250_sunxi_rxtrig_bytes(p, UART_FCR_R_TRIG_BITS(up->fcr));
+}
+
+static int dw8250_sunxi_set_rxtrig(struct uart_port *p, unsigned char bytes)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	unsigned int i;
+	int ret;
+
+	/* Use the nearest lower threshold, as the generic 8250 implementation does. */
+	for (i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++)
+		if (bytes < dw8250_sunxi_rxtrig_bytes(p, i))
+			break;
+
+	guard(mutex)(&p->state->port.mutex);
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(p->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(uart_port_lock_irqsave)(p);
+
+	up->fcr &= ~UART_FCR_TRIGGER_MASK;
+	up->fcr |= (i - 1) << UART_FCR_R_TRIG_SHIFT;
+	/* Changing the trigger alone preserves the FIFO contents. */
+	serial_port_out(p, UART_FCR, up->fcr);
+
+	return 0;
+}
+
+static void dw8250_h616_setup(struct uart_port *p)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	p->type = PORT_16550A;
+	p->flags |= UPF_FIXED_TYPE;
+	up->tx_loadsz = p->fifosize;
+	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;
+	p->get_rxtrig = dw8250_sunxi_get_rxtrig;
+	p->set_rxtrig = dw8250_sunxi_set_rxtrig;
+	p->rs485_config = serial8250_em485_config;
+	p->rs485_supported = serial8250_em485_supported;
+	up->rs485_start_tx = serial8250_em485_start_tx;
+	up->rs485_stop_tx = serial8250_em485_stop_tx;
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -870,6 +938,12 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
 	.setup = dw8250_setup,
 };
 
+static const struct dw8250_platform_data dw8250_h616_data = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
+	.setup = dw8250_h616_setup,
+};
+
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
 	.quirks = DW_UART_QUIRK_OCTEON,
@@ -931,6 +1005,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
 
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
+	{ .compatible = "allwinner,sun50i-h616-uart", .data = &dw8250_h616_data },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },

-- 
2.53.0

