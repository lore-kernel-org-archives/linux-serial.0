Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649330;
	b=uMyGOGgos7CUE+kTknzKrtF1SbcWdreYWJwcuRKV0vWt58xGZ9alfwH4glTjFvexwUWj
	 tQky6BTRg0qnqM+TRKJNngl917IqqBvVRCfUkYMhA8NwAIOcjeMtS9nIceClE94Kq9u/q
	 n2ZrDDFNxYDN8V7BsZyMMLNlXgB6xORKJDvOX7xL6x/yaeTK3r1Uy65PR5zjpYBoujU6F
	 uRrKcEVQpFce+BWog6c2ZpwtOPaJKmPV8KX/qfBYREwdHP8Y9/zM4kGBTRIQcG8DTKSlO
	 69OWPX/O/8IGPZe4Vd7ybnLx2EYMer3Z7rcI4nA4H/YgdEZcEUQknYeq0dZqzZbrdHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=37idryY/a/htHBbpIdMpV4QXCrwUTlQBCm2nQ8PKPDc=;
	b=qaGJIMnmWlaGK9gnIDJsJ3oZjutNBPIEWlJF/lnE4uegQMz+SM5B4epSNezsmFApotgr
	 /dNsxFlU8Qe4TPUgaKE9H/EoqBpit9RbRabBjMIfMB/fxHON81LAz9DG7gxfPHHs3TWBl
	 wUnjBgMTMjeyux3p6oEqY3uyjpLBEBb584hdBzz0pLNaECrz/ihTqQJS2LxDPlnrOYbk6
	 8ll1Wu99KX8Z5f1kvQq65aEBfWV868zm3SsxdMCHqjRfDNpvXVB1dcaQ9kx0+fqgwKmzb
	 dhuaj4W4/PLowO56hu8NMS995W5gx2O3ytR7SQOLZ2rbWRmW2PPeqDh+v/E9SMk4hdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=et+2dBNk;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056D6082BC6
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6056D6082BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=et+2dBNk
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4a6bb779d13so1823169fac.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649329; x=1794254129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37idryY/a/htHBbpIdMpV4QXCrwUTlQBCm2nQ8PKPDc=;
        b=et+2dBNkAzKkH6dyIhZofgVwileIhTd6BiUsnQpPxyr5zyqYPrQ7+OBegXVmy1KdKh
         XGOKkIz/1/7bjc0L2rzWUKZp9hJy+ewNTPn9wdhzZg9WxPBXWvHx23F0O5wtL6Zev38V
         SUNLdHxrrCU42XShnE8ed+am9fhf4O+iLO/+q4aEWwAhOksoPbVa8CtS2Z2sDlRGxWMG
         q0iQcf/2Q0tRvhYYpSGyHEHdMnklc6CbPTB0stj1s1Pm1ZoA42iihkbLt+Is8uJ9sfSg
         NiDwu0mf6UYmss2aTzJT4PtxBQ2O/ND15V6p+b6MJ7tkyISuk26/8tFQr4H/iWD+9FXz
         +EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649329; x=1794254129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37idryY/a/htHBbpIdMpV4QXCrwUTlQBCm2nQ8PKPDc=;
        b=JVL5tpJp9WhfwNiIoNOciVPGotEUhKcp0LX0HO/ot11K17ydiTHSTOGGe0ueC9Sv3N
         ucblgK/LVsqljrvNGhwzthWf3nQr7U94o0137TsUazdK9H+VvEpzt1wdGH0gA/AYQVS7
         zbb/LaJXr4WJEqUjOfiqz4kQeJPsUFXGlZLlCI3/i7OgX0z/l8nSCUYBiviyLZr++UmI
         ccoV9cdHAeBALqwpWZv62IKHjRDpInP5Z8vskM3ev7EZm4nCbAjz+7eaiMVa7wZwJ+PP
         AF9yWebKErMpC0eb38JV5A/SQSvKjjllXkevDWzfwAN4zdIp1vn2CmEJXmWW0i0CmfYO
         DX4g==
X-Forwarded-Encrypted: i=1; AKwUvBwQeXbwBHdhOrbOwqTghtqDiV+/3QvNq0RHIa7ENRbWmO3uWpEJZ+7QB6NKqRFmv73AwmeoWtUJdPnc6o0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAjLwAZiNzcw6IQSwvd5wC3GP0jZTMrNr99H0rliX8mc667hZ6
	G1HDq5BXevGhtvAJErSPKgjfleFJP/ZlI3ZHmDTXfnEhTr+TN/Cz2SAr
X-Gm-Gg: AYBFou0uNC8V9PC1bJ4SOyQMu14ghxgLLJgqQC2RhgNoOyH/UVsT1BeKzmPhePRkOdQ
	uR63HFYWqwF66o2Y7i81mc778pZgyuVrXKYx8O2iAMza8VWKgVMxGP5D9Xrnj1g2HSg4edXTy/f
	Lvo+L7YLXAFSldrPofqa7SMU4kSdbPVBidH6yHMZ3q1h1Gvw/9K/6zCIXOzfe72rLjQ9W31ZNYa
	RoMgD+A5JldBRgxMFzXasJHC4c7tkqN8OJ0CitNcHbD9tG1DaF6Y8Fx9PC9mOvPpA+IuHHfh+qF
	H3uLMzYB2umopGc+7O+WXNwwED8n42fh6WQbQ609S1PwRAiRmpou30yB3320YdkX62/w9H0bhnq
	J22dN6vl+lvH04juoI4oT3sep18BmPJghMEXbyDOESOuh7OgyaKo5Oj3fHiKX97p09eIkjdmYHO
	w/zALEGllnJkLcr4CBuUC9F3YZkhKB4CRw6oCfMq+p0nrwco7UYjOyVhsCGbyA3zv2xMwGGhHcX
	pnuIjKGJ2RbST2sY5ytNlIeKP0oqbGTqC/D9nWtwmADvSCgs18vpVYh29hJKJjhbx62FEE6Leyo
	B9AMfpnPfXDN/LBgkI5MQlqhfH7DE82BR+qmu+IyqEEZfM4KdRGR+3ThKyz4IuN+dD1vUcjdjWT
	lYoo7CxzZKmQWzwznXBc0KrRCldBbmuohuc9xMVvz4nJgFe6UsYabOQix9NzShKyYpOOOBkYmCA
	jvi7V2Uqzw6Ol4MBSXjAgdFEXAXZ0KH61GhQ+kgB72geE4nX0zJwhL
X-Received: by 2002:a05:6870:8242:b0:456:5d8b:5681 with SMTP id 586e51a60fabf-4a9072d45b8mr7344269fac.1.1793649329174;
        Mon, 02 Nov 2026 11:55:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921353dcfsm7809249fac.0.2026.11.02.11.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:28 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:55:19 -0700
Subject: [PATCH v6 4/8] serial: 8250_dw: configure the Allwinner H616 UART
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
Message-Id: <20261102-submit-h616-uart-fifo-v1-v6-4-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
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

Keep PORT_16550A and supply H616's fixed FIFO depth through platform data.
The 8250 core derives the transmit load from that depth.

Allwinner encodes receive thresholds relative to the FIFO depth: one byte,
quarter-full, half-full and depth minus two. Construct the RX trigger
threshold array on the fly so other FIFO sizes can reuse the same mapping.
For H616 the thresholds are 1, 64, 128 and 254 bytes, with the normal
half-full FCR setting selecting 128 bytes. Use this array for both RX
trigger callbacks and the shared bytes-to-FCR conversion.

Serialize trigger changes with termios through the port mutex. Hold a
runtime PM reference for the register access and the UART port lock while
updating the FCR shadow and hardware. Changing only the trigger field
preserves the FIFO contents; a runtime resume failure leaves both the
shadow and hardware unchanged.

Advertise automatic flow control so CRTSCTS enables MCR.AFCE, matching the
DesignWare termios path's hardware CTS handling.

Select this configuration through the platform setup callback. H616's
debug-divisor and RS485 control registers overlap offsets used to detect
generic DesignWare features. Use the fixed configuration with BUSY-safe
integer divisor programming and software RS485 handling.

Keep the UART clock enabled during termios changes with SKIP_SET_RATE.
Its clock is a gate on the shared APB2 source rather than an independent
baud-rate generator.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 104 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a546cf2de7b6..0b0156464af6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -9,6 +9,7 @@
  * LCR is written whilst busy.  If it is, then a busy detect interrupt is
  * raised, the LCR needs to be rewritten and the uart status register read.
  */
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
@@ -19,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/lockdep.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -44,6 +46,11 @@
 #define RZN1_UART_xDMACR_8_WORD_BURST	(2 << 1)
 #define RZN1_UART_xDMACR_BLK_SZ(x)	((x) << 3)
 
+/* Allwinner FIFO-relative receive thresholds */
+#define SUNXI_UART_RXTRIG_QUARTER_DIV	4
+#define SUNXI_UART_RXTRIG_HALF_DIV	2
+#define SUNXI_UART_RXTRIG_FULL_MARGIN	2
+
 /* Quirks */
 #define DW_UART_QUIRK_OCTEON		BIT(0)
 #define DW_UART_QUIRK_ARMADA_38X	BIT(1)
@@ -63,6 +70,7 @@
 struct dw8250_platform_data {
 	u8 usr_reg;
 	u32 cpr_value;
+	unsigned int fifo_size;
 	unsigned int quirks;
 	int (*setup)(struct uart_port *p);
 };
@@ -81,6 +89,7 @@ struct dw8250_data {
 	unsigned int		in_idle:1;
 
 	u8			no_int_count;
+	u8			rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
 };
 
 static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
@@ -652,6 +661,93 @@ static int dw8250_setup(struct uart_port *p)
 	return dw8250_setup_dma(p);
 }
 
+/* The trigger is the masked FCR receive trigger field, in register position */
+static unsigned int dw8250_sunxi_rxtrig_bytes(struct uart_port *p, unsigned int trigger)
+{
+	switch (trigger) {
+	case UART_FCR_TRIGGER_1:
+		return 1;
+	case UART_FCR_TRIGGER_4:
+		return p->fifosize / SUNXI_UART_RXTRIG_QUARTER_DIV;
+	case UART_FCR_TRIGGER_8:
+		return p->fifosize / SUNXI_UART_RXTRIG_HALF_DIV;
+	default:
+		return p->fifosize - SUNXI_UART_RXTRIG_FULL_MARGIN;
+	}
+}
+
+static int dw8250_sunxi_get_rxtrig(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	guard(uart_port_lock_irqsave)(p);
+
+	return data->rxtrig_bytes[UART_FCR_R_TRIG_BITS(up->fcr)];
+}
+
+static int dw8250_sunxi_set_rxtrig(struct uart_port *p, unsigned char bytes)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int fcr, ret;
+
+	fcr = serial8250_bytes_to_fcr(data->rxtrig_bytes, bytes);
+	if (fcr < 0)
+		return fcr;
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
+	up->fcr |= fcr;
+	/* Changing the trigger alone preserves the FIFO contents */
+	serial_port_out(p, UART_FCR, up->fcr);
+
+	return 0;
+}
+
+static void dw8250_sunxi_setup_rxtrig(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+
+	/* Allwinner RX thresholds differ from the standard 16550A table */
+	for (unsigned int i = 0; i < ARRAY_SIZE(data->rxtrig_bytes); i++) {
+		unsigned int trigger = FIELD_PREP(UART_FCR_TRIGGER_MASK, i);
+
+		data->rxtrig_bytes[i] = dw8250_sunxi_rxtrig_bytes(p, trigger);
+	}
+	p->get_rxtrig = dw8250_sunxi_get_rxtrig;
+	p->set_rxtrig = dw8250_sunxi_set_rxtrig;
+}
+
+static int dw8250_sunxi_setup(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	p->type = PORT_16550A;
+	p->flags |= UPF_FIXED_TYPE;
+	p->fifosize = data->pdata->fifo_size;
+	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;
+
+	dw8250_sunxi_setup_rxtrig(p);
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
@@ -875,6 +971,13 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
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
@@ -926,6 +1029,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
 
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
+	{ .compatible = "allwinner,sun50i-h616-uart", .data = &dw8250_h616_data },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },

-- 
2.53.0

