Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742013;
	b=xqlgBklypKVK/NBCFXFMBUwHOic1SGv4CCNfxU1swRYwL7BPgHi41AFLmJkworUezWFc
	 Fb/LLLRl6lraxecJyieqS1uAp7gZRmNVrdo2rPesOyb63J4TYBYilhZMbGbAm+RbL+iex
	 h5kGwNa8bOHmz3/sCiMkHhegOHhedUmE8jvJfyEE7BimwtbNDrZ6cPhK6whMPn58vjLIJ
	 VgLHdw4etNlSoDdjWFcYtSJ+zLLGLsp1FdWTdrXOwYqQD77GGuPJGNunA4g3x0HRqbiub
	 OZAA61Jedl8Rb1y6213emsWAVEKlF4zskyoHkMcNdcYyFg7w4liAnHUoKbKTcx6B/nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=JhZegKXTLoM0aFpusHdkE4137WJUIfV1PRTu3QP4cf8=;
	b=yk6i5bdjBASvMqav8gbw955C9rCOoM8zf/7agQ3b3EpM+tthSXit8AXT+Qkc8zsg+DZc
	 EJ7CEQ+PKhSDUr7gMkgGk679cHNB3eJGxFZDkOe6EXxLzrpsCyKUK3mM237UXNvbwWzj1
	 zZ2e2aCxYB9HWB2iybEYSCcAjcGn8NMU7wktjVzhuCURSYEEKEs9Ppy+tkD6TQ+D71wVn
	 3r9nxbFKTcuNRCTHn1v5Q4uuS4Ks4SO8x3gOE1aAuReiwdH5NPzanCXsmqNmAIkCTIaxw
	 yisfrUCEe9De2phNYj7G14kEtEm+Yg7qATn+TzTO9E4P9CbcSKkZMn91YW8BgfXZHcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByDFiXHV;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87200606D82D
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87200606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByDFiXHV
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-70059e4dab6so20977eaf.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742012; x=1794346812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhZegKXTLoM0aFpusHdkE4137WJUIfV1PRTu3QP4cf8=;
        b=ByDFiXHVwC84fNnosmmrBEsgMAb7JGd2Rw1dUQWMEBibv04/S7TBJszh2D+GBvnjq8
         hLJjJqS8hSUmq99vQjlYbIk7FHEaOeBdVqx+ZzugbERNMlDlQE4vJd7EbXsoPOM1I5Q/
         SOfd0G5dnm7xKIh8hEI+/m4qyqUWNxrqEBZ3NB3nQIcrrPr9C/rkQVo+T0JCNyfV40p1
         0gnDjXopkTAqxnjppYFBwvKn+84/VN1qLcWzx/9IOLZixJ+xjJnRgG/5LYMy4DlzMI/9
         yT4qVMsFKO9cIJMLMsA2csQpt4GTSRvf7ALP1izGBo5dKFMgypVGu9nazNI5I7Jn1bBc
         mlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742012; x=1794346812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JhZegKXTLoM0aFpusHdkE4137WJUIfV1PRTu3QP4cf8=;
        b=bgY3EXvOIHobDlikTSz7sb1D2vPaQDD69jUFhIvKo4dMWIOJ3NLCu7iKd0maExDYar
         A5oAXjDYlPtv24QXHMPve2hEqrZr6v4u2sM+BcJqLBU4OA+QRbIrmeQEWDfHQY9ZZc19
         UgrJbq5JX+FQympkjsYQZgHw5BCIPFzGPhyqYfWIYcn5raYaXQT5UJM4dUtGpBXl08up
         lkTmCR0sVpBnsD1jytDUgNDXNcWQ62MIQ2fsBrBcO8VCdC0AGNk+E6oLbUG0m01bK/Ay
         g0xdeCbfwQ/Zq/TUWBwGurzug5SUXGbPIP/oMSdaN8iuV82ioSUPAd7Ft+fKVuoXLPmP
         7zUg==
X-Forwarded-Encrypted: i=1; AKwUvBx9LnlNJ6O5J4GIqYQx1MvBdNevknOdXx9I8XCNVOQOY9R7K/t4lrXk3wUn5f2NO8WfzSD08qwjhwtx/h8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Gc4UbvHKtTOhFZ8GE/QnvoBFlyZZfySHMYzaa+g+G0T7chDxr
	SMuuaKXy/0QoQwDx+Bnv6WP5ZyRwFD93raVTDogSxYPNRZmGR6dAwprn6QWc+HJP
X-Gm-Gg: AYBFou3YdulB6E7maj/kYC2m/F0eVw6/735KzanV9lGDX3FE1fABcGIcRcLOcV6xxBV
	TWLr/vzsmPA17XIWBo98eaKTXU36yu8CmWIYXHxG/fOXDzptj72V4xHcFTRlAZVRZNrir/muOW8
	snbh1iFieygWmFeR1fejM9A8cAB+aY8o8FCWUKUjJNAJy5u+BpfuApl6ZyX1UcohmEAku0Q0B0h
	LMNHdxGGofitNOvvjRciMgjcdQPIdw8TpHZpKODKP0qhWQXAyzHaVAkGn7S51Erh3V/s+UBQ/NK
	m/jvUWbnvarSSvnEl7J326OUoljxRk5LcTUcC6vG5W3lz4th/mdNBqSdl7uDnru+EGIGJOZSxoB
	7MbmIz4AQOpuLHYwPsU3HxZp1IGXuC19CXT/8lBCawpMk1Vzyl/AKq3fIqovWD/SIVtDIiGwl1d
	fM1HDngnGIFFNZ4F9kC7fLnzqhAhSVIM656JGjh0XImVtlW7mFaYbgx2TELuB9+/wHMtd2sRTvn
	hmcyRkMip2pq47XtI8bzcCkkeVQrqkeVD16Bnb9yUI8ZfFD//JFFmSwyvfxxYvKJYeSO9Vlf6F6
	RR1jT7b7ss4fuqT2EhCBUHjTLn4KtWdvmKN7rb1wyUl4s34yETlVfEeQRd/HruSXox25/NxQcaO
	11lh4CUMI2fsPNjmJli58oykqxcGrpxFA75+qY5/LOfL2p/a675qpR3e2aO5rbQ3tRRBv2cgAYU
	+iaOFs0rax1Q30fXXaKeHcStyU2FcCPzIvDhPqa/IEE2kGxcp6sChy
X-Received: by 2002:a05:6808:191f:b0:4f4:3790:6615 with SMTP id 5614622812f47-5640deea416mr11125036b6e.11.1793742012357;
        Tue, 03 Nov 2026 13:40:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:40:00 -0700
Subject: [PATCH v7 07/12] serial: 8250_dw: configure the Allwinner H616
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-7-c9e248d685c1@gmail.com>
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
---
 drivers/tty/serial/8250/8250_dw.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 613907b8a40f..0e7367ba872e 100644
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
@@ -657,6 +658,30 @@ static int dw8250_setup(struct uart_port *p)
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
@@ -880,6 +905,13 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
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
@@ -931,6 +963,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
 
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
+	{ .compatible = "allwinner,sun50i-h616-uart", .data = &dw8250_h616_data },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },

-- 
2.53.0

