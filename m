Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911939;
	b=oghJwAsUkUZchWBR63hOk73jzOXHYwR+zKSZHh9NLFBwrFh0aQnp2k9JOA1nnblwKXjm
	 1A1fFRU+o5gb7OiwsdFeYx8qYuc3dXN8p81gq66sW4UImNq+CDS4WLPoe81WiMXH/Ahon
	 mvtN3w98r1f9qhmhXFIoa2dRgXUO1y4wfYakzMKMGwVxiC5lG3YFe2ntvlvkerl4W0/wa
	 dIUaof4nhka2byKfwBq7/z9ra7ZyrcyAJ8eT6GphQ0G55wiRNqoQjdplLMcNBKlNzLcc4
	 MnMRoGkzyq5tlYoJ1Yuwd9B3Gvlbh2q1BvwaiASUJDqLkEO85tmB8ovSPu+oqhkpwmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=E9UoBDBjwLLwDb4WmV28avfpsh+5/w/6UybGFvQ6fZk=;
	b=u8Z5fEEL22jptM3xLj71yLxfqzgS5MyLn9dYS5VNfkpDSWhAXYmeb7p45fDGaev0fcrV
	 iacCPloKc1Y8fCObmVFQm8Qiqy7VfnNFEcBJ1YTEogW8U7GvsPJP6/DRiaild53OIf1wR
	 36NzdNrYZAqAYWsDgt0Ng5kMcTIEnK6IQBYBtlbHtLGAPduaJisvpN862xXJbX+XwPF9/
	 zivxsCPPl6uA2QsZ7wKVSq1yJRMHx92wHW3mBv6gyoUm4/iG865I5mBAv7yAs6WdcxPHC
	 Y8U1bGH9iOz2n8yxWH23sPPlwUq0MRP0JIoCvOqkbFeNSY7u9QLQZLiAQsq3AMXIBJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mc7siVKY;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A45606A337
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 20:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A45606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mc7siVKY
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85ac281604dso11012a34.0
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911938; x=1794516738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9UoBDBjwLLwDb4WmV28avfpsh+5/w/6UybGFvQ6fZk=;
        b=Mc7siVKYA2Mp0wkrwtv02WP1UWanxUpCYF4fxsFjFGzJahcflsslfo0UWJCM8QCTIQ
         biAKPN/fjADxtxNNA1XMHp/q93eet3+F0XItruAUIJQxhw1rriJAdO4bqZZoBtR97tV1
         e4dAn4fMRsIKdRN8bYG9fcaq4fOzHO7GlYIw7qM8Q9Dz2M3xkfltDH+I8Qj+mxNmvxlU
         CLt7qlv13XZt1dueypdComgv1ZhQgVhoCYacHlY26tX9NW8BVzZp/HAOZKN+reAN2gMl
         +WCmzClTZ371cX3ykK7e8eWwKNgoYCFsRdUO6lBKEsD4GFfKosj3hEFGu5DSvoSXpkKa
         vgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911938; x=1794516738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9UoBDBjwLLwDb4WmV28avfpsh+5/w/6UybGFvQ6fZk=;
        b=ZgBbhuvLqaaPSYagHYnSsu7XUSDpgxRqKpkrfA/HmPuY7zHB8uhZkUvJUx0EqTEbg5
         88UGVvJswUCtyNCJtu7scf0JeheMplAbjHl3cerCs2DhpEgbiRdJGUqIdVYET2J+5RiO
         vUYC3bBZJAXsa9GJJqnIFaOivA3mc3UzjD13XAWs0pyAmTODL8bCOd4pJ2qDzbRbVtM4
         pAajd93LaYsj1kGBzMSCDmXZK4NOfJeiFptci04cic4uawPRdc4NA5GcfmsIol4Z3TTL
         5s5bjVQPjN6v2U9pSSQEKPMU28DFPAc1FvUvjWe/i4dXp9fvYyUojqBk0HIRiC+pF5RP
         CBmA==
X-Forwarded-Encrypted: i=1; AKwUvBxd2ZCqXLeSd0cDeg5eUMgGX01hGWXwhv6dJJCwmbJsyVgf3Qv7U+6X/HgBUz2ZpqRzz7c7S1/HWg8MP+4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dqUCQQPfsGth6Q9Uh/zbzRFMu/a/mG49+IWpwPQMdw9NUGWod
	NeNTTQkwGnc7RpNE7caGK2tQCWPFU5J10EykSgKH9PSYYY8J9NSW7o78
X-Gm-Gg: AYBFou2WRBhOJ/g1/uN/f+CLDmsnuKyKYgvWJ/Yt4N3GmbNX+gZFjtkwxsm72GzRo5M
	4G2uSCQCqecYsBWjLglZZ5STi0ZLdItHgfawobuFGPuPBjffS0PXcNswUvibUmxx/2u4NJQVMJ6
	BqLBMXCmnbT/uKzzmAJ5n7UFDWCvzkCZHo/qs/eQuz8hJFx20oKhd/dJonAuSvyZQSqBalWvZ/h
	//oj6XEvIvzNXninIC+jlILhYlniqvBCuMtwRMzXYpBvcwk95lRvyNUe0CN1FRl7rXEgFMGu0AZ
	GBeXdZGO5KoYcQ9A5SJDc8SP/vYGoZXudCLs+8GBYFN3GKz7H06wHgYvhR4/6PmwrlHpcrOCxd6
	zk7NpxLAG6aa0FHDrXfIYQXkKAaf+qzvNda7Y+LHmbDa2hijY1pfUuVBcGTEF7+2w3YZen0Tzfz
	+Rl/PIVAfRkUeNW7JgZJk79kO7KrShLlPLBdPejlnhqfU6oB2HYxJCXpYVeoGcBy1o1xXa2/z7J
	LKnUUVK5XK7DGiPuhh3H0yNEj+u9zlbJ96cMHxheTfgv56fkD/n5mpuReR5T4LaEFU8AW4eltt5
	C1uiCcXORsp1OC3CapBIin+tVAhrV0TTEbbaGeGcbwYukUZeNzMP0+hjoGC0gUDLSvkHVCDkLjA
	cxTxqIFEwW08BcGPoC1Pk3GDv8mlLdYOMKeyAEopyAd1lt7DDvjvL+Kt0pQEa1k/d84BxhsuUy1
	80TP+J+jxJ5a+Kgdr4p0SfgjMzZEsqW4NGb7byEXIdx9xTTifr3Q61MNkfOcdHfWr3QURMNwuy
X-Received: by 2002:a05:6830:2317:b0:85d:6045:52c6 with SMTP id 46e09a7af769-85f1d086f53mr580936a34.24.1793911938304;
        Thu, 05 Nov 2026 12:52:18 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbb298fsm292276a34.6.2026.11.05.12.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:52:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 13:52:04 -0700
Subject: [PATCH v8 03/11] serial: 8250: widen RX trigger byte counts to 16
 bits
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
Message-Id: <20261105-submit-h616-uart-fifo-v1-v8-3-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
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

DesignWare UARTs can have 2048-byte FIFOs, with receive thresholds as
large as 2046 bytes. The byte-sized threshold tables, setter argument and
sysfs parser cannot represent these values.

Use u16 for the threshold tables and byte counts throughout the 8250
conversion and sysfs paths, including the uart_port callback interface.
Keep the FCR encoding byte-sized and preserve the existing threshold
selection. The Moxa setter continues to validate against its 128-byte
FIFO before writing the byte-sized trigger register.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h        |  2 +-
 drivers/tty/serial/8250/8250_mxpcie.c |  2 +-
 drivers/tty/serial/8250/8250_port.c   | 12 ++++++------
 include/linux/serial_core.h           |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..939b7d4209f1 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -69,7 +69,7 @@ struct serial8250_config {
 	unsigned short	fifo_size;
 	unsigned short	tx_loadsz;
 	unsigned char	fcr;
-	unsigned char	rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
+	u16		rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
 	unsigned int	flags;
 };
 
diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 4935a5d1c1a3..4f0b881b4f83 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -257,7 +257,7 @@ static int mxpcie8250_get_rxtrig(struct uart_port *port)
 	return serial_port_in(port, MOXA_PUART_RTL);
 }
 
-static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char bytes)
+static int mxpcie8250_set_rxtrig(struct uart_port *port, u16 bytes)
 {
 	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..452851815ffc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3008,14 +3008,14 @@ static int serial8250_request_port(struct uart_port *port)
 static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
-	unsigned char bytes;
+	u16 bytes;
 
 	bytes = conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(up->fcr)];
 
 	return bytes ? bytes : -EOPNOTSUPP;
 }
 
-static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
+static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, u16 bytes)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
 	int i;
@@ -3073,7 +3073,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", rxtrig_bytes);
 }
 
-static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
+static int do_set_rxtrig(struct tty_port *port, u16 bytes)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = state->uart_port;
@@ -3094,7 +3094,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	return 0;
 }
 
-static int do_serial8250_set_rxtrig(struct tty_port *port, unsigned char bytes)
+static int do_serial8250_set_rxtrig(struct tty_port *port, u16 bytes)
 {
 	int ret;
 
@@ -3111,13 +3111,13 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = state->uart_port;
-	unsigned char bytes;
+	u16 bytes;
 	int ret;
 
 	if (!count)
 		return -EINVAL;
 
-	ret = kstrtou8(buf, 10, &bytes);
+	ret = kstrtou16(buf, 10, &bytes);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752a..97301ef66af0 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -461,7 +461,7 @@ struct uart_port {
 					       unsigned int quot,
 					       unsigned int quot_frac);
 	int			(*get_rxtrig)(struct uart_port *port);
-	int			(*set_rxtrig)(struct uart_port *port, unsigned char bytes);
+	int			(*set_rxtrig)(struct uart_port *port, u16 bytes);
 	int			(*startup)(struct uart_port *port);
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);

-- 
2.53.0

