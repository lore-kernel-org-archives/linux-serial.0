Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280407;
	b=kyVFZuWIvKnWjL51Ri3MId4MY6x/f41Yhg7XwaccZOlWag3CI+Bh3if7ZRT/qGOtvf2I
	 uShpdr+O341Jd7qWAK41fGcecmEk49iJnuHPuj8HY/iCWr6ElBVBivZvmp1keYVWC8v2G
	 Rpk5rr1/ZPEG4Zs7sbCgv1e0FkK7rHQdIRXKItw/9fJo/BALTKy1MompDLXaZiAPoopJk
	 /22NA6yEHQZAkWrXNIqRn3fDZAvDxfhiIfzxSjmLHEM7tKxMl8bwafMG9rzypgiY5pSLJ
	 gMGkOlco0VIF25D65IG96kDJT/yQYBvPZL6WYZ2fMMYCKTyw9R/KN0HS+nX/JyxOK+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gLp03dCCASGHpzLVyWfgND6QB17hfQHAhLsrbe2Ht9o=;
	b=FmeH9n1/9ZMLNMzRnNasNzYCJ6r0vxSYX/WLwyxJR469kFkNBHy+1PH2mOw83Wd9UfJh
	 efvPzD5OoqFeKYydGvwYKY41cymXErmAyQvCZSqNX5405ppV/35mrlaZFD0zxvpDWi7Bw
	 8E4rxQkAShWvp5hlBXJJK+TScnojkebVMO3mF426eMs8Ux3AyHiTa+B9UAyV1ZwC9f/tg
	 qBVUr1aImVeMVJWmD8sfcTJHV4g3ERY+pRnqYWECkxjKn01F6AcCwHticGvAHyu6som0z
	 t+KLoLOLqy6l9rXosjUNySb72M1z8NzcJdr5OBzKFie7bxhjHxMf/njP6FdqG1zal6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ROkKaZkM;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143460A6F52
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5143460A6F52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ROkKaZkM
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4b28d9537bcso1101400b6e.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 19:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280406; x=1794885206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gLp03dCCASGHpzLVyWfgND6QB17hfQHAhLsrbe2Ht9o=;
        b=ROkKaZkMWh5d5OvpULRiZEJmYvA+/FdCDQzPNlLL7F7ekMbXbekAgW8jTlvQgY7gOV
         ns/UlBCci8eJ2z569ftVevTJV2To/dboOcyV5EYi/R49d6Z0GddcCYVD4Z6W6WTBU8xa
         LZC6DgxzyhLMxlDdqVoSAtjIee5WIa3Cf5gms86s4bdW6re1B9sAzqlmLm50kJzXsfXJ
         iRQRC1yLwbU6hfmSnwryaQHmhySQlOveZBA+MVg0vorY3bdurElVwgDLvCDk8klkfCPZ
         Fo5WSUVImH0miVWP8Zxbh9FLcG+KMUmGASU5xbODVCqfIK7P0NZt9ecp8Nsk5Lj5A4Lc
         mnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280406; x=1794885206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gLp03dCCASGHpzLVyWfgND6QB17hfQHAhLsrbe2Ht9o=;
        b=OTF2HYM/wO+zIPqKqEcLnMCyf5+vzMZjY5epCq7NhccwTGt+gcDs3o2jbbI2wQhcn9
         UGP1o6mSJr8uXAZAsqalAZjZBlzjeAKliIF3UlPMOU2Ej5xH9fXnJ5teTnvrMTCFZFmS
         pu+hcwon0M5KpAYj0jhIuIuyw5sXYxPAkbX+hlprXOH8/0t0CoITZrLk7rvWFC7Vp+0i
         eJbo9f7Svx5/2SBNlO8PQaba9+Gduh9JKHi/i7Da2wILwsurD5AK1Y7PNb5znj32hdN/
         hfXNfgdH3fabthQ5jHWVRRSnRk8EWWqPZjNqXHZcq8zvXpuAcNdtPAq0Tl/99iOkGQwy
         TVLw==
X-Forwarded-Encrypted: i=1; AL+hErHW3YPmrXMKSZnQJmOPynLMASEUGWSKIKpOnQ0B6SUIhM9+GStSwKC3gcepkqVh8yqIeHW/JvF5REUNwCk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nIjb/Fva59kZleflFDwhUnr/bapxOV5/Zh46op2+tXWFryhqd
	IbQ7TCiO9YYkCTT9IdANVdCRYLXtZ2mU2B99lHwXV9+OHBCxucpSuWeHE3x/uJmL
X-Gm-Gg: AYBFou3MwdPep/AjIEQRSROCKM19ZmlPmiixV66v1fkb5hZ6Uhezxv/bRAklgVx4PUS
	LskK6+1kEQbmEc5u5KaTWI+0kUoN4xpsrDYuLjEfJUVRm9Q+81jsJG7QfCS8oYYKbSlGb1zEJ//
	qngQqTDbDbOy5LNK/FqfUfqWRN0CqzWGABXHQbd4h2mYQVwnTEce9hC7/375KqPFk0ejOQ22PuL
	U1eSIYcOvwEx6lTFk/wTwZMmKVaSaQZmBUg8ikILMRiJEog35leIj33c1+FB1gSbnfi1oYSW/de
	ktK9yNEuyvuij+MPalaU+VdVtTz67eQ4TuQXevXnK+i5CXOTKPHScolzxWYQvmSB9mqF97cwj6P
	DtTARu4Og0+w4kVfRANf9AFFyn/ox3FYqBMhxzy95FG/HE2zaYCxBHojl4FxNsc2x2r26HGzDZw
	x813Sp3ydP04hMPX8lUH+poVeQjIl7rcpS5TDYNCKH4semb2DXaGpykZEKRpihLl1ecpLckWMYT
	pJCHBoKZAAfZ+d0Q75VbpQOWdhA15GSLDT53sZzYbr2tiOemNFlILkX822pS7t4tmi5hnfE5u3t
	vjCdKsp0K7bP2AnAjJieyz0B3IsJmvHpPWtNNir4Y6G+AuidkPvoJxmwDfwhfa5NCB8Pxx2uL1o
	4nTEIQvJ2M177ytEKzodk8KQXsc8ZYFiJtd+26suvFxwIOiZIZVbgPy2UsEJa2rwOrlaPet8LlK
	i24W7CZJqqnDHTSyuMMcE3Ri7eZI75OficWJhxmTl9DwxODgEPFZsI
X-Received: by 2002:a05:6808:150d:b0:521:561a:8e8c with SMTP id 5614622812f47-568813057e5mr726068b6e.33.1794280406385;
        Mon, 09 Nov 2026 19:13:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905736b92sm1019236b6e.8.2026.11.09.19.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:13:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:13:00 -0700
Subject: [PATCH v9 11/11] serial: 8250_dw: configure RX trigger thresholds
 for Octeon
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
Message-Id: <20261109-submit-h616-uart-fifo-v1-v9-11-3f03961dae8a@gmail.com>
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

Octeon uses the DesignWare receive-trigger mapping with a 64-byte FIFO,
giving thresholds of 1, 16, 32 and 62 bytes. Its setup bypasses
dw8250_setup_port(), so it does not install the common trigger callbacks.
PORT_OCTEON also has no static trigger table, so rx_trig_bytes is not
exposed.

Supply the fixed depth from platform data when firmware has not provided
one and initialize the common trigger table before port registration.
This makes rx_trig_bytes available while preserving the Octeon port type
and register accessors.

Select DMA before filling in the default depth, as before when the 8250
core supplied that default during registration. Thus the new trigger
setup preserves which ports attach DMA and their existing burst sizes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 257baab5a3ed..31045128dcc6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -663,6 +663,21 @@ static int dw8250_setup(struct uart_port *p)
 	return dw8250_setup_dma(p);
 }
 
+static int dw8250_octeon_setup(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	int ret;
+
+	/* Preserve DMA selection before supplying the fixed FIFO depth */
+	ret = dw8250_setup_dma(p);
+	if (ret)
+		return ret;
+
+	p->fifosize = p->fifosize ?: data->pdata->fifo_size;
+
+	return dw8250_setup_rxtrig(p);
+}
+
 static int dw8250_sunxi_setup(struct uart_port *p)
 {
 	struct dw8250_data *data = to_dw8250_data(p->private_data);
@@ -934,8 +949,9 @@ static const struct dw8250_platform_data dw8250_a523_data = {
 
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
+	.fifo_size = 64,
 	.quirks = DW_UART_QUIRK_OCTEON,
-	.setup = dw8250_setup_dma,
+	.setup = dw8250_octeon_setup,
 };
 
 static const struct dw8250_platform_data dw8250_armada_38x_data = {

-- 
2.53.0

