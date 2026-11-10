Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280399;
	b=xg0ZdqXZjlBm1oxk6GVQzEHBmi8+NkGNk6zWJX2ZU8t8IKLhfl+sMEPy+BJ02OPjQYRK
	 71bi64EJbbJAm9jP/2z+GzEEb6Zu6Bfz0NCW7JiUgwi5THrTHGTE5dNnFRBX3NJSpP/Bz
	 hENZkn2XZghl/KwnKjuBJxqAVkGlvg2Zm86wLDKtfwQFaMQyimyqBZxZJxgrdcO6K2d77
	 gJpdTnreM3RGdm/FjFWmrFl4PvwxU9zHT6wKX12O2QOtmbN1cML+DzuKNDQKGCU3hIewT
	 IVAQNjTT53f24OyUpPlIL6Tv0FhetiROC2HTy/l2jNxzI4Uq1v/TzERVsIScvxF1amw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9v6fhE64vJST/e4wIKc/qZZ4G1qcfWVja1/2g7y5JFA=;
	b=R+FgHHC/WeUf5NdVcH9yHV3NMSUzqVeM2mBGriZ9XLBxIYDBKludC4pPiHTJ5Cco7SjG
	 ClWgb0RHfMK7bA2ffwptUt1UgwTNMerPozqabnXRvpBCBYUezLjuRaTk8iulql+IFtrM7
	 b+4IUvgu7rN80f9Kq/b3NBtuJUOydX4/bhECstT/k2KiwNtY3Kb8IrSq3I5RGQiJA9In6
	 BM6uzISVUI9gvsQGd4STSDEBgRrNPDD6LIYssqduqOXBVrom/5peWgiWi8E5Eq1hZZPCy
	 cVxUxeBCHpTABa+lMnMG6CT/RRZgWAH7I3KGIFsUeEHt3jCb/ReBxh4bIwJNMOXsp5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=axK08LBF;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F67606A339
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2F67606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=axK08LBF
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-55651e7de9bso778494b6e.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 19:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280398; x=1794885198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9v6fhE64vJST/e4wIKc/qZZ4G1qcfWVja1/2g7y5JFA=;
        b=axK08LBFRuDFSSWcJwC1jUIQaZGsGrA6ISY+1LrR2QblHAU7lPcHZkLb6BfpEGJX5d
         ahV7MoOLNdF+fqNCzn19P6FXisZhnHLKcpJ9FOGOR32nAzXP87CcVvQZfwPSvH1wosKz
         sqoerx7PTEPK/Jn6mQ4EMF+0g8WXidCeo0Jxjz4oikLE79ntsaMB1k0YDC50F7pYX/k3
         tDolPwq9sg04NF6uux87t0z8Gv6u9r2cR2eA2/grZ70wNUKWVpZFp4AhvdrkPYn1HGCs
         Z8f/BwB9y0iIGVlPLUl9mcW4M4Q7oamEbEHw4LXPGE4Ibfb/40fN5LQp7YsNH3/Iqq6+
         6p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280398; x=1794885198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v6fhE64vJST/e4wIKc/qZZ4G1qcfWVja1/2g7y5JFA=;
        b=Qi1Ouv3Ewe2h6ON6TZfTXWCl7TNGWQk3UfPmm3Q2JrqRuf41f1HYbDshr82Njvzb6t
         CTWMspaJDO2JImXXxk4Vt62veyPoHIuw+gN4vNoEMz0H28aPW4OKQdcgOQYLrJBHI15j
         dM7a7eUowsxE+y0/WYAmWA+MNlaHW+wpzfJRyWnUf9RzPV7WsvpvMuueJgaLeYpzhTEm
         GOpgBAxBpSP7FQV3XTXUOgmaxF50M4ZUDA0TrVYu+veO7nOWC2ZVsR3AQQxJZNuKl4Da
         1ohZJzLk+k7NRfXyoUwWxM0b/DuJ41vWLVU7LWmLwkScsUQ2A7QtwDwXjybR+yZWUpGd
         UfKA==
X-Forwarded-Encrypted: i=1; AL+hErHS9zHa+bTWrjFh4mbsnLP/cPdr/nYXPeXabVKwl1IRCaDsto/iFX/UvFeYy84BvG88IEfU65frQwD79qI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9B5et3mVXYawncRbgiX8lucnOBNhrwiauuljrgGfuo0qQyXzRt
	1hP1Y6ltZwgEraKJ3/0LgryfCad2jXd8RGQEcDK/wvVMGwk2EVo+0JJW
X-Gm-Gg: AYBFou2aPaU1rrcLHzjT4XZCZl+a38X7fsqUpGRqID4Ple62AMVE/SpNbVHUJhfoFpq
	ZgULK46kjew3Of1ceVZe8bKdGwYh6INMxETGvVWBx1clWcuSTKQR6i5fvoZu3DwL1P2V5KeagoU
	H7mL83ObOMI6ZCqF58/POX6aZLYgjl8IZyi3EGBf8AJWC/QM0EiQKgI34rpchFrnmaguvpmjIq4
	j0qP1cvXL0wQ/bWetLW6BGo+RvGfLPe02uzdB7qBuTw0qeUUfTrkcKl9ui+S2iru62pFJMMfAMg
	nH8X9hGf/rg6SrqbbA8wUOUnIcYg3nnvKBdPzHOCB56Fq7jvThRmGLpMfBnSsoiUKdECOLW4mOp
	afKkHPW/C3oIL/Bv2DTO6s4yRbgIAxhpG4nE2lOmdVaJ07top3G95iy9ay1chTSLAysprcE1Oyi
	y3JzDJdRjF0R0ieMdIYGBUHFdCR3FFdwDifqdilGhIBxzJEONC6bjodWSG8x88+mlIdC8QtahwL
	cCEh8VF1N7AZp+Ap/0u5I4twmJeF8OzPYpqNPrOO8/gIQZBo8B9Ty/eTbDwajHxsoSaN0WnIiQU
	uOjz5+ZtE97wmbsL2B9Eixbxr+g81+qH2gpoyQIyra1UG+dB/k33W782rvkCNk3fxw8EwexypBu
	agEAAZdzhCknMswT7MpkDovT0daU6lXbyKtNyE24Db9Hg96s+PvIu5Dhj8rB6Mlyy0IJTpwLwzO
	19UFPqEPGERzMEmobKmG7EQgmloPKYE01Z2ZSGsb6gA9pu8/QLoESghHXmV6CGp0VXPPSGBam7F
	g==
X-Received: by 2002:a05:6808:3c48:b0:568:2e:531e with SMTP id 5614622812f47-5683cdcd52amr1079208b6e.59.1794280397927;
        Mon, 09 Nov 2026 19:13:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905736b92sm1019236b6e.8.2026.11.09.19.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:13:17 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:12:54 -0700
Subject: [PATCH v9 05/11] serial: 8250: expose RX trigger controls for
 custom callbacks
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
Message-Id: <20261109-submit-h616-uart-fifo-v1-v9-5-3f03961dae8a@gmail.com>
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

The rx_trig_bytes attribute dispatches to a port's get_rxtrig and
set_rxtrig callbacks when present, but the attribute group is registered
only when the port type has a static receive-trigger table.

Allow a port that supplies both callbacks to expose the attribute without
a static table. This lets integrations such as Octeon provide their
FIFO-relative thresholds through callbacks while retaining their existing
port type. Require both callbacks because the attribute is read/write;
ports with a static table continue to use the existing fallback handlers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 73bc9e7ab703..d87e2b852c3c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3152,7 +3152,8 @@ static void register_dev_spec_attr_grp(struct uart_8250_port *up)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
 
-	if (conf_type->rxtrig_bytes[0])
+	if (conf_type->rxtrig_bytes[0] ||
+	    (up->port.get_rxtrig && up->port.set_rxtrig))
 		up->port.attr_group = &serial8250_dev_attr_group;
 }
 

-- 
2.53.0

