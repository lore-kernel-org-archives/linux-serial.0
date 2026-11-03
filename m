Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742027;
	b=Yair1N8luCjzHEXmkY3/edgqKJyMD3aEDqzz5Ibt5ifkhKTYeGsoXlEH3mTsI0z33H60
	 8dGhqHJLxva6MBR+Pk+vK1kJ5jfiEsz50XFI/64ULXcwDOVNPOe4+RfTMYNkCT2IBIgqu
	 JEjizXA6ZDZxQygvhCuFxyQJii+QfxUBYILwQ5pYkyeRHgalVAJ8iAklL/0qgjZqDTNt9
	 ZTM+aiX+QGZjnEQvMJZtYcHgY8JOfmrK5io9nEnhv4R2JOI0+YlgQaauA517+1b88+dll
	 WXyDV2zrv6gEQ1g2urU6Q7M54aFKEt2olEj0ZI234up5lg+h2vK39AYrmSBXCnK1elQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mOkByMgIh23Ng8hqFybijqEgXApYqjm77yLCSksIVRY=;
	b=PwXGEIR9uYjAu1s77p3s7L13bxqXdZfd27Y7BQpS3RaT4i2ce1+2SXfvE/nr/8tqt5T1
	 LDlvgvhJj1a2Kp5onHuOKzkKHWw/WtPkA1jsj4UO9T74DLh43DSDX3ZcuFkSRNprmQiCY
	 gYYZW75ngDDoJ7RPWvLZUDqvhgZbwPsld/12b3KoYIFvTGsZBAHZoKWCnQJOauYOoVQcm
	 lluQa3bvToKjZOLRhrw/K4L/sEHgI9hMUj9WGef2fj1TlI6zZFf98X1yLyaTIDdwj0xGk
	 wyE9DV1uKmIn0qUhJIJP56cjOOJZMkgs0oZqkr//fRbUb6FgijfXwxe7XwiS4Ojz1/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFLvV7bA;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB98606D824
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEB98606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFLvV7bA
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-49429181ce9so85627fac.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742016; x=1794346816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOkByMgIh23Ng8hqFybijqEgXApYqjm77yLCSksIVRY=;
        b=sFLvV7bAzag1vYgLE7r3IClkNio+bXOGyLaCZZ81DIBvXxYfwXfCkclh8gWnL5R7jP
         9BjpSaSI8/+84hfPSLqOFQJd8NtyELFUk23sz+5qwY1ACqlEwVvhQHt6o1zIg2jF7+/K
         MpanQmWTU0lwAl2dT3/26MuELDNzs2XHGn8hT+yfPdQ0B5YMiILqA9nnjUh2+IGhtJyc
         mcaHevY+CjZnH0cpgMyIH+564zqEqdHK7aRprIgzBt46uKB3Ls+mK1gBsyxhtSbWnvJh
         YK7+PGuj3B9J9Dopd4a0McOhHzOEbKhmGXjp3OTMy10ZT22kVsaIR7lZ1+MJTPtSK97v
         ub2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742016; x=1794346816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOkByMgIh23Ng8hqFybijqEgXApYqjm77yLCSksIVRY=;
        b=CklNy5hFM2K+Y99pqIb1PZ+dJGKMqKxEupRSVBxFt13DfLIo41d/0LotVlx8Ja+BiB
         qbxX/ITrR5/HzQmskZtwcNQ0lTcSa4+MjTTs3Jo8eBdzVIirtQoTEAB4UJ/R5fuLgYxm
         U2sdq5/k94a52rWRDUHGyg0HgZzQ72OvqFk5fbCVLJolS4oM55nr43XeaZ9rGOcGgC0+
         TCNBfUrk2uKD/VZySmp5/ulM5BPu2wClD2yx1kEUok3xB64egAKuQchaZSiARYSHximw
         Z1GJNNBoS7Nx/LTuKhqNX6lBWKomWAyv6Kbsu/v1J1O40q6jqGqAFmd9DSubxqfQkdm+
         1hcg==
X-Forwarded-Encrypted: i=1; AKwUvBw+QCtwz+wTp6PjPnUIfM9JOt6Kfgd8oqj4QA6xSCnENpKemfe/vW3Ylxdju7oZhP/1gfW9gf8eX3HduYs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fMxzg5o0GMIdxepIyLO44jyy4/rqhn5eOo/YlcW8oDKjJkRWz
	QgV3rPvi3+07nRB0AAQQLIw75NJU93MNPM35bIT9zhA6ynNcUycyYXeckckyJXuP
X-Gm-Gg: AYBFou0yVSg3Cv0sjfReTkMM6L1sfje8BT3/3xk5P1/EEWOFTOlF+DQM9Hjhi4OnRWX
	kKFm6NJVxHAsbdyDXizJiuOT/DEJCuD1xcPjafqVVfWnKgVhg5D0zjYsyTeP/lrzi+qD/uKWiOO
	gwGUAb9ohlG4S1xjiOKp4j270BZrt6OKMgF/kbmJmzl4a9uPce/8OrsH32VBFsMca60/QeSIiPr
	BKArQn4h7q7qLEHo63m+W+aGembPuIXq1NbJ6eQ5lS9M9hfvm5hfomE+P8Ds4oaGerSnOxqkhPp
	lunle2u+3ENiSPzuxYFMQyLY4fdJZdgi7+LCmVJ2pkbQ2SEVa6kMJsc4HA+b/wXAYQcjRij3RSB
	vVnfk3JpYIfmFTsG6zeLvy4fjc2A0V2yve6Htv1zkBypCrON8XRtOApLWzp03Liah8UST3CUsGp
	QdKl6dB4wz/vH9uxY47CYFZiVd7bUfdaNJVtyNd9Udm9tXMcBj2b9N+IE97bPAHmeDqWEUjkTwR
	wyeo9WEzL3tmIzPaOkss6tVpDTXA5sjRACy0IM7mh524DJU6ZlrkALO61fB0ZCdYEA0jqhovWM9
	I/Bd+bOAXDIOScPIGCTl/AgImIZzcO93QB7fQDf8PFzX+xj+PL/wl6Tww+sT2wEcxWhqQ/F22jt
	fADFETeq0GNEdtJEA8j5irKkNoFs/EFI7yD8Tyil0uUCLMR4n79gu3QQbbG9jUeLvl1sN8UcOGl
	y92hx46iCNas3X9AYLwlA5wkOdtLL9TOicWMEsrPuYVSIW18jcj/b/
X-Received: by 2002:a05:6808:151f:b0:53a:e153:e8e6 with SMTP id 5614622812f47-5640de7d903mr9983750b6e.59.1793742015715;
        Tue, 03 Nov 2026 13:40:15 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:40:03 -0700
Subject: [PATCH v7 10/12] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-10-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The A523 UART integration, also used by A527 and T527, has 64-byte FIFOs
on UART0 and 128-byte FIFOs on UART1 through UART7. Each controller reports
its TX/RX FIFO depth in bits 31:8 of the FIFO Clock Control register at
offset 0xf0. The field holds a byte count, not a logarithmic encoding.

Read this field in the sunxi setup callback when platform data does not
provide a fixed FIFO size. A fixed size takes precedence, so H616 retains
its 256-byte configuration without accessing FCC. The probe has already
enabled the clocks and deasserted reset before invoking the callback.
Leave the FIFO clock-control bits untouched.

Use the shared DesignWare trigger setup to validate the depth and build
the FIFO-relative threshold table. Invalid depths fail probe before
registration instead of producing zero or truncated thresholds. The 8250
core derives the transmit load from the discovered depth.

Select this setup for the A523 compatible. Like H616, this integration
has Allwinner-specific debug-divisor and RS485 registers overlapping the
generic DesignWare feature probes. Use the common sunxi PIO setup,
BUSY-safe integer divisor programming and software RS485 handling. Keep
the APB clock gate enabled during termios updates with SKIP_SET_RATE.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0e7367ba872e..cdd3a62dfa7e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -44,6 +44,10 @@
 #define RZN1_UART_xDMACR_8_WORD_BURST	(2 << 1)
 #define RZN1_UART_xDMACR_BLK_SZ(x)	((x) << 3)
 
+/* Allwinner FIFO Clock Control register */
+#define SUNXI_UART_FCC			0xf0
+#define SUNXI_UART_FCC_FIFO_DEPTH		GENMASK(31, 8)
+
 /* Quirks */
 #define DW_UART_QUIRK_OCTEON		BIT(0)
 #define DW_UART_QUIRK_ARMADA_38X	BIT(1)
@@ -63,6 +67,7 @@
 struct dw8250_platform_data {
 	u8 usr_reg;
 	u32 cpr_value;
+	/* Fixed FIFO depth; zero selects discovery during setup */
 	unsigned int fifo_size;
 	unsigned int quirks;
 	int (*setup)(struct uart_port *p);
@@ -666,7 +671,13 @@ static int dw8250_sunxi_setup(struct uart_port *p)
 
 	p->type = PORT_16550A;
 	p->flags |= UPF_FIXED_TYPE;
-	p->fifosize = data->pdata->fifo_size;
+	if (data->pdata->fifo_size) {
+		p->fifosize = data->pdata->fifo_size;
+	} else {
+		u32 fcc = dw8250_readl_ext(p, SUNXI_UART_FCC);
+
+		p->fifosize = FIELD_GET(SUNXI_UART_FCC_FIFO_DEPTH, fcc);
+	}
 	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;
 
 	ret = dw8250_setup_rxtrig(p);
@@ -912,6 +923,12 @@ static const struct dw8250_platform_data dw8250_h616_data = {
 	.setup = dw8250_sunxi_setup,
 };
 
+static const struct dw8250_platform_data dw8250_a523_data = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
+	.setup = dw8250_sunxi_setup,
+};
+
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
 	.quirks = DW_UART_QUIRK_OCTEON,
@@ -964,6 +981,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "allwinner,sun50i-h616-uart", .data = &dw8250_h616_data },
+	{ .compatible = "allwinner,sun55i-a523-uart", .data = &dw8250_a523_data },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },

-- 
2.53.0

