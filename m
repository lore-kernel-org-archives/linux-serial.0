Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280404;
	b=d0XoPvLcTQRb9fC+9UEgcvzYFvlF9uu901I32ggcFWIVwXk0tVNGhZ/hQLLOsKJsXAZ1
	 1N7Q4bsW5XxXt553sL5jBPWsSHIDpqo8P9TBixTgYjVbeWU/kAOCBmFMOxmyMfJ1ZpGkW
	 pRT40WS7Th140NLhWoTJFfiRFCRSKSDbtLn8sL7Va5Pxan09uoGtCmifZ4eQh4bNBlCSI
	 S6nVXPEnTfP0TgzjS1+YoqL6q5FT05cF/5G6Qb3sEvZM4caxytgrMBvi6F3EKLJ6uYJAX
	 GlE4vk25tImnKG1NpKv1cN0ghua5tw8E8PmoIBeDki+31EXQ+H0NR5EdKbK1ir3YFkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mY44dbM5nzrkV+ospj+zR69jcUle+qy1oJf0Y3qvlKo=;
	b=pw1PFrlRSOHr5Js9trJqRUuF/L45n5wL1VpDXtBLfNvYkn+XohwsBlErCz7q4UhG+ZLM
	 x1KMIAW6bQ9NU49iE2u0MIZzMI6HuQqCx5nC5gFGLkvQNlKV8D+m31A2g5XLDgIyZVs7R
	 PRaq+hEf4M3i9TD6DwuUqmjKjYxF5txhuHJMY3Wge1CgqO8P264QwdGDvADTlA+hBfmEc
	 dOmWzYfpzCVPb5rwwkwKtQWe18P9Wry37XgPqikQq7V5YyniFxbSrjD4owQVKNuEsYjVf
	 HXHLPSYt0jxSND/GzEZnhV68kaG2HREAgk/xrilcW/E+8T8qQWP7qSxlAjc80riaOZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCOnKty6;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4E60A382D
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE4E60A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCOnKty6
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4ad5b52f0a7so1022789fac.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 19:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280402; x=1794885202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mY44dbM5nzrkV+ospj+zR69jcUle+qy1oJf0Y3qvlKo=;
        b=yCOnKty6hdBhf+bKkL5BUk4AeE71P+hLnnxhgDgjhgbzFZt1gNESxsxF0nHlGGB5dn
         fwLKAI2QtUQP17yDt/KGUt7s7VbScV/AInTMYFfamgja3mxDzBw4Mz0GoH8+tDY6TFru
         RiWX4RG3was+y4F+Vy44Y/uKO+aRvuR774odk3nPYGOVQBGPotesJqBJl5EDSuw2Jx00
         BDkzibbNnNo8XdEnMh8+V3AOcuXQQ5LbxA72tBgvXsrEwSRxUzLLcQVhUAvEDXLHgbUS
         A3/euxvttq5fY6aU76WwRrOFNVQ5d8VK3iNn/apW+lZXHtbCgOeoWdiy8BuvMCUXVvAb
         bQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280402; x=1794885202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mY44dbM5nzrkV+ospj+zR69jcUle+qy1oJf0Y3qvlKo=;
        b=W4LaFSstcUiWOmzp93J7LtuEqm3fHPG9Qm2tOIHcsp4tOSgi+5Q4OXGTopn8GkOF/F
         XIDOu4RL35GrV4XzYvtamBPx0scfrRUnnn03VJ56mdDoAnMjIiAcJDvVB/76XgtLBcXn
         JX8JRkX1eRGpnqF08j7tMv1/+isnqIXU9Y0ODflksRQb9p936OYz+6L+yHGpCdQraRg6
         sPa+hhoN/rPGDV0ypyyANslz8GyAIt7fDYstjAtu1YuckLVHO6+8jvhLOCAqU5OCnKnl
         becTuWfU8BeDrebBFTFeUTc55iksmg5dfxI6hcLNW/Zncw5v73Dsg26txRkOEWqOKzuN
         mr1Q==
X-Forwarded-Encrypted: i=1; AL+hErE+rPSKV08e9pOIJfd+gnmRgoT20C82y3qWqCtcUN1YJA48CHZ3FhDyUBLw7nMfXuRcI72zP0XVL38mp0E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JOYpmkLobfSvIrqAEAHPdSzlhsQD234AefHBjVgPl6bGdm4GT
	La9HvQp8q952oRemsBVi8jKl05FQ0f+yNudf8la61W9znGF3GCPWyPZX
X-Gm-Gg: AYBFou0UU9kcsmauKfKNZXqxSzFlPTUV3/yRU69/Wjy1ZysMJ/6P9kltqBTeMyjSS/3
	n4oVip7/CtgCiwBK5hhUD/tUfCGKvBqvY1TVor2atYQ4e4h7ZW+0o+NWYmdY11mMvmLczWhoRnt
	QKNoa6hPbFvI/VGxCOFxsjGY4bwvFyH0WCOpVHtdz9jeW/VvUT7q28UL4TrqwBH9xUPKZMGom1Y
	1Q9k7DV/Q5L8tkf5oC1ngBme0idju6ImH6u/NbGVhvgvWA7qmC/ZTDlNfFymPPr7SmB7AIW0hyB
	2k46A6g/iU6CkX1YkMh1dqNxsElpw1fhsJazOB9Hl0L/aWJUmp2YzFlnUlYMYKXgp9JwtQKeGf/
	YDj7huM+BcJx/1tCASUAjHvchUJHpNdq9RS7W9QPOoKfPJ+jhZKSo83WvslWRIGBbDYYpQWWgnV
	OhZcPDhimb+8eqjGuDOrWE7qfKjBfXpqcuUW7/o5b9T8u/J358Rns6HZE5m6dR/Kvw6VQJox9yh
	b/Blfd53qGIC6q2V20rieXeblLrsFmCAL+78DYTTWwBXHaEFXcuA97/L3fZhNO9fvM0I4jltnUQ
	EXwQ/pfvnc7A7BgfH3h2DoDFV2sYyKbBjmZsXwI+pMLtABfYb0xN7h5jB1r41qeGBGZ6y5kQV9/
	4YPcn17F0bqJLk9nIg9PFG2yBN8RknyoR9ZecqTU4SYXveRd/HQhSCRSrPQbhMtMAFCUPKfccnh
	W2Aosa5zR/FIrQKZukhQnfyAg9dgYSPiXlQ8Tj9iOCI5bNmlnOOa0YOKARSnSXetLtC45QtMqBi
	g==
X-Received: by 2002:a05:6808:1713:b0:510:7dc8:5ff7 with SMTP id 5614622812f47-5683c945eb5mr1088933b6e.19.1794280402120;
        Mon, 09 Nov 2026 19:13:22 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905736b92sm1019236b6e.8.2026.11.09.19.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:13:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:12:57 -0700
Subject: [PATCH v9 08/11] serial: 8250_dw: configure the Allwinner H616
 UART
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
Message-Id: <20261109-submit-h616-uart-fifo-v1-v9-8-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
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

H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
component parameter register reads as zero. Generic 16550 probing leaves
the port using the 16-byte FIFO configuration and its trigger-level table.

Keep PORT_16550A and supply the fixed FIFO depth through platform data.
The 8250 core derives the transmit load from that depth. Use the shared
DesignWare receive-trigger setup to describe the 1, 64, 128 and 254-byte
thresholds, with the normal half-full FCR setting selecting 128 bytes.

Advertise automatic flow control so CRTSCTS enables MCR.AFCE, matching the
DesignWare termios path for hardware CTS handling.

Select this configuration through the platform setup callback. H616
has debug-divisor and RS485 control registers overlapping the optional
DesignWare feature probes. Use the fixed configuration with BUSY-safe
integer divisor programming and software RS485 handling.

Keep the UART clock enabled during termios changes with SKIP_SET_RATE.
Its clock is a gate on the shared APB2 source rather than an independent
baud-rate generator.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 613907b8a40f..a55f60330a51 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -63,6 +63,7 @@
 struct dw8250_platform_data {
 	u8 usr_reg;
 	u32 cpr_value;
+	unsigned int fifo_size;
 	unsigned int quirks;
 	int (*setup)(struct uart_port *p);
 };
@@ -657,6 +658,31 @@ static int dw8250_setup(struct uart_port *p)
 	return dw8250_setup_dma(p);
 }
 
+static int dw8250_sunxi_setup(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int ret;
+
+	p->type = PORT_16550A;
+	p->flags |= UPF_FIXED_TYPE;
+	p->fifosize = data->pdata->fifo_size;
+
+	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;
+
+	ret = dw8250_setup_rxtrig(p);
+	if (ret)
+		return ret;
+
+	/* Use software RS485 with the Allwinner register layout */
+	p->rs485_config = serial8250_em485_config;
+	p->rs485_supported = serial8250_em485_supported;
+	up->rs485_start_tx = serial8250_em485_start_tx;
+	up->rs485_stop_tx = serial8250_em485_stop_tx;
+
+	return 0;
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -880,6 +906,13 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
 	.usr_reg = DW_UART_USR,
 };
 
+static const struct dw8250_platform_data dw8250_h616_data = {
+	.usr_reg = DW_UART_USR,
+	.fifo_size = 256,
+	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
+	.setup = dw8250_sunxi_setup,
+};
+
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
 	.quirks = DW_UART_QUIRK_OCTEON,
@@ -931,6 +964,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
 
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
+	{ .compatible = "allwinner,sun50i-h616-uart", .data = &dw8250_h616_data },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },

-- 
2.53.0

