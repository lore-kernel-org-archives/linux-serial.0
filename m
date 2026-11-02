Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649327;
	b=rknm72o/bpnSElJBWqe8nHhFG+IHeaGV+qd1CYfRDoiepfHO+wRgUrKJ3bX+ondhxk9d
	 YgqchjQc6tXANPBRPZzQDzn1m/vinRRimqS543PrKnu682dVM1ggTlq4UCkzP9KRsFESl
	 nAzaAiC2IH8CRWMa7g5exKOBu5nfA6N1kLPO08Hfi1Exn9gRJYoQ85b+UUjKA8cNh07Z4
	 Dowgi/YRHYAM761UP2Z6NTdQw8RGJMDRNMebblRkv4/C7vUCEpasHqWY0i+yVYqWvdzwO
	 E4Hi2S4FlIRzt9rILz9VyLSSfFy7E9HCLhvjQhhxMGx25qp8KMs3JIjPAkRJGufxJyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=U5hO5zwt5yc5AR2FI7Ugtcs42sAA+kCKb2Q1p1ofynk=;
	b=l3KFzUgUiI2fEO1A5JqpzhPM/f4ZwWSz4Vsd8XiDg/+V/Il9gDMR1NhFCVTXRcr5ued+
	 GCJHkwBG8U61gboOXo0Tt8NVLstqsSNuDBey8p1FBL9SqIwwZYqP+n1YfHccmYl/xYoPn
	 P5YPNW/mHC7CKmK88lMKkjiAjtAanDOWup5MzkZrl0u2BNVHuIqQdPI543CDoI/rWXKZT
	 Fj5EZuc5vqExAdvLXEEGndBcPc6/LN3EzEyw79ddKZ6JcqUbcni5/CxhQ8oawFcfMtGB1
	 P4ERd1xhdkoaVjt5r+wLs5f6pv9FpmVTZnPLNE8nt5MK4Ei0BLCcKr12VYz+rKxDt2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOAgGNl6;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8330606D819
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8330606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOAgGNl6
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a6fb4040cfso1066365fac.3
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649326; x=1794254126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U5hO5zwt5yc5AR2FI7Ugtcs42sAA+kCKb2Q1p1ofynk=;
        b=JOAgGNl6wg95HkqA44dVV7BxO0Xx+VwFpiL19IefEgDIMSylmz2Vvb9LVXwNp8uKKr
         4UC1K5OS1pnJHAzjA/iKkkPV21LRoNw7zJncz1423y60Tib0ff68MnSIocBxfaF+gE9v
         GHBoLfhmwZSCGs6rnTOi/4jMj8Fi4cM5YzJnNX45q4Cz9BRxFhUCmRQBTgYl6BHamnwo
         4aZdMmrnlXaqp82z8Iv8KgV8TKVRw+JPOq/D4WQ3dwDK3/gSO3O9RXgSNTwfODb3MNom
         GJRLV4gAA2g0YEZhDTzC+ZZrJp0mFVNJXYY/aefoOW/7HQZiCwZmqAUXHh0Leuecn/7R
         Hp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649326; x=1794254126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U5hO5zwt5yc5AR2FI7Ugtcs42sAA+kCKb2Q1p1ofynk=;
        b=umu0DX1Vq3hp0K/v/S3uruFt3Dyp9omRBSp93N4Y5txX6tpLvs6QGKyx6WgcsbJIri
         FcUOa7uP2dxH+BWnlGXGptySB7fGh2kDZAW1FUP7xa2hWcK8BHl2Z86tojAWP8IMlJ71
         BXBUy+ZvYoh56MxkyApLjpa89knwGf5qGySnldZoskVh7pa2kKd8HsTjRtDseiGCZNzp
         jwmvrNxQdIFAFznC6CLYUzMSigmxiGAQMY1H3h3q/PIkaHeIcicC/W2GM3OM3E82vIgl
         ArQ5oNKQxYn+ZLnUzIXu2GczbJoQKeBJ+RDnPcIiq8+5/XrvlY2WYD+7en5YXrq6HE7u
         DEMA==
X-Forwarded-Encrypted: i=1; AKwUvByGuzwnhwtgOgcwYkMomlZNXqVX0OvcB6WM33ypqEuIL/RAx3W5S57PqMtm0bWhETw+KYoM1vVZzYZANwc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gaoOtVugPzoAiG5SRvmWTXI1CK1mfiYiVSXKfIAprERSECF30
	8eEEJEh8CFoDBL7nuZUjQGyanZWMSyLqxRxyTxTA1SI2Ra/ad8wBmppL
X-Gm-Gg: AYBFou22JLWMQBaiTFa3IOo6rKypOE4dXtg+P5Hvc8QEcUvRn+IlS7iquLqPoKmzrrJ
	16LwU53wiV7gw/6wDcyLC5TWCCmzMpMUuq6nCEAD3jXrR/MXF/E01hkKzmkFAVISE3+110QvVQa
	iz4gAo6yNgPfQK8Gx6NrUGSXXZCyHN+/bvr9GSGMa0AqqnP1IHJN4tXo2RUUbchF46QFIWNSpzk
	2FNDieO3In8z98IoXsgW/YyVW0TUqVw6jEr12dcxsDLQnM4b6/CQE7Ng9pVDyxivCo46rEuYi/w
	G37JDW0H94uMN5PS4PqfYZpd9S1DrjrxEmjOhKYuyvQ+J+vH6O+45LQ5kUMs3iGTuvG8OjNaOGW
	F+80tv68LK+1H/YUHGFyJE4xJrsnI3V6bXLFMbhZ2MO23H2ed7vLGsFpTND/Tc5r5g3o81LYepj
	A/nLTWmBAPQ7Fd+cMG8F713LPQ2m0lLC15QoM8DohXyuS7iEIkvxpCYLAMGHA5DcYw0CFj6deLH
	K956zxDuw40IdP2ex3LbG0t3VM/mvg37zNNukqd9BUb0exEdqMen882et1Hp//KxJkYKV3ZfI21
	+GC1eZW9VvdgebReuftKmIK/rFmac6f4wbdG+Ru5h6liHhIUw55FAyn+iBSdZHhCQLo3MMbz8Yk
	1dSCkqM13LIlx47eZyAiZUWiTZQDXNEZPAfCHO6TpzvpYXpDsfxOMqhfJLRasWURWYKrm+kyqqK
	b/Bk2gSr92yBxtncnPhphxaHPE0cpJZBdyHYJWqlgIoVLagU6fIdw=
X-Received: by 2002:a05:6870:ac96:b0:48f:e21e:1e7b with SMTP id 586e51a60fabf-4a9077e817fmr6538976fac.59.1793649325629;
        Mon, 02 Nov 2026 11:55:25 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921353dcfsm7809249fac.0.2026.11.02.11.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:55:16 -0700
Subject: [PATCH v6 1/8] serial: 8250_dw: select port setup through platform
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261102-submit-h616-uart-fifo-v1-v6-1-25afcb346b0c@gmail.com>
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

