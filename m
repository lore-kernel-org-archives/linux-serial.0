Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC63803C1
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477313; cv=none; b=g31gSdIBCCDrKKsPB59HGilNSD6KWk1Wd85nHKpuxl+ACljTym91QUDFs4/EQdkOEkXFi/i7ytdWkzEYiHVzqtMm4pdL36poMVGOL3uVsptxm3FZgoScxUGu4q20tcxFybl/fKaL9WnOdsuGVQ4qCqRBlRYhY7UFiK2Z+12aYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477313; c=relaxed/simple;
	bh=Wp32ITHx7s2+X+835Jbu4gJ7F+S1PggViopmVDWASsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOIn1o5GYvl0j7ev3lBYk+B42U5Vum7H6i2PGMskJ4rrY08Yclim8wW5UUhAOswyrgabZ5Kn73dv9MBnXbfW2yXhTzIF9Uc9Mt1bMFNJf60AX55dGTl8e8J15Yw2y9ozJ0J+4G6UlxCrIWT0JVHEkDiaaV7VHkDrqY2Pqv/gtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=zqtLJLd5; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="zqtLJLd5"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1233b953bebso1973030c88.1
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 03:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477310; x=1769082110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6BNeAKcW11oL+iAABviMYbNNLfmxyGYsliVava+u3M=;
        b=zqtLJLd52zChUvs4oYWUJHIMhxUAmPvrUA/0RxveUEHPvgdR011hU/GyGExJrIAUtw
         ovZapknkgFlI5/Zy7PYrplN8lb0nEvwlrB2bitjgOHP/9PAg1nrZA9Fj3UIvooQSj2Eb
         aOmSZy9AaiWsrmQA8A5g+8gR30/6QW10C906so7KV/BSfppbdAkUBExMMWuejC1oyg8a
         hS1eVLAVKZ6isDD7pGVC/rjV+tM4j3B2ep3BO5FIQk93c4p82HoWhGA3oGp1gXkRV+Fx
         7lVupRmwIN+TVrcbFZYu3fb4M/QxwuuB4FgD5JB2r/pXEiPUEbhi6FRsYlGJffrqypV0
         R7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477310; x=1769082110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6BNeAKcW11oL+iAABviMYbNNLfmxyGYsliVava+u3M=;
        b=STNh9CO26vGXZ9lvVUBpTts7h7OXbJkJaash1Ip3Gsmf1hR/DTFhSkq5g5M4jRdzlb
         +lagOi26j3UJzBMnneMwNb2bOoqlQFZD9Li4ekQkm79N282ev5Prnnfl7PaVVuOK+C9L
         aByWUxyCwPAREJjEGyPnLM9v1J60LGGBgrpV384NdpjULWch9L1yPMoIJvsk2EeWM2CR
         r3TVjhGMV8r4PaHsd65v9MQ6Bef3acZ0NOcvxOUQ75L9aCeshe9rG4M1aTyr0rRbUcth
         va891whBTwWRvTQuNaym6ryEU36/aEo2MkVpyxq6YFDsrsNVhf4BVrS7bgS6g0HIr0yT
         oJ+g==
X-Forwarded-Encrypted: i=1; AJvYcCUsaPzf/a9TC0Hge1n+2EKsUZLe5RdL0VSmqgmKPOexa9anspbvvUjLvCy6oNqkWdkXJPQywQQ79CZD4e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxRMu6f7uacb7s5gFfOPMF+uUDd6iEUZG6+cVrKsTH9afxshk
	TkXfC2xSBt8W5R/M4oDn5Yaum6hdWWCoZn0JQbcNJ8+B5VBHb1yuHJ7ku56ovMV8Ndo=
X-Gm-Gg: AY/fxX4CLW8/0pbx76EGxNwYHRUIoWBlZMbjJ2mIBagSpU/zENNRCIxMZyr/lc/8roB
	3HjsAV6FJ4gFKaepJUlKFAK0VwtK7pmEExbtBY8V+TMea2WDapIcfVm8rImrHZRPb4z/8k14xoy
	8IA0Qg9CGDIBV+FzNojH7ZfsDZN29u9x+tx9wcoB/EdACvrFJaOcxovyfvEwjngiLJgRKk3/X0c
	VqxnEFxC/VpHfDCDXoqCBTYpWmQ+dmXaWtG6lYbNDiY7tfYxELYB4RiPDy8O2tsmtL42sLdbcKO
	TKpqfLr5qY9VqN+5Wr4mgCzk4+iMc7LbZ93gUvYXgtZSW9JArk1/IW4pvN2VEnWza0KO6iO9Jnl
	jLvU3N3w1/PlalySZ9biwF5HKvdpDRaDSPs+H8G9sh9wUI+dvFLfcyAvrffr9l6Z4JpM80mn05j
	TRcH4a12lJ2/L4JRYXJIXpZ9HKGL3JRRbf0xxPjrTBkETVoCmu0gUnTFfJ9sFgAwYT0+gDGZKRe
	5xjk9Bv
X-Received: by 2002:a05:701b:2715:b0:123:3461:99be with SMTP id a92af1059eb24-12336a38feemr6814416c88.21.1768477309977;
        Thu, 15 Jan 2026 03:41:49 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:49 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 09/11] dt-bindings: arm: AT91: document EV23X71A board
Date: Thu, 15 Jan 2026 12:37:34 +0100
Message-ID: <20260115114021.111324-10-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Acked-by from Conor
* Pick Reviewed-by from Claudiu

 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 68d306d17c2a..bf161e0950ea 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -243,6 +243,12 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: Microchip LAN9696 EV23X71A Evaluation Board
+        items:
+          - const: microchip,ev23x71a
+          - const: microchip,lan9696
+          - const: microchip,lan9691
+
       - description: Kontron KSwitch D10 MMT series
         items:
           - enum:
-- 
2.52.0

