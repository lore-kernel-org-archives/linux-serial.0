Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742012;
	b=iC7Z5475KgyuCxblEOJBp1duCJEboMfxEL0T9m5QufZIu04zVEC6WcFyVdQaPyQX2O7F
	 MjaglJKl6crGOv3dRoyDzUxQgbIEndNHMZ7jU8YrEs19RGEs2KymJW1GYe5M2zVrf/+aY
	 f8wv134OzA3Pef04O71tvxCemFnmKRMvU9c0xfo5UJI/Qa0mp7ruCppJ1ylemkzFJ3lrE
	 5qSEJAaMvU8hdlUoTUERHZbRM4uNaNqnxwI4MX/feUW5k3SNfPIvDHsbk/9tD6CPxA83F
	 UYqPL1y+tgcaMxnUGsUodAFEQlKJRsgLUbnrWK0K1fTFmDXXgAjedaNawZaAzdTraOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=MGRVzz2uqo92qo+Znv2w+QUjl1qrr60r4fm0Dgku23s=;
	b=weC8fSm8c1FiFsa5RiTp636fWQfWBdRraZ3D4fFQhYJ3M+zwZpxhkzQp854AId+uk1Uu
	 54vNkbSJrsW8eWfdFS74ufeVqeDch96OpT8ajsggXCgJ+4LBbLTl2d7RaDeC06Mta9aRI
	 afxdwIEU9EMJjdERrAJ07WSuhOC508tKUwVWyYYyhpHs1G+sY/auiRBtKuSnlxiyQNTVZ
	 FbT+3f6agO6yhW8RgR+QuXF9TDVc84iGCAi7cgq4PyF8z5o73F7a1MIn4P9IdPAo4N67V
	 MdvP1Y69zVVtQtMMKreFy5sOcpar6LGY+3EmIuVh/Sio01bYbJXKt4bsqFV3WxBBoOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y3v3hjD1;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A1606D817
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636A1606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y3v3hjD1
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8446af403b5so9710a34.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742010; x=1794346810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGRVzz2uqo92qo+Znv2w+QUjl1qrr60r4fm0Dgku23s=;
        b=y3v3hjD1XzAFYTAfi+0WOVq42OSXGUDjEIEYenAjIMaVTS2JmOcNB6oL73hf7MguIa
         9UZtJrUPJu/fSMbUqR2kJTQTYxp4aePMM8UBmruWv9f8h6LmS79CIok/8FyEtDWYAzcC
         W8euaucAEZq1vtaTsaIe3m1PfrsCWrgpcOV5nolM0Iwh9uYAg6fgY8M/Tnz4kOT9/bqH
         cmUaEH99TnywiYK0mHcsnzLqMfA4QmzizejAbrK5nzch/P7+H3wSc4GgHd9EMvUJSX7q
         Diu9SQvQAKeFjn1VUxmf0UHieSGaaM8Yu6jwZwdIAFi6q/ZbVAf7hh+764qBa1PFu54a
         wLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742010; x=1794346810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGRVzz2uqo92qo+Znv2w+QUjl1qrr60r4fm0Dgku23s=;
        b=r/D/YmMYQEMXh8gwJPWEfYSY4l5r7c3IBd0A+9VYGDghTkqRgDJd9I5uw3GL82XbOl
         lx5addY3b5/c4O2qqa50TMAaVdXAG7qH1oeWrFAedxFTuQhWwJDaEvTUOog/XJaj8LCo
         YffyePFwI16yt8O2ZB6zQdwU/p8xr9Up9R+/poWeOrz0IwizIqPBOjEtBUoXBE1yHMM+
         xpzvQTb9LosAVp8ytLRdNS650wuBiagoLXaaOIoG+gq3kPBWAXfzxWj3xzXDIle5DG/o
         ggJNIEZWU6xBkfhAsb830NYBG2MdsvYZS8BSWZJvfKfdrtQ+7qe4ffbbhDpn/jNdjX4v
         yY3w==
X-Forwarded-Encrypted: i=1; AKwUvByN+qQijV2sWsf5KTMrGOjRkEooQA7qoBn1SeON3Q744sgWVKLeK1tm7btG9xkkGNPE9CBDBM6N3pi1OA8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pWELaEJXkdGu/N8tUw0xf7/AuL88fVsFaDG0cOQ8PUlRfrF4g
	DZ9ElheMhpldrTkx1tUMy9QfbEg+lOM38eNYyiueaURUVr+pAwEixsPw1GYlTuVo
X-Gm-Gg: AYBFou2w64F5a5nskF7FPErCQ+g0KatGVh1N4L6KioFEd/04vBYFPehMwAX+dKGToPL
	2RVqNr1RyHg7RW4fB8VffDayszltXcYrjJk7sUB22oqCgwE2PtpqQi3+wl+SA1VL0BGMiMaD2SY
	CdXRIqbGkzDr+9V3BI4SbidBcMxYrxthdLFx/PLVnf6iFuuWoRKpUcG0uXPckVWpuzK16MFzBiJ
	2Tpr6Hd6wZekt7XbpnSALpC1MW//naEMC/1ymjtrwWWIewUFx21lg3J4SN7rMOUL9eBeyjKURUz
	r6vAmwnaKV9XC6IU4Jb05HobvkK1Jr6NsxZoIYgyvJnES9Yz54Uewdd+n0biPhnctV0ihLOFLGW
	+kjb0TSSrozTo+n8JxDfgkQ86oLsYM7PdKe1nKTNT8oPIaxaJssOXnDFQ5vVRfX3JlAQfOq+Xe1
	SYrRmKTru71VdMLr0XPTJUDWrlPhOsYZpVsedIiJB8s2G44Ksd71RqzpHYRvKXu2AZuDx3e28p2
	YO1lJJRMUgG7ifz3ZOmTidk1KJB9fatqA7D46g4/efEuVEkpSWJhiu+dhhYZS6LZOJlWr1iSJCp
	vjTjIG3PF9CdEXfQWWI3o91j1ubuhKt6G5d2vx3xWbzZtTQgVbOshf9HOKOOWM1YJrGLdA0pk0r
	PBo6U+O7RJ9qwLGQE80zaVBR7/m1DoEtK9gjtLZZeF6Fi48beLfjocGO/JschFLORecxLFEBrAd
	8G2SLxigbE8FuCC0CovxVCpvUOp/oM8cAYmyGnDKggIksdjSqlygNd
X-Received: by 2002:a05:6808:4fce:b0:4d6:9222:99f7 with SMTP id 5614622812f47-5640dde6011mr10618870b6e.55.1793742010259;
        Tue, 03 Nov 2026 13:40:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:09 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:39:58 -0700
Subject: [PATCH v7 05/12] serial: 8250_dw: derive RX trigger thresholds
 from the FIFO depth
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-5-c9e248d685c1@gmail.com>
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

DW_apb_uart uses receive thresholds of one byte, one quarter full,
one half full and two bytes below full. The generic 16550A table describes
these encodings only for a 16-byte FIFO. For example, the half-full setting
on a 64-byte DW FIFO is reported as eight bytes instead of 32, and a sysfs
request for 32 bytes selects the 62-byte encoding.

Build a per-port threshold table from the discovered FIFO depth in dwlib
and install receive-trigger callbacks for CPR-described FIFOs, including
LPSS ports. Keep the setup helper available to integrations which obtain
the depth without probing the optional DW registers. Validate that each
threshold is positive and representable before constructing the table.

Serialize FCR updates with termios and the port lock, acquire a runtime PM
reference before accessing the device, and propagate resume errors without
changing the shadow or hardware. Update only the trigger field so changing
the threshold preserves the FIFO contents.

The FCR mapping is documented in the DW_apb_uart databook, section 6,
FIFO Control Register. The existing default FCR encoding is unchanged.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c    |  7 ++-
 drivers/tty/serial/8250/8250_dwlib.c | 94 +++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_dwlib.h |  4 +-
 drivers/tty/serial/8250/8250_lpss.c  |  4 +-
 4 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a546cf2de7b6..613907b8a40f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -648,7 +648,12 @@ static int dw8250_setup_dma(struct uart_port *p)
 
 static int dw8250_setup(struct uart_port *p)
 {
-	dw8250_setup_port(p);
+	int ret;
+
+	ret = dw8250_setup_port(p);
+	if (ret)
+		return ret;
+
 	return dw8250_setup_dma(p);
 }
 
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 91b3607b64e6..004817cc8f28 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -1,18 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Synopsys DesignWare 8250 library. */
 
+#include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/math.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 
 #include "8250_dwlib.h"
 
+/* DesignWare FIFO-relative receive thresholds */
+#define DW_UART_RXTRIG_QUARTER_DIV	4
+#define DW_UART_RXTRIG_HALF_DIV		2
+#define DW_UART_RXTRIG_FULL_MARGIN	2
+
 /*
  * divisor = div(I) + div(F)
  * "I" means integer, "F" means fractional
@@ -208,11 +217,86 @@ static const struct serial_rs485 dw8250_rs485_supported = {
 		 SER_RS485_ADDR_DEST,
 };
 
-void dw8250_setup_port(struct uart_port *p)
+/* The trigger is the masked FCR receive trigger field, in register position */
+static unsigned int dw8250_rxtrig_bytes(struct uart_port *p, unsigned int trigger)
+{
+	switch (trigger) {
+	case UART_FCR_TRIGGER_1:
+		return 1;
+	case UART_FCR_TRIGGER_4:
+		return p->fifosize / DW_UART_RXTRIG_QUARTER_DIV;
+	case UART_FCR_TRIGGER_8:
+		return p->fifosize / DW_UART_RXTRIG_HALF_DIV;
+	default:
+		return p->fifosize - DW_UART_RXTRIG_FULL_MARGIN;
+	}
+}
+
+static int dw8250_get_rxtrig(struct uart_port *p)
+{
+	struct dw8250_port_data *pd = p->private_data;
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	guard(uart_port_lock_irqsave)(p);
+
+	return pd->rxtrig_bytes[UART_FCR_R_TRIG_BITS(up->fcr)];
+}
+
+static int dw8250_set_rxtrig(struct uart_port *p, u16 bytes)
+{
+	struct dw8250_port_data *pd = p->private_data;
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int fcr, ret;
+
+	fcr = serial8250_bytes_to_fcr(pd->rxtrig_bytes, bytes);
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
+int dw8250_setup_rxtrig(struct uart_port *p)
+{
+	struct dw8250_port_data *pd = p->private_data;
+
+	/* Each FIFO-relative threshold must be positive and fit in the table */
+	if (p->fifosize < DW_UART_RXTRIG_QUARTER_DIV ||
+	    p->fifosize - DW_UART_RXTRIG_FULL_MARGIN > U16_MAX)
+		return dev_err_probe(p->dev, -EINVAL,
+				     "invalid FIFO size %u\n", p->fifosize);
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(pd->rxtrig_bytes); i++) {
+		unsigned int trigger = FIELD_PREP(UART_FCR_TRIGGER_MASK, i);
+
+		pd->rxtrig_bytes[i] = dw8250_rxtrig_bytes(p, trigger);
+	}
+	p->get_rxtrig = dw8250_get_rxtrig;
+	p->set_rxtrig = dw8250_set_rxtrig;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dw8250_setup_rxtrig, "SERIAL_8250");
+
+int dw8250_setup_port(struct uart_port *p)
 {
 	struct dw8250_port_data *pd = p->private_data;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	u32 reg, old_dlf;
+	int ret;
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
@@ -250,7 +334,7 @@ void dw8250_setup_port(struct uart_port *p)
 		dev_dbg(p->dev, "CPR is not available, using 0x%08x instead\n", reg);
 	}
 	if (!reg)
-		return;
+		return 0;
 
 	/* Select the type based on FIFO */
 	if (reg & DW_UART_CPR_FIFO_MODE) {
@@ -258,6 +342,10 @@ void dw8250_setup_port(struct uart_port *p)
 		p->flags |= UPF_FIXED_TYPE;
 		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
 		up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT;
+
+		ret = dw8250_setup_rxtrig(p);
+		if (ret)
+			return ret;
 	}
 
 	if (reg & DW_UART_CPR_AFCE_MODE)
@@ -270,5 +358,7 @@ void dw8250_setup_port(struct uart_port *p)
 		pd->srbr = DW_UART_SRBR_0;
 	else
 		pd->srbr = UART_RX;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw8250_setup_port);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 7191cabfb086..44a5d0c2feba 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -88,6 +88,7 @@ struct dw8250_port_data {
 	/* Hardware configuration */
 	u32			cpr_value;
 	u8			dlf_size;
+	u16			rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
 
 	/* RS485 variables */
 	bool			hw_rs485_support;
@@ -100,7 +101,8 @@ struct dw8250_port_data {
 unsigned int dw8250_get_divisor_dlf(struct uart_port *p, unsigned int baud, unsigned int *frac);
 void dw8250_set_divisor_dlf(struct uart_port *p, unsigned int quot_frac);
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
-void dw8250_setup_port(struct uart_port *p);
+int dw8250_setup_rxtrig(struct uart_port *p);
+int dw8250_setup_port(struct uart_port *p);
 
 static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)
 {
diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index f1b4b975571a..7ace0515038e 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -350,7 +350,9 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	dw8250_setup_port(&uart.port);
+	ret = dw8250_setup_port(&uart.port);
+	if (ret)
+		goto err_exit;
 
 	ret = lpss8250_dma_setup(lpss, &uart);
 	if (ret)

-- 
2.53.0

