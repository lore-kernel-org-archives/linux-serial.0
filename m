Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339E3385BF
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033628; cv=none; b=eng8gd0J5TXHSiHKTtRJjT5i1U2tjDdl5gQ2bB5FgGE/IABbsfbUEsmLgZSE7ALTCBB2EqTtIAZpVL2Q/ucGo6NA1qJTMXKdX2+7jluWwuerp6fe/RJStFT6ZUP71D5IabDTSaoupgB5qPRwVTV/Zmdjhwl2D6lnMMNCPHmYVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033628; c=relaxed/simple;
	bh=Y4t8u2qiojJWvI6jSs6aku7/F91jF6sH7EKzFpxgIB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTM7lJ0xswX/gPa5pcmU1T6f1jMh3qHIOYyIUMbQ8ym7/Jhk9zQISFz8chcce3WuoHHT/IiWFhv5XizuM3BGmoSQcsKbgTD9+NIo+rFOR0IS2ZYv9Uu0C+xJRy52Hze8lWIO9oEkzSFgbwMKP2URqmJ/zVIsUaAWsaTGDjk6ktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=DTGNbyn1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="DTGNbyn1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477563e28a3so57267205e9.1
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033623; x=1767638423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSHOwUHbn+hH9B++ik+7Uc56KzBi+PoNlqJWxebInus=;
        b=DTGNbyn1RSBQrO0sxPeaM9ygJowJFoE/5rjCT21ixYEfmXuifBUDxBFEdbW710F9r7
         BzGQ0ds/Z99A+mHYr9XZSfY1ZqWHUgMzKIKU42UbJHATo25po45+0UrhGJrNOdvu+FnN
         zHyjWWkiPuJl4Zb15uDtY7Nb9KIuYtpsGspxS9NbgSXVoWgTKBsb/jNYe31Ezz30gGsi
         I6pb/O4Q6dGSnlbH6PsJJhy1rYr8KKVRjxy/T3M3BSyE9xpciJlHvWpQI353EV+Dzisk
         YHPNIBv5qfw8Bx18a9eXJf79fy5nyXJyYv+zmS3RcfsH+ZVIgaAexO6xlnIVT2cEXaM2
         rBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033623; x=1767638423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSHOwUHbn+hH9B++ik+7Uc56KzBi+PoNlqJWxebInus=;
        b=kXK409IkLeH3/5Ck90clI1kR6l9XGKNiioAKvbuAcUsAmKNuMETK+avRmWjjyTgcU7
         20qKaBaBK9yMV8d3WSurFKcavAN5IRjYpp0xdWScH9/jwPAhMndKEZBYby41x11A+hiw
         Zj/B6ip39AM0MGWtSmbC3yb7LSiwGy/lZO6+psNuzCaEGnzLe0FnggX12qfeV45pSuXm
         z2Tb6C4tWJVX8AZ4JHx6Jr6gF5UQ0lwD8lW12AUR6lqMn7QyaelybQ7/1DtryC9YGaZU
         5jfiFX2inbXqzU7wBz/jAdlz5ubC4dfQaykVZN7Zn5Fj4ubPjyrHSU0igBEAI9LIYQgM
         DRtA==
X-Forwarded-Encrypted: i=1; AJvYcCXkMBaw/cF5iKto7NfFE0IyjpGh1oRkAojzBHb+BurBR2buXcmmnDI8L80K1d4x6/DS5ZTzOPkzrg7sO+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8p1WL8iBYQoGtclnri2av/VDJdKDalaGYBXsb42KRBckOmCI
	Jay74SCEwrai3TmpOm6JWBiALmeKpEWGlNiFPxlZq1iTQETjetN3jrtEzod+Itte8vs=
X-Gm-Gg: AY/fxX4u+cL48V/FeiziRXaKPVj8GgS09gos0spZi9x63NqQ3iLvzr7QCQPGLGh5hHd
	QKEINZcF+GGrSs9+QZ5uK0/HnVP0SFx+ycPPu+/fViv9Uit6R9uJIyX10/TVObnYJpkK7vtBbxs
	YtDX0yRPpWsdhOT1eztRsOyfRSPCKql2azGGr19L6V2Tx9VNDPf9sZ33qJehybYmIk3aDCvk0Ii
	HfPqXL0yDF4qaNnN0j48yaToZKAuaSXFOimkFQcjDlz1ZMHcylVkxsMktttsakzDuc+FbFN9U3h
	NSTDnkwzMA3yfTrF6nq7My1UiUPeEONyV7JX93KjwrZj8z43Kco209etYW1S4BMTadYJ634Ujaj
	xYB0Gvt+3h8BJHCfw/eL80U5uhRCXQFGy+6sIAX4TSsQkhzIfsRMegzK2WUz9HS3bBVnH36l2cL
	OcybzYxB+eY1kz0uorndSiDtAZzAzG0HPS3OONwJukvIcQg1kygfbyn3aBHCKVJDiC75GWl8EEp
	Oa3s2SIFFhVvdBsyzI348lEAtTEg2owo3p1yXg=
X-Google-Smtp-Source: AGHT+IFdXHJQRkzLbrbudz/rrSLgg0wPVHDz1vodIiRpC++haL2go1AcyrpRC3xryHs5U31bxn6MLw==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47d18be89d5mr452022195e9.17.1767033622859;
        Mon, 29 Dec 2025 10:40:22 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:22 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 05/15] dt-bindings: i2c: atmel,at91sam: add microchip,lan9691-i2c
Date: Mon, 29 Dec 2025 19:37:46 +0100
Message-ID: <20251229184004.571837-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x I2C compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
---
Changes in v4:
* Pick Acked-by from Andi

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
index e61cdb5b16ef..c83674c3183b 100644
--- a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
@@ -26,6 +26,7 @@ properties:
               - microchip,sam9x60-i2c
       - items:
           - enum:
+              - microchip,lan9691-i2c
               - microchip,sama7d65-i2c
               - microchip,sama7g5-i2c
               - microchip,sam9x7-i2c
-- 
2.52.0

