Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740842;
	b=iN6cByKdPFj6wlhhcj206vYZn5CA3qjJKdeD5veDDAujf4QlaVkVSMbm2jTbJTl9mkWG
	 Lqf1Y0SWBFe9Q04EF3qkRvmM8ZKV+jPwJ0hAqX4SBpSteBk+8z9a+bNRhGtwL0WEKihvQ
	 FK+KrDCI3SCNbdT6SxRkJpfbRg0OVCMCH8YO761xnmGQZPmUYZy7+ajqiHEv1U7mscuIB
	 frN9y2EIW3lpQv9UOEsI3g7thq2HwtfF4HFt1pr3kGQhfOxUEMS/51x4YqkKZQSvoh6fg
	 34iz22NfnSORLFRX96vklWfLAyQXlOnZZYaKuv3yinehDufTP57DJ9tUK87AwQHAffQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=TUS+mnADfjPLb/Tu910BRKa7Osyhu7sawMFZwcFgbOg=;
	b=pQeLCOTE8r8nMm8xDGplw7vuSJRqYmA74k9stGOkje+usNmmeEpdTpVaHKi8Dgho5Wrm
	 OtgLwhxNGNpf14PWUVMJ1x7h8qHRMl4u74XjTxb3eN5pCo9MytYiki3KBY+6s4fYKeORT
	 pXZMKPKhjJikJq4SQ1tGGqbfK/EvV6kErvEqYXi5DWXFzzgyXX0ZZW8uYAFEhgujjgogx
	 1BIFSi+k5vdW4yBlxWHtv8W3DxN3kmztx3CTJx07hiGFSuMWXuodKMj2pfimjhIQvqbI7
	 0gzC2GGjtAnUn6eIGzQvFpfU26R0kqxOc5p7UmlKv2z0k5BE2SovQ0SdPTe30Y7HJ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g0hjVO3Q;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FD606A32E
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 07:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA3FD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g0hjVO3Q
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8470d7d430fso205488a34.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740841; x=1793345641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TUS+mnADfjPLb/Tu910BRKa7Osyhu7sawMFZwcFgbOg=;
        b=g0hjVO3QRlEkytUg/WED6fxFzaYy0e7PSPTyROBruC3Cmwe3TmyDHzS2ipm+dtAtiZ
         Oc0yWOPHVhuq1EvFGPdw+1CwF5YYfH6bzYtM2s5uS+1qOXam277IbQiHVrTsAyFTbcYk
         9susBeqxDk3tol+9y63mrs34YbVe4bN0uhtTcagv9RpWexPj6jN4cCflzAlzzL7SVrlL
         BgYdswY5ec84rLFpO4+JX/x9+7bCngZR/CMcUS6fRpJgupGMoyy1S+ik26odbwU1CgLs
         h753YgPr5c8WO6gMGU5FoPz3VZBpfmV0emu2LX9sRiF8AWgxHibe0mcRgsQcA1OJgGrO
         2Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740841; x=1793345641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUS+mnADfjPLb/Tu910BRKa7Osyhu7sawMFZwcFgbOg=;
        b=lLWFJuVEtoX7LcE9UdWKglRuUU/LtTMD4Mn66girTGZuujUL2qsDGuC9VXbqynR4CZ
         JkL7OwE+9C3QycPtS1hprXWDQgKVXqxRLK+vRxgEV4Ioew4JqFAa0ZXlnSUFpPCElRfx
         yI5YTVh0PvV/Mq7ffUIsQMBdRyfLIVy5lP/x72w2cWGrqm8HckaOzgzeeV7ZNTEEO6Zb
         F0oEVBoN5/8snz547V5HDLfgmQX7gwu+vidDwg4KdjYPDS5ovHmJ4HF4XAjCQXNaSxbX
         +EuKIn0+TbmB3T7hsi6BL4dt6dkoaG50dsYf6md5HAUfyrJUMRgTrfLVYQSxFcK40ZFa
         5hpg==
X-Forwarded-Encrypted: i=1; AKwUvByALvnQLW7IBkRjkPPpaRSn6AOVI8ZFRFUPlDmSVTPHgRcoFm68D0eW3H1gA1GMgSk6f+k8eNKq7Sdrm6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8Cg5uB/spWx3AhAIdfXH1a4EOtwMp36vJJfillosB0IH36ikO
	4ndTMHeM8l9ZSpCsj6u9aVCeoAsqrw+sx7Zz1LFTMXGrnf5n3HPvgA2i
X-Gm-Gg: AYBFou11/VY0l/Uvwi8Dq7fgPlntL/Xqk1oOQ2paIkJS73IBEInsKu4Otu7RuzX1Lwv
	4jaOwVVcfSp8jaMm+4cFoaH+ZLty+U7pK9G+7sGjCr9tmtmAjK4XCiUODZqlsBYH3XTvuIPkQwG
	6XGoVkXzZKU7N0KXB8GnPlZqmdLlx1koSGhWmlFvnyMRyH8PPUzzz6t/SDOuLTy5YaNoG4Bndbp
	8+NXsplzskYOKAlwq9gv+eVass295jdDQjISGtXTo1I7BccrbUhjjv6BeW3KGUIsunQOqSp6imo
	rAaTDBZWuKHQCqNRCw8U+j7XIuoK7XJ1DydjgfcqOiqvRHVNaMy4lkE+MpBrCKiJGrltJkSCN4K
	prrRZ7qe7QoG213UxVuE2AHLDeIMp60mWh5+0Vo9caiMkVIDHvn+D0Ai5D0I356JMPDW1JWloY2
	zrKJY9/k7cRIwkr4+u3nyqNJKgkXLomlDmdvzmDoGZsWZ4hO3CU4YwIH8iX6U+b3aws1cKe6dw2
	Mo2yUmu5ylVBDucwVx2E65ODKwJz9mbkpNwy4WbktrjyQGQbsb7Kd9/LMiyMh7U5w/H484fFrZU
	kO0nXtbWXmZaDVnoXnPlp8eUa0vFztYp4Ih/nAgcxgJzqnsaUajULoBA11XQfc3c6iPGAOGoIRR
	3aHBc8NZChzGHCB29kovIrp4IyYhSdHHYmoApu9tQCy5iLfOHrN6qintv21VIyr1ZA/peKuHnO8
	LRgOE=
X-Received: by 2002:a05:6808:6d93:b0:4d6:90f3:74ad with SMTP id 5614622812f47-55be82da8c2mr808701b6e.45.1792740840785;
        Fri, 23 Oct 2026 00:34:00 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55be9880a99sm909562b6e.14.2026.10.23.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:34:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 01:33:50 -0600
Subject: [PATCH 2/3] serial: 8250_dw: configure the Allwinner H616 UART
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
Message-Id: <20261023-submit-h616-uart-fifo-v1-v1-2-e4a3bae2eba8@gmail.com>
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
In-Reply-To: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
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
DMA attachment also depends on a FIFO size being available during probe,
so these ports do not reach the existing 8250 DMA path.

Use a fixed port configuration for the H616 compatible, with a 256-byte
transmit load and the documented receive thresholds of 1, 64, 128 and 254
bytes. Select the quarter-full receive trigger by default.

Skip optional-register probing for this fixed configuration. H616 has
debug-divisor and RS485 control registers at the offsets used to detect
DesignWare hardware RS485 and fractional-divisor support. Probing these
offsets writes unrelated registers and can select incompatible callbacks.
Keep the BUSY-safe integer divisor hook and software RS485 handling.

Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled during
termios changes. Its clock is a gate on the shared APB2 source, rather than
an independent baud-rate generator.

Attach DMA from the fixed configuration before registering the port. The
8250 core installs its FIFO defaults during registration, after the probe's
FIFO-size test. Configure single-byte RX and TX bursts because the
peripheral request can correspond to just one character. The existing
startup path requests the firmware-described channels and falls back to
PIO when they are unavailable or the port is a kernel console.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_dw.c   | 45 +++++++++++++++++++++++++++++++------
 drivers/tty/serial/8250/8250_port.c |  8 +++++++
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..0f8c1b0b4a71 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -77,6 +77,7 @@ enum uart_port_type {
 	/* Internal 8250 only */
 	UART_PORT_AIROHA		= 124,
 	UART_PORT_AIROHA_HS		= 125,
+	UART_PORT_DW_APB_256	= 126,
 };
 
 #define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d1..f03051740be0 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -63,6 +63,9 @@
 struct dw8250_platform_data {
 	u8 usr_reg;
 	u32 cpr_value;
+	/* Use a fixed configuration instead of probing optional registers. */
+	unsigned int type;
+	unsigned int dma_maxburst;
 	unsigned int quirks;
 };
 
@@ -630,6 +633,18 @@ static void dw8250_shutdown(struct uart_port *port)
 	d->no_int_count = 0;
 }
 
+static void dw8250_setup_port_fixed(struct uart_8250_port *up, unsigned int type)
+{
+	struct uart_port *p = &up->port;
+
+	p->type = type;
+	p->flags |= UPF_FIXED_TYPE;
+	p->rs485_config = serial8250_em485_config;
+	p->rs485_supported = serial8250_em485_supported;
+	up->rs485_start_tx = serial8250_em485_start_tx;
+	up->rs485_stop_tx = serial8250_em485_stop_tx;
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -765,14 +780,21 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	dw8250_setup_dma_filter(p, data);
 
-	if (!data->skip_autocfg)
-		dw8250_setup_port(p);
-
-	/* If we have a valid fifosize, try hooking up DMA */
-	if (p->fifosize) {
-		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
-		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
+	if (data->pdata && data->pdata->type) {
+		dw8250_setup_port_fixed(up, data->pdata->type);
+		data->data.dma.rxconf.src_maxburst = data->pdata->dma_maxburst;
+		data->data.dma.txconf.dst_maxburst = data->pdata->dma_maxburst;
 		up->dma = &data->data.dma;
+	} else {
+		if (!data->skip_autocfg)
+			dw8250_setup_port(p);
+
+		/* If we have a valid fifosize, try hooking up DMA */
+		if (p->fifosize) {
+			data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
+			data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
+			up->dma = &data->data.dma;
+		}
 	}
 
 	data->data.uport = serial8250_register_8250_port(up);
@@ -854,6 +876,14 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
 	.usr_reg = DW_UART_USR,
 };
 
+static const struct dw8250_platform_data dw8250_h616_data = {
+	.usr_reg = DW_UART_USR,
+	.type = UART_PORT_DW_APB_256,
+	/* A peripheral request can correspond to just one character. */
+	.dma_maxburst = 1,
+	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
+};
+
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
 	.quirks = DW_UART_QUIRK_OCTEON,
@@ -904,6 +934,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
 
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
+	{ .compatible = "allwinner,sun50i-h616-uart", .data = &dw8250_h616_data },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index db066a42f61d..e99d35880a68 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -335,6 +335,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4},
 		.flags		= UART_CAP_FIFO,
 	},
+	[UART_PORT_DW_APB_256] = {
+		.name		= "DW APB UART 256",
+		.fifo_size	= 256,
+		.tx_loadsz	= 256,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
+		.rxtrig_bytes	= {1, 64, 128, 254},
+		.flags		= UART_CAP_FIFO | UART_CAP_NOTEMT,
+	},
 };
 
 /* Uart divisor latch read */

-- 
2.53.0

