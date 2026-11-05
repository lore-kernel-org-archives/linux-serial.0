Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911941;
	b=OXxyqupPdpcTcG3UOjd2kCf56utKGssu0uYWKiJOjTB70UybL3pYrPSUWbSNGVW5xpyA
	 inrfaLxkZuImXw0NrG4gxevxxlB+5am03g7Mf016ib5xpr8tInTAqocNBsY3GyRRk78x8
	 7CIvEDUoQtg4va13EAAgC6UHrXdZttGSEvyGxPPBMFFHsEGyMTFhfFbAj16BeKgVEddHt
	 ZdRIlm4n334ZyNIh0QkxCc3Wc6iuEbpQyMTzO3Dp2ZPUi8urolEQMNbfxTgZnD0uSjn/a
	 y1ekTmSiLJxNO3tW93h87+TTMIGAZ1tt7q7Z2+Ql03vgHPK1mD1392cAD3MYhtsgdBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wQd2y5d3c9Xle1BZoXd9DRgnl2+Av/870a5uei8ZYeo=;
	b=TQcXsUXjTXPeqaflKSpoX9ggkvr68k+HyU1qXzv35ibGg3sMo9YxwGJQ1IcLkjrARHES
	 eB9NmsYVmcfgPmNyPxON0RKJsvEbYHmIE+eOfjr9hPMGKPJvvTIMp3QgzBiLkr0PFrIIl
	 rNpf9kd84aAgrHguRIPKTY8gn21d4vVoBfBWVrrSQa9ZZHzOn6WuixmN7S51AbqSX7Fbf
	 1rRR+E6+Ki93BtluNLMLrwoluWmcn9Z6TKsmEJYkOZ67jF9MvaHvqtDRfO44GSYUbBPoI
	 hb8hVTKRImO+jByoB4m5R7HzAp5cOWyVN9Di/s/jVbpiAtLjYd1xDBngPgcerTV2ptA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ukmSREQg;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF1606D812
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 20:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CFF1606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ukmSREQg
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8253bc5a613so8314a34.0
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 12:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911940; x=1794516740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wQd2y5d3c9Xle1BZoXd9DRgnl2+Av/870a5uei8ZYeo=;
        b=ukmSREQgwBeIB4js+IejMccaKW/ADB9+k31VP81/WzScU/Ks2yx08Im3dIzzmsk/hx
         ngQ7p0W3A5VlL1l28OrlDL2Tj+q6rn1XKOsKjzPc/zc6m1EwFLivcf2ufEcpzQ4n0iPS
         IEYyIrbn66qxNauprZNZpIScS5DXmiNfiun1AkfBvNby4neG/xD2eDxozI3zYbSBF6aa
         /oG4SYj4fn/QGbVVQ+Vtt1jbyMEMA6pJwcYuaYG/y226B9rFOWbk1k+fPDcygTwvPMum
         oFH5BOdZHW3MPXyFp4avVZpSWjHC/67XCCbFMf2rOjllbxqgg9j5jY/6BcnMFWXL1fSC
         k8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911940; x=1794516740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQd2y5d3c9Xle1BZoXd9DRgnl2+Av/870a5uei8ZYeo=;
        b=m0Wu3w9WGVzc6a2bP+4Ti8SkEiL8JcW4iVCi+r1dc6cEkPyBcAtE0gquB75Tl5/Qs3
         fws7yLS4I2botwIvdjkMkQVEj/7H4DhiYy+sxjmENels+6xB+6iPToR8HCOtKk2uHGY1
         hmOsroKwQR3aXs+wpdukjENf2mF6242TDgYcLpr/P4RS6tipLeEdRAp7F9vjnuHQoia4
         UNopgh40Cpd5FJanoRUQR9YmTLfQjOHKuixWYotVYCt2keIhLS7mW97fxEDSqAu5dCgo
         nVKXkez6SliyXKl84PZ4H9Phcf2r5WHPrviJ/yRPTdKAAr9YlWZxBHnhnfb7u4mCxwGA
         4SvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGgf6NVyNoBJ/eQtaFl9O2N6SUzYIUkAJsJScZs2RzISO7Kz+tbon0pPJT8xM0GofotbtVX4isK2Zs3ig=@vger.kernel.org
X-Gm-Message-State: APuU4Z94J+vWD8p+pUTDgr+BhDMQ+a8n3czo3C7jQJjASSP/amrbLVSK
	M6XP9JQAc7NcjzJzEs4E1A+iag/q2x0jo6fDIzcLuI0XXv7dWg3rocKY
X-Gm-Gg: AYBFou2sh1xgHkWSuVCIWDf5YncSq1SIdkyF+FlfsYSRMaOieYcHwD6OJvA1V6reR/c
	YGWk5A3wtWxnPB4EDdXQ1ZCkdJsRj0IMd+66sOSMoRZxujzq9VmIBfCpA2yjwqt8PTo5aMvP7u7
	aoASl0hP1uO6BYDfJnDADSeF62QQ/txmDvE9aseg81TuPyOIDL7ZdCtv7Gt6aDn9LWxHcKd5LR3
	3tvapiEN7XU13N7oxcOFnXQCuIue6yCHpWWsfDvHlpEDNZ6keNtoYs2jskbvYTUoIWQDBnFml5X
	t1sxbrxOtUz9wA0CVTite/O6+I8rgG7sVrYB2ct2ggX9aktX2KmtbmU5xHZYzTHoiiqnMd9+bGp
	yvkKFKRuzH1sMjNWp0Bz7iDnwwdW+UVg+rfsYkiEGONhxj8NrR16ZBkro6pIg5vrdnfHbUgtogR
	VQVaxeOL77c4nMQfkxqAy43XnCXKEN4dWGXX5BkZgSSCfvAbVKhYrquTarBtODBdKMtpmO49caS
	qOnBbb8oorQlFvqiGwXG3yc8a73Q8BiKrrIgZKYwpZeSHASr58HIO9G7tdtSe3IU/wfS7IEeiCv
	cLl6kh4B8wktVuPD5YPB1lYK0YwqNqbECh3udrwdlSoYYwXE9CuoMmu5T0XuiNQM/YSP5jtjYFV
	cr2YbhATOADq0UIxs3d0I6hduVavgrpsqx75cms1gxYT6zGg6QrNdNCAXF+ar/dOJtjKeF5LjUm
	dlTbN09jSuBUW+A98I8QaxaAZ1Gm8rS+sCtMRL7HpuUlT7UnZ17Hk=
X-Received: by 2002:a05:6830:310e:b0:821:d65d:37c1 with SMTP id 46e09a7af769-85f1d102bf6mr708163a34.25.1793911940392;
        Thu, 05 Nov 2026 12:52:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbb298fsm292276a34.6.2026.11.05.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:52:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 13:52:05 -0700
Subject: [PATCH v8 04/11] serial: 8250: share the RX trigger conversion
 helper
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
Message-Id: <20261105-submit-h616-uart-fifo-v1-v8-4-14024d2b184b@gmail.com>
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

Drivers can supply receive-trigger thresholds through the RX trigger
callbacks without adding a legacy port type to uart_config[]. Extract the
threshold search into serial8250_bytes_to_fcr() so those drivers can use
the same conversion as the generic 8250 implementation.

Keep the implementation in 8250_port.c and share it within 8250_base.
Include the unsupported-table check and preserve the existing nearest-lower
selection and highest-encoding fallback.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  2 ++
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 939b7d4209f1..8729619160ea 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -73,6 +73,8 @@ struct serial8250_config {
 	unsigned int	flags;
 };
 
+int serial8250_bytes_to_fcr(const u16 *rxtrig_bytes, u16 bytes);
+
 enum uart_port_type {
 	/* Internal 8250 only */
 	UART_PORT_AIROHA		= 124,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 452851815ffc..73bc9e7ab703 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3015,16 +3015,15 @@ static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
 	return bytes ? bytes : -EOPNOTSUPP;
 }
 
-static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, u16 bytes)
+int serial8250_bytes_to_fcr(const u16 *rxtrig_bytes, u16 bytes)
 {
-	const struct serial8250_config *conf_type = &uart_config[up->port.type];
 	int i;
 
-	if (!conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
+	if (!rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
 		return -EOPNOTSUPP;
 
 	for (i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
-		if (bytes < conf_type->rxtrig_bytes[i])
+		if (bytes < rxtrig_bytes[i])
 			/* Use the nearest lower value */
 			return (--i) << UART_FCR_R_TRIG_SHIFT;
 	}
@@ -3032,6 +3031,13 @@ static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, u16 bytes)
 	return UART_FCR_R_TRIG_11;
 }
 
+static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, u16 bytes)
+{
+	const struct serial8250_config *conf_type = &uart_config[up->port.type];
+
+	return serial8250_bytes_to_fcr(conf_type->rxtrig_bytes, bytes);
+}
+
 static int do_get_rxtrig(struct tty_port *port)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);

-- 
2.53.0

