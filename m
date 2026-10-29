Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299656;
	b=1TJEE1AepyleklyOSF8Dt91AcY1ui244G+EW6+qk12QCy3oA1MALbaCKDxKEkmIyaO0U
	 aBIQSiZ8Cu0gew1sQMPybYIyVoTWPGmgfzhuewCzTWGnAwUQa8Wld6W2qXRfeOaaRxKgo
	 J+FC25+BzQe1T7gJgfeN6bih9taq2o8vBqBG7Tm7bXHu2oTpMhMrZR4bN7jUCBwELaAE+
	 zFbMinpgxN0PybAfhOjUw9FsETMvbfUvTIOOq9UQTQQzax0EE/RzrAF7dvr72Dlmkn3tn
	 qPLgz7vqGP7QTD7VtSFJ9kgAPOF2ejnaXMQ8m5eFi4BstnTghc6vIzC0+3eihRlzhqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=79xjx57HjwzmaHLw3TFo6BlyGst5sDPWB7FQ91YNv84=;
	b=tgkv5oxGNgJABQF+6e0IAG0Q0jKEwaLNVBJq2Pu/iSXPwWWz2RCgvPu6yaB1YQ/tqdaK
	 O6KOcXwCsKYnBqHp6Atp/jy2zog04gijbwYRVp7cNcsNffaJOuiqVkc9TXMH0BXJeASOa
	 rFaPjQZtDXAl3GRzvkrQrJWR48TCB9bpXIG9gIiAoPkLtmpxMKumvcw6MHQ3ewWtlTBBB
	 KX1pSHLID+btlfJmDfF8qE0zVF1uNIYiPFxNck2FWm8e42B0/qBns4tQld8esMr25nLhQ
	 toDbdVdCjV64cyPPOLUlaeQD3lnEo5KD3ickEadJVPvxPnaTu9uv87AJ32l8CsJ3Wug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0gLDIyi7;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED445606A33F
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 18:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED445606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0gLDIyi7
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-847ac7ccd85so1674770a34.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793299655; x=1793904455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=79xjx57HjwzmaHLw3TFo6BlyGst5sDPWB7FQ91YNv84=;
        b=0gLDIyi7Bah1ok5NjU3W+QnQrCgcCetVDDOLnLlhSnQN1Rvm/TxnOHDei2dNZF0EL5
         bmZL1Ez/VkXDpzym1vcM+APlpMcFY5IzWsahAxbopCebue9c5GilZhKDzvDv1rw3DTah
         d0umgizm5JiR9pfOauDoHhz0B2tA6DqTWsfK27iyZ181qfBRXbRxKJhJBHqM5q7vczTN
         NuGVn+qDWvFe41dzhNCRUe5RhuyfNEUTg17JxUI7Hy2A6z2mKksNIzXoEBHmvfcQRRGi
         FjMAkfzGzTG9NF0v0VMnydD5H/ttmpDM44k4xi9U/xJRhtLFzzhcMy0jWAwGmdJ/KqCH
         TC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299655; x=1793904455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79xjx57HjwzmaHLw3TFo6BlyGst5sDPWB7FQ91YNv84=;
        b=dCfSRF2YAbHweECJVshbNGGr7BDDTV+BZ7Lv6u/dIFKSL5QJxcUXOD8zYj6tomL3bt
         Tm3PSv/aP7HxrCUJLm4a11Ck9mT6Pdch/tTbItWdNVlu0ZDT+r+fZDipcR2TLgG2GYbG
         HBE/tD7v60zCN8L0XPnh8aam1gpb7KedlBE8sdLxmEspY0R53FSrdIGN0ErCrn2OWOgo
         /N4JEUbxXe1adegWuaymHFWTIwL42eTAFUggJcf3qFONhkOE/7m0bm5894Wfjm3O9Ze0
         0UZ4bLJTI/UukCnqdKSgVSnM1iUkWSe29avtOwgmgZQ9t9ti5JlqQYHaM4gEKgo3HRmy
         Qfkg==
X-Forwarded-Encrypted: i=1; AKwUvBxvqbyZyvTSu0lKtOu6QuRJQNsf2L00XwsKI5ut+wrp/AOanx5jzxxmky3GAcLMsGoCq94SK03qMVZXVEk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX5Uxm9SpPDLKQUGEakHi0CwCm6Tcrsj7GXXkTcjP6gtQclxIc
	yrWWw4f/qYSNqEKdKg275sNbeFB5m/AgNX15baJw1cxfZ97hQ0CqwT2e9FO7sw==
X-Gm-Gg: AYBFou2smcbmfeaBNsY7IxjdACj+XV/HGsp8/VZzcL/VsOuIYOEgx2IZQp/rzugmty2
	QnZL+peBw1lSGc60nZUbhxFw9tL9QdGgvuj8V0ivcoM1BQ0OBi19USJc47G+Z2eyh54EskuKJSf
	vBlYxUOwFacUO5xT2gCrDJkFxGcMKJD3k03rW2A+j+KPm86UPInyPfu4QWc5DFODmn9BaJETl8Y
	v5K901TCZ5d7s8oDH6PQAUVf7nhmzywS6fjn3KhhbLtp0AS/vPpaVWBtEAOQVyFsb8mILv2coOf
	EdrCiEMW+LBXbY9RozPde5hrmEjprG5OV/CimFjuHUwi/OELR7g4wnHcZFRW4QN/ghZpzaXgeyj
	DdGxW0w1N7L2SeG3FvujewfzYnDIpk7JgLUmPSBfiASKgfKIaZeYttgU7kM34h0hdTw4I34HSWZ
	PHVs2ikmoQ9dUVBEORi4GW0rGosnm8Q1qnkILMdUj++PDIAXMWKkszM9n92pLptP+gpW546ZpV9
	dlCOaypamBihFjN2/Z4tjs062I6KXMhdyGOrCzw894ka8wuaJlOHkMfYWA628WUgCy3JwwwIuBL
	RTvEtooTCAz7c8krn7MaWSgZ7wo4hWj0EQU9zYZFGYNj8ETUODz1KGkFeugWsmEiTS8egtAQYTF
	UuKxPSZBI35OqvofRUVQi96MTCyggx/95WnbUt9AyX9MEda7gioELFClM1FsANIHrpo53XVlbDQ
	RQE4xWwJvx1Vqh6idtss2PYLYCwnxuff3hCTOIdmCmsCQo7X+CCVEgf6t1jJmjlj4id9TaECG6
X-Received: by 2002:a05:6830:913:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-85d361417afmr94378a34.2.1793299654718;
        Thu, 29 Oct 2026 11:47:34 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cfb83sm221871a34.14.2026.10.29.11.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:47:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 12:47:23 -0600
Subject: [PATCH v5 2/8] serial: 8250: share the RX trigger conversion
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-submit-h616-uart-fifo-v1-v5-2-53b433aebbf8@gmail.com>
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

Extract the receive-trigger threshold search into serial8250_bytes_to_fcr()
so drivers with per-port threshold tables can use the same conversion as
the generic 8250 implementation. Keep the implementation in 8250_port.c and
export it for subdrivers.

Include the unsupported-table check in the helper and preserve the existing
nearest-lower selection and highest-encoding fallback.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  2 ++
 drivers/tty/serial/8250/8250_port.c | 21 +++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..1600f2e45d76 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -73,6 +73,8 @@ struct serial8250_config {
 	unsigned int	flags;
 };
 
+int serial8250_bytes_to_fcr(const unsigned char *rxtrig_bytes, unsigned char bytes);
+
 enum uart_port_type {
 	/* Internal 8250 only */
 	UART_PORT_AIROHA		= 124,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..fc3987b5a70c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3015,22 +3015,27 @@ static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
 	return bytes ? bytes : -EOPNOTSUPP;
 }
 
-static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
+int serial8250_bytes_to_fcr(const unsigned char *rxtrig_bytes, unsigned char bytes)
 {
-	const struct serial8250_config *conf_type = &uart_config[up->port.type];
-	int i;
-
-	if (!conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
+	if (!rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
 		return -EOPNOTSUPP;
 
-	for (i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
-		if (bytes < conf_type->rxtrig_bytes[i])
+	for (unsigned int i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
+		if (bytes < rxtrig_bytes[i])
 			/* Use the nearest lower value */
-			return (--i) << UART_FCR_R_TRIG_SHIFT;
+			return (i - 1) << UART_FCR_R_TRIG_SHIFT;
 	}
 
 	return UART_FCR_R_TRIG_11;
 }
+EXPORT_SYMBOL_GPL(serial8250_bytes_to_fcr);
+
+static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
+{
+	const struct serial8250_config *conf_type = &uart_config[up->port.type];
+
+	return serial8250_bytes_to_fcr(conf_type->rxtrig_bytes, bytes);
+}
 
 static int do_get_rxtrig(struct tty_port *port)
 {

-- 
2.53.0

