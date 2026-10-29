Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299655;
	b=jNdBiKXh5BC2t9oSVtiTLKbTrQrC1L9w/ftyYNWpdbAJAhzzK0m02lHax5SNddq5i7bZ
	 Q/JLuWu8Jr6uPxjhcdr+I6eZmeNRylNlveRCEW1ycoeCUyrFJCE1hIZXDMKYr7C/6Uyrt
	 r68zZ52hHpBkhbPMghpXTabJZgk4k+3XZnB9VNJBq5WiPBzHQXU3qzNnsuRNa6BFbMvuO
	 LVHiL5v6b4Ibyy/E6xiSi6TxV6aHz6AlRbQtmvAQz+Q0j2t3B51VhPTKyi1LggsJMHBCj
	 oOfWfw3/coRDyo8vMJDEI9uarSn+q4wOefzQhsmYr6nfjJHQMOZDNA9O0rjro/Y84UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=LR/0qFuwxt+mPuiN/gLTEtrR/SgllBRn6v2o0ijhbhk=;
	b=mWumxGGLhEU8hAFXXuEK66URBL/huL4ow8yrYSzcyBwZ0rLKxXrsJ5DWuaazr0bWDIpf
	 zTkLKzkotRG7QBcL1ETZwIN9rjNhKSBOST2XWERaZrdgyysJA4VONW86Oi5WwzbgJlgPi
	 nuRskRtu20djTxctsU8EbnqloxhpaQ/7qfVsKMA5yweEl9tKmnUUYB3BKY3qO3VyPiGLl
	 khrGr3lD+WmRvwia6M33DYzwnCuTvmza/ANpYAAp3obKw3hFr+uoqO5D4BpUS4r/IjPhk
	 Y3FP3Lfp5pHpFOxoG1fvT4wJyKqdZKYwNkWjMvn9ElWE6Iax/PUGq+y25rncYIvPFag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cQgwVL2a;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26F606A32C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 18:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C26F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cQgwVL2a
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85d363fb73cso13270a34.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793299653; x=1793904453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LR/0qFuwxt+mPuiN/gLTEtrR/SgllBRn6v2o0ijhbhk=;
        b=cQgwVL2aukhRdQ8yftPlO4LigSxl9iTiOuaSqZ6cDezKbSl7UUj1GUMhf9tNXHtDNP
         W9Yoy6kIZb/oYi4LE+ZQ9tCt+GVRT9C2E514XNKiCgKkFMSbw8trlLR9ucugvfqYy02t
         60gF8BzUv9zL3h/uPmNyw8NrgyE+thK2I3xiPTwxdYApoNo/F0WyRj5N1zP4KH9VcrQu
         rHehApSlGwhb1lBF/NTV0OPubZ9nrS0vkvVlJvndXTeInT5V2dX7PzzABhymc202dnlM
         T2tW/TjMbElJ1ZnYb2dQN6zPaVrPYivIQmJfx//0UNObSJjppaX7CiQuZGH8+LF1B+bn
         fVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299653; x=1793904453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LR/0qFuwxt+mPuiN/gLTEtrR/SgllBRn6v2o0ijhbhk=;
        b=H/2WSNbR4x3v22lsFGK+bXWNkxNdI7PeT3Z7HgkOe25pKR3uzyp8znVTmBkWCBbj8e
         bilFnAyUb9s/0VstjR2iEvwrssxU0ZLsDVJbU9CQMASLq0XoVk4TdFu5Rc70750Rfw14
         F9h8pRKhiPxUgXa4s7d5I1ukwN/I865xCshB/lsjhdd6coUPv1ve8X+V/5O/zd+Xi/kT
         krxuemju532AVKCRS6OFS92JOLXbq06TB/OV2Puupjnpcw4JA6j8TgTekkwIEBrL0vb6
         RVJbFg3ZCBe3I0VUL27nkhP7EAkhIZEJk53rAD3NigMXOxCvyaSOQC1byOhRMNbfQnKs
         mVJA==
X-Forwarded-Encrypted: i=1; AKwUvBw0N2y6+dWtmIqqUfBa0EI8j2DiLsE4VX0Le2rta5PMR56EIRSMS49Ii9ShhNpl8KodG2ucGuXx+s6y0a4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaaeEuQMk39B7qseJCJSWPM5d59RpvC+jBM16VNbPBqD18wqEj
	Log4phyUXMMpGRUUDdlYTdO0YBiS4F3CgdK1hpxPecZrrnHRg6mMs+6U
X-Gm-Gg: AYBFou39SI93QHm98RQ4tTjNM46DynsBFv5BzBD3K9ToU0Lp3xdjZHwlE2FjbLVnlG4
	m4uHSeeKTwc4aiHnJWdYzqlwwjdVEucskdJge+eBe34ukfyO90yVCZxcmqjfV1gT3Xep2IPwPgK
	qw68sVcvOP0kv6rcSnFnAs3pfv5TmOSCQVvmRrtztsb7L4kPLo9hBNMQ8KPdavboxThl3Ffesej
	rS7QVqe/2kNY1zPUWNgsyxwiOMtbdFWT5wfvWVMKXKYYzKgM0Q1UG2Ppiqmddtg0Ez6vAQguaPS
	ZkgBpdvvps4sLxezy3/JNjEcrg8KbzHg1HLtR58LSiRqs+whSb3+xbQpuyjo0dnWbNF5uzLZTbj
	I0FahDFpRlSKTAqxlleuUkiAOeQuflrd66ZTeYgvb3OOem0Hyo9wQIgAFuWxFsWasvVR15wpxic
	0odVJrSqczQJSOjPT+G4Asyo5M7T9IVM7yjT1oBw9/N162+3inF9yponlxRanVhL7/LGwUymopw
	X6euMNzoVK4RKajbUcUmLXt1YZT9+svbPo+te2605ppLvY3uxKVOqHpk+JR8rIhbRET5GBYWbst
	jBYuwavOBC3Mk7AtFF3GA0DE4yalvm35eCgxu9p4L/L564gbkQpXg6mvuz/4ExaawZ+KrUyduKH
	KUKSGTBDD5EwglhjvV/RFldlYpFShiR96/9IoaSo0RzV7O1IwNrE4E7DXIbhpk4e8CiaoM2Brkk
	4sMv9N/fu1Km1oU2yVZxAI1+tzAj/nv1s/vU5NL5/Z758S7rVNUFI=
X-Received: by 2002:a05:6830:43a6:b0:821:a0a4:5016 with SMTP id 46e09a7af769-85d364068famr49875a34.18.1793299653520;
        Thu, 29 Oct 2026 11:47:33 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cfb83sm221871a34.14.2026.10.29.11.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:47:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 12:47:22 -0600
Subject: [PATCH v5 1/8] serial: 8250_dw: select port setup through platform
 data
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
Message-Id: <20261029-submit-h616-uart-fifo-v1-v5-1-53b433aebbf8@gmail.com>
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

Select feature discovery and DMA attachment through a platform-data setup
callback. The generic callback probes the optional registers and attaches
DMA when a FIFO size is available. Integrations with a fixed configuration
can supply their own setup before the port is registered. Allow setup to
return an error so integrations can reject invalid configuration before
registration.

Replace skip_autocfg with the Octeon setup selection. Octeon is a 64-bit
platform and continues to skip optional-register probing while retaining
its DMA setup. Select the DMA setup helper directly for this integration.
Keep generic setup for devices without matched platform data as well.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 41 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 9cbe076463e0..a546cf2de7b6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -64,6 +64,7 @@ struct dw8250_platform_data {
 	u8 usr_reg;
 	u32 cpr_value;
 	unsigned int quirks;
+	int (*setup)(struct uart_port *p);
 };
 
 struct dw8250_data {
@@ -76,7 +77,6 @@ struct dw8250_data {
 	struct clk		*pclk;
 	struct reset_control	*rst;
 
-	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
 	unsigned int		in_idle:1;
 
@@ -596,7 +596,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->serial_out = dw8250_serial_outq;
 		p->flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 		p->type = PORT_OCTEON;
-		data->skip_autocfg = true;
 	}
 #endif
 
@@ -631,6 +630,28 @@ static void dw8250_shutdown(struct uart_port *port)
 	d->no_int_count = 0;
 }
 
+static int dw8250_setup_dma(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	/* DMA setup requires a FIFO */
+	if (!p->fifosize)
+		return 0;
+
+	data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
+	data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
+	up->dma = &data->data.dma;
+
+	return 0;
+}
+
+static int dw8250_setup(struct uart_port *p)
+{
+	dw8250_setup_port(p);
+	return dw8250_setup_dma(p);
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -765,19 +786,16 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	dw8250_setup_dma_filter(p, data);
 
-	if (!data->skip_autocfg)
-		dw8250_setup_port(p);
+	if (data->pdata && data->pdata->setup)
+		err = data->pdata->setup(p);
+	else
+		err = dw8250_setup(p);
+	if (err)
+		return err;
 
 	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
 	p->set_divisor = dw8250_set_divisor;
 
-	/* If we have a valid fifosize, try hooking up DMA */
-	if (p->fifosize) {
-		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
-		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
-		up->dma = &data->data.dma;
-	}
-
 	data->data.uport = serial8250_register_8250_port(up);
 	if (IS_ERR(data->data.uport))
 		return PTR_ERR(data->data.uport);
@@ -860,6 +878,7 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
 	.quirks = DW_UART_QUIRK_OCTEON,
+	.setup = dw8250_setup_dma,
 };
 
 static const struct dw8250_platform_data dw8250_armada_38x_data = {

-- 
2.53.0

