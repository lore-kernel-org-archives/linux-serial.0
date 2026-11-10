Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280400;
	b=DEJqXXlZfIzQza7YxGcLQW1u2sqb7q3UnGrrJqxHfFdfKiMqZyJNxyoOofD9HV+sGrGP
	 W4cXgj8xNOmWDIfWZMm3EtPKagySMMuBPggMYy3RG5OfNDFPXosq7SadP7jMBLwX2/cE6
	 rJpiO5LLEN8LFogVnRiY00jr1zoJAmZEE0PNkkNxdcj2Y2HVQZb+reXs+LzkB6JIaCJMA
	 PmA0doFAMX81rhizOYe/Ew4N9cicHWyTLLMGtOcMkf96mfETK8x0f+SMkOR+9e8nznXyC
	 5+Pax2g4aR6qik+nsvVbRKdtMZvGqtheXofRxSa3Fl/xsgKeBYfTr/ePoSFRzrWq8bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=3G3CWQIL0JbSsmfNksLi3Fp/1YxbYzf4T7l8kEzH84Y=;
	b=T5VOmIUi0FgCPqEJzp+ZnPB5i0Y3G+aGlVzTgj0WFxR4zWAIoe8pu+3atiTF+unL1XPR
	 XptgsisoG115R8uTVYs88+5A7LiIUdW8vxb6OBDy/voQv5THB2verYHM+WNdyPQZNjqCc
	 OK/sXOBC+RcpgC8YbBmFybKcFm53vwP/qlZc3gX8or4nKIVKxtb5nH7JABEUshKhthDy8
	 dKuJKZ+tYcdgvUerofSt7hnlVsGnQXCNU+06FGsu9Cn8gp3a3rSzNrwxS9MhsciBIv/IL
	 Q05tSwm2JTUH6IRni3dXnVnGOsDiUqHLgDtkaqgXZxZ1TKpxb8ory44qEbqFsAbnpQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUtsplA4;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE360A3817
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68EE360A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUtsplA4
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4f66bb2ab57so475765b6e.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 19:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280399; x=1794885199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3G3CWQIL0JbSsmfNksLi3Fp/1YxbYzf4T7l8kEzH84Y=;
        b=IUtsplA4ScTgbCud+D2dtlqiFreohgUUxbgvpGAE+Iq0YwySIGXwvCvXc23S+HgGXC
         h1BiZCA6TRTfJAuI9aKU3fkAqXVQcyeZdb488W/kH2GvA7TBfZRKyn8ipWO9gkMPn66K
         43ewT/OY35/8kf5iSVy8LD2XdoWCx7xzAydi2eHK/msaa7yGI9KSMr67C3f953dvL7ap
         1Mtel/mAnFr0fH+Z0MwHS4STwyBLVRgrjcIDmJKxI1lvYn21wM/R1zQpta/jvZLgWBIz
         JUkYqFUS3mBikFK1r9zMDd4ibBVDpuWDGWXOJ6AQOKRZae6NFl5IfcPY1iy7sktAcfUj
         vOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280399; x=1794885199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3G3CWQIL0JbSsmfNksLi3Fp/1YxbYzf4T7l8kEzH84Y=;
        b=0AnuZXvSwsQDlZMXzSVVD9x3EECLlAoovPfuP84PxSoX1yNwNDhF6gYkgSpZ3ObH14
         1zHwZGUgXMH55Bx4umrkXfDqAWT/ptngXz5dYHYvS/wLJ7xXBUGXC5rUUbbZNNbdMphq
         NJwMWiQX/Kplo+tYM5ekiKN7aMeqfPRax/+uxs3VRj5ezMdeUmGP91wQmYI5jEKKrPbF
         V4S3LQ4qYW7jasUsu0sHnB7F0Lx1mnuQFXjXSVJ8k4lN4qQX96x18feMlTYoHub9438D
         RHHYuJ1fRAutnZvmS83PVGjXQNk6fvH0fH0JBzP72MHhZdbX1UYVPDP+JBpt2HNq7EW4
         rQmg==
X-Forwarded-Encrypted: i=1; AL+hErGYO5Ra09RS1cUUkU3A4zpfh6sKM2zlwChWldsGIcRc2naMSIMSRpYg8KE5mux10yg++QpKAeDg3eapb38=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rHZruW08Xk3zCMyl6UCn0Pw5/NWSRPSFfhEwMstvaBLj3zK6c
	Q5qVAb3wlFsSJVOD7MTr5FisHqadwr5m+Nkm3J/jiELxsoQWRtLJkS9f
X-Gm-Gg: AYBFou2uz9MU7xGII9tzTdkMd4UeMRUWZqUl4yUbV2Wa2AbsCt8ECZlvp3pBYCRDN1S
	AEqVKSEO3WHr7YfG5Aky/Wr2OOxIpdvQzcRKaU7i2zTdUGbX9I9GR9aWA/LGPSEHLdLoBCa0OF1
	U6xeqFyE93V4Pt9insW0BlO9TqwYzdqpNNOXuznTuXK8DRhIMXl9ttqfEQZO/K4lRtwgVnFDtJG
	bm1qEmpZeydJ3/aMxiODgg5LEvoPFqzoqwuqoBrjK6Z8qXMZLObcXRu0RK761iC+wLWtEbeDS47
	Aqf2LN+B0V2nKAzUtVVgpIutL2GtA5OIg0goWQCmyppHzLRHNJYOAhAhpXZmCn+k4uXxRp7xzKo
	6Vs5h/eanV0kxE5ycTAD1H9TYnAScBly+yqcp8hqDxwvQscvV48Dxbf1g+pbQAtn5pMYc3qCNUe
	nrEGgTn8Pt1jf0wAz9dRR893jE4BKhjcXK4PbfpW8A/B94Vf2rMyTEyv00syeqhuE+7Dmwyz6EZ
	UVnYEtjrvB92k+s+O/nzbAGb6HvJhITsJx/XkPms3zu3j9/eKouh4+nJdavonxmLHSl4ysFNfBO
	3rlBmRyOrIXQXqi6vNeezsUkGca9/VhjJqV1XnY2b2ERzo0ZngE2VhOMv+WIdBoGE9TO42vpagC
	E7DQbPPJgUXL/fEEDrKWIToFxSXO4gmxv9eIL2z7hZGRfU3UkdVU4l6IjWOfkfCY9gqkpp1JdJt
	BN5OOYq3PxSAoBS805BqY14xibBaizeADg9/f+2MmJvxsRY33nfLoy
X-Received: by 2002:a05:6808:c22c:b0:568:e61:dd02 with SMTP id 5614622812f47-5683cccaabcmr1071675b6e.43.1794280399379;
        Mon, 09 Nov 2026 19:13:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905736b92sm1019236b6e.8.2026.11.09.19.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:13:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:12:55 -0700
Subject: [PATCH v9 06/11] serial: 8250_dw: derive RX trigger thresholds
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
Message-Id: <20261109-submit-h616-uart-fifo-v1-v9-6-3f03961dae8a@gmail.com>
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
 drivers/tty/serial/8250/8250_dwlib.c | 87 ++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_dwlib.h |  2 +
 2 files changed, 89 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 4a06dec6e263..6cfb7674ac11 100644
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
@@ -208,11 +217,85 @@ static const struct serial_rs485 dw8250_rs485_supported = {
 		 SER_RS485_ADDR_DEST,
 };
 
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
+	FIELD_MODIFY(UART_FCR_TRIGGER_MASK, &up->fcr, UART_FCR_R_TRIG_BITS(fcr));
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
 int dw8250_setup_port(struct uart_port *p)
 {
 	struct dw8250_port_data *pd = p->private_data;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	u32 reg, old_dlf;
+	int ret;
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
@@ -258,6 +341,10 @@ int dw8250_setup_port(struct uart_port *p)
 		p->flags |= UPF_FIXED_TYPE;
 		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
 		up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT;
+
+		ret = dw8250_setup_rxtrig(p);
+		if (ret)
+			return ret;
 	}
 
 	if (reg & DW_UART_CPR_AFCE_MODE)
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 4d32651956ab..b896dd9bebb7 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -86,6 +86,7 @@ struct dw8250_port_data {
 	struct uart_8250_dma	dma;
 
 	/* Hardware configuration */
+	u16			rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
 	u32			cpr_value;
 	u8			dlf_size;
 
@@ -100,6 +101,7 @@ struct dw8250_port_data {
 unsigned int dw8250_get_divisor_dlf(struct uart_port *p, unsigned int baud, unsigned int *frac);
 void dw8250_set_divisor_dlf(struct uart_port *p, unsigned int quot_frac);
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
+int dw8250_setup_rxtrig(struct uart_port *p);
 int dw8250_setup_port(struct uart_port *p);
 
 static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)

-- 
2.53.0

