Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299662;
	b=ztI60myUN9yf14bSyt44bbDHCai7yw2jUOpDKURCmNjE2R3Es7dAs0VvmGn0b1e68y4Y
	 wP25qr+B7sOkookAVqeaw6hVDIr5FiLsMQyIKiO9HDKThRxvJKGaaRdkhaawRuKOelHPP
	 j8SJy8W1aex+cXWhLXk6V16zeEr1fPzLqjR+1BYxWN5qyErV+iaI4yLNL1+92WJD98Va+
	 zfR5YLPm/+p8n8begveA7we6biSDFZcUezxRaTYEzlnLa2Ku4qJHPxaVyF/E2CEh4smUC
	 Ki+lc83y2Giee5cpRD4NonOFX96/L//ZwMk3LGAfkUT9IHSznpq7MtAyKCzYcgaw8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=XiQ0h5RUDVFXY9TV9nlMQOKan7K7h2eTMSJt9GdccNU=;
	b=Rm0JbHtynIlUq3PmHyHbj91LQKWat51uX3v4TADtdJ+LOaQcXoaETwfN9X64b/QHXQu2
	 lmvzJNzetu9RxgMYllstNIIc9Zf1paer4lkTDTsfiyMLYgV82/bBXV0L2JQp5YnRp1JeT
	 Uqx87ApqTNgHBLkszCq5CKdOxF61jmCGcCJeNuZPA08UhnSW01Kd2lKMWDaS0qvb3JGiq
	 Ng1L6p7hfyhxiekW8wWCfsw3UjB9KJ03ITtZ09Sf9Z02jN3qPKw1VyYM2Egn0TDoLrOqx
	 afSNbu3aG89/8NlxfCrPSkYfo+28Ej7pmgIY4wtsJLYjuUp9bD/TL/xcKxSvz3fftOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAJSstbL;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3260A2604
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 18:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA3260A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAJSstbL
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6df5e315bd1so1815842eaf.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793299660; x=1793904460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiQ0h5RUDVFXY9TV9nlMQOKan7K7h2eTMSJt9GdccNU=;
        b=YAJSstbLvrQs9uylpyI3HdZb1yZfuuCQa/k0Xb2TuXgPLTRxBU9BoEHNybbaPAAnQ6
         95qt6FhqfEdm6oTug2FM2bnS2sCHUaIjs1cCTf7l1Rm6KtVpzNb/55CrMj7qXDHF8xK4
         uYkQ5d1n65HPJSXS+K9EJ8Oh/4PPndGc1SIOkJ5XsgVu3hHHr/uTdwR/sESiOUW7nRor
         pajAQ53swTJOpM+dAEvpLA5uoUtef9PWwzfCTA4pjRHZpcsUVWlLGWQavDLCGyBeak5M
         nr9R9YVSz937p9VKOZyAspVgeGZJsDb+geY6aDW6hK24fuItk698Y+Pl9u90Fu3c3uFJ
         JdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299660; x=1793904460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XiQ0h5RUDVFXY9TV9nlMQOKan7K7h2eTMSJt9GdccNU=;
        b=EOvw1W8YHPehBdgetLKyHV/I09cgpFh62lafCHcLr5j7btLRWzs3Em2b4y+tiOBo2o
         /ybRRdLfYUXWR7ISrfKtAyO3qT8Hdall5NfMYT1R8tgyAHcfAx+n+k+a/mtZkNZHkKaB
         xC47y1zNI8o+B71rS4+EW61MlJ50nm9qHe/ezvsrArbVSXagdaTrb+MCcqozwbW/6ngn
         qS2ioloAvFgI3xeJLABJYdcK6RIH3b79zeLKZ7qgrmYd6pNCIyEtfEG6RjBBuC2pnMVg
         GUPBfCsrxnTIbV8yaRLWKyWxY4NofCmJ/vIEV+e1nDHF4T6xTW0dWZ2Q6WwFO62GfU3K
         Ra+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzvuRrjQhsXO5wnIY3i7rq8ATkvXOiLVmV6PmbNESjXkLLzwNDxi1BkRX1h0hT1g6FRzfuunuhA0NivWE0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2P0xUUwtUOTBIK0DmGaCG3EcFir+vAuxk9WLIb2Zg46UL+V1Z
	MEbpuk1lNPNB0g/E79UKMCcl09iIU5NdGCWDsLL8/PX8gUd+AyR9vNqz
X-Gm-Gg: AYBFou1um8OPDp3s0tOQY4XI2MVpS6+HaATgRSPinxTq8kclC7xIB9ZJ1l9fZyoenQ2
	em7RBJjyAVK468/KIaDR7Jte6p/x0hZLSJhUVX6/pv48LVAfXMehsiHRX63skBHcCsRSPbCUQjr
	NVTBySaDkak+WyvhkQOOVVYF/eC1Mn6+KsHMVrVrJAQTQ1n6lqofdPVswjK3ESFIQpAtpEuo0NM
	YVS+cdwfWkuwJAkbdkCeM/+w5s4axmil9r4AoJ6PydluWRI0VlEZQ0OamgKwNvOge3NTDNJE5sn
	kpjd0P5JVuAHvM1L4vGuHzDjMAp6LWvgQC+9k5vddAHMLkvAPJZ9vdHa7dj1ENqW/we8H56qHAD
	OakbHDcusU57VrRrRAShbJf3H9scbhUwlT8fzt0JJIKzvqeiclHFMJyysqS9or1QIFvbb1jNCoT
	ED6JNg9voPNKLXEVW8V5wSKFhnRb0tYG8csLuaw/hdKUZgJdyp9E5Ejg/eOd9i+QXIePByGHjIA
	RcZNlYLNlL1e6bQY435/LdhFtShKR9lVTcFx5QyPNUL5WngNwK75wC99hM/A0iMS06vyBjTKJxy
	FHqxC0/Tm60g3jxnSoB+0m4tH4hizdKtyuETFXfjraQPEyrbQFNCYi5CaBrgEAiAtqY0ts8eRsO
	kisjRDVBFGnOR3aBVhYZjXwgRwH4tC48bKbe4wdRzyHCoMuatrUAPqY09VTF+2IOjQWSMk6Hoqq
	z/6Ii5YC0hONgjqSc7HeXryn3ttb/5z50KU8Ev1QFbCeBvMGYRNHA=
X-Received: by 2002:a05:6820:a65c:10b0:6e2:3d8b:a01c with SMTP id 006d021491bc7-714f24006f7mr112598eaf.19.1793299660372;
        Thu, 29 Oct 2026 11:47:40 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cfb83sm221871a34.14.2026.10.29.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:47:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 12:47:28 -0600
Subject: [PATCH v5 7/8] serial: 8250_dw: discover Allwinner A523 FIFO
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
Message-Id: <20261029-submit-h616-uart-fifo-v1-v5-7-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
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

Validate the depth before generating the RX trigger table or setting the
transmit load. The quarter-full threshold must be positive and the
FIFO-depth-minus-two threshold must fit in the byte-sized table and RX
trigger API. Report an invalid depth and fail probe instead of generating
zero or truncated thresholds.

Select this setup for the A523 compatible. Derive the transmit load and
RX threshold table from the discovered depth using the common sunxi
helpers. This handles the different FIFO sizes with one compatible and
one receive-trigger mapping.

Like H616, this integration has Allwinner-specific debug-divisor and
RS485 registers overlapping the generic DesignWare feature probes. Use
the common sunxi PIO setup, BUSY-safe integer divisor programming and
software RS485 handling. Keep the APB clock gate enabled during termios
updates with SKIP_SET_RATE.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 3bc6735fc253..2ab91f479fc6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/limits.h>
 #include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -45,6 +46,10 @@
 #define RZN1_UART_xDMACR_8_WORD_BURST	(2 << 1)
 #define RZN1_UART_xDMACR_BLK_SZ(x)	((x) << 3)
 
+/* Allwinner FIFO Clock Control register */
+#define SUNXI_UART_FCC			0xf0
+#define SUNXI_UART_FCC_FIFO_DEPTH		GENMASK(31, 8)
+
 /* Quirks */
 #define DW_UART_QUIRK_OCTEON		BIT(0)
 #define DW_UART_QUIRK_ARMADA_38X	BIT(1)
@@ -64,6 +69,7 @@
 struct dw8250_platform_data {
 	u8 usr_reg;
 	u32 cpr_value;
+	/* Fixed sunxi FIFO depth; zero selects discovery through FCC */
 	unsigned int fifo_size;
 	unsigned int quirks;
 	int (*setup)(struct uart_port *p);
@@ -729,6 +735,16 @@ static int dw8250_sunxi_setup(struct uart_port *p)
 	p->type = PORT_16550A;
 	p->flags |= UPF_FIXED_TYPE;
 	p->fifosize = data->pdata->fifo_size;
+	if (!p->fifosize) {
+		u32 fcc = dw8250_readl_ext(p, SUNXI_UART_FCC);
+
+		p->fifosize = FIELD_GET(SUNXI_UART_FCC_FIFO_DEPTH, fcc);
+	}
+	/* The RX trigger table must contain positive, byte-sized thresholds */
+	if (p->fifosize < 4 || p->fifosize - 2 > U8_MAX)
+		return dev_err_probe(p->dev, -EINVAL,
+				     "invalid FIFO size %u\n", p->fifosize);
+
 	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;
 
 	dw8250_sunxi_setup_rxtrig(p);
@@ -972,6 +988,12 @@ static const struct dw8250_platform_data dw8250_h616_data = {
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
@@ -1024,6 +1046,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "allwinner,sun50i-h616-uart", .data = &dw8250_h616_data },
+	{ .compatible = "allwinner,sun55i-a523-uart", .data = &dw8250_a523_data },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },

-- 
2.53.0

