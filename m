Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA323557F1
	for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521280; cv=none; b=Q5OS5FGRVVyDUm9fW315kNBSPHt/8HwNcDwdZ9A4/cKg6gTeIEp+nb5Vf+6wCiz7uScPcsD/4SZymLlk+gk4PrdR2y5aANcF/u/Blsza+VXi0SQnDQ2Xq7rpJE0Hd22cTU/ONV2cEGeosOEc9xlBAl7IEavKVL8UOG7NqfrvzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521280; c=relaxed/simple;
	bh=omWUVkHfDgWK8/wVYsqR1gmKx3uRcWW/S7wsFlqvQZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7zY9/jN48sEJMXJ/AA8AJ6iLg+e5azRTy9qAn+jHuXNYN5fhchtiZWqGmdbOopfdpoEL4WQ7Ma/930XW+N8YoZgO51k+Jl3ZKbQKXXTVu/ngP+DCCowehdc9r+gZVK6kf0q3hlBdBUGtoT6vSnnTjYX87GR50elM4BgCy3fqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=TqO1SVDy; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="TqO1SVDy"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso3843929a91.1
        for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 12:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521278; x=1767126078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe7/bfwW61qpTH+JIS3AKR1VkqKbIoFXot2V67cYu6g=;
        b=TqO1SVDyDPy6oeM2rbEwUbThg0ZMdnWKh7T7VD8KZSzOa/J3kT4ROyy/pl8C/wyVsx
         87KW2ws4VZeH2LmCpVD56F3zdAx5JXs6BVI4CuP0krQwFRfdL5t80ZUQoSqx/9VjCZ93
         2xHRYX+ZNHO4M/4rPr+tVC07JSbvH9LFNrnBQ7xv2se4nRY89nnVpeQCvPP5R7bR74dN
         8ViTbRe6BIWhzI31DQmgEro4hW0FWUc++XgR7MG6fQJ7WiTyuHPokC+8mh/pV6Sq6piW
         ZgBIqf3KQjUSOvTNzk6HjjuoWV62KCEhAtinLcS332mSds9tBcYhX9IcAH44WscTKXwf
         1cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521278; x=1767126078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pe7/bfwW61qpTH+JIS3AKR1VkqKbIoFXot2V67cYu6g=;
        b=BKxvRTirxk3SRGJHqI7+sBN6/b4LWPGSjFfgB2Me7v3iwWVIAK5cvTzZdg1RnWb/+j
         k4kga8lQBWGiDAGfbg31jWr+wxD7uHXzfmvg7kFYTUYU5b9+685oHeWJFx0H/+kqHhi+
         lwZSO7kwLImwTZc1zDka11X8Pgy1+rhDpJUkcyWOIg3rutMCAppOyAxh9qBHJIuJvY79
         Kn5HqxJiJctZaQ7gKn4QhatLkDDgPBHKNwGQWrWlRPUe0svWtxykUrLPdEfrT4YlJ7p8
         wMr9fmmMAd08af4/ZW17OFNZ0mNIcegsnJ/70OE5nqOLwRJuEE4WHdsmkV5TMMDcQKhO
         exyg==
X-Forwarded-Encrypted: i=1; AJvYcCX125OSzpiqRT61bIfqRatkJJUacLFXh3rT/zC7yweuRvQbsxSb/rDF5nLTweV0vumLVnfKIlxrk+IxWQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYx3rfX6XdrUVbEvKgrYws8S4o58v6lSem880oyCyTp7FICdFb
	0+2kVb45bv7KE/n7S7opImXPMya1p9XtJTweFO8UePlIDDIA7m7HRM+VtYWrD+TMmhY=
X-Gm-Gg: AY/fxX7Gnola7+mc6JWmEUMwwslbFoCelDjO+05Ov9B5KGqeJO6TqFm9O3jQJSGuR7e
	0db+mS/42asH6lqKEo5cSfrvN3vnlClVCMUHM+JJVfpESDpvqYnUL7CVCaGC/Jeif0pfBtvKIok
	WQbz2Aa4vFHNux1UbcYmbtd5hKnuPW5q60ivNp8dXcLRc0zEWK5SMl63SjVa4/gHieqJRTrvzkR
	r0ARxjE8zAWP4Ki3CDPXZcGPdDW3LJmay4pn5Nao8mL3L9LjMfNEiKp2HiOEKX1qqwYXR6754jt
	TQhegEkTW7uYeYqM7eq+FSspRAiyL1h6yRf2R4uF3skzSQhE1I0tvY3gHXuYzNrnaTmkXGWyXhA
	Y3kXMYn9dSmPIkDGODQgTprtc+IhDVyCuEwfyF5Jc/rBaEL72OC0sGVt6qtj06Q1wbMPiUOB03R
	THMx40waZGgPaYCMOadVSbRZLDKy8BUlfFKsuhMOkouOBrtdlWZrxWi8HDlY50lFCiAwOdT+r4A
	hxyOhCI
X-Google-Smtp-Source: AGHT+IHeRAtPKwVz6qoPOdL+Osxtu3PLTheDOvUOr8YysaVV8Js4PDKym39wxYhmLqVHZ9ksN45wJw==
X-Received: by 2002:a17:90b:3c4e:b0:340:c60b:f362 with SMTP id 98e67ed59e1d1-34e921131a2mr14020700a91.6.1766521277662;
        Tue, 23 Dec 2025 12:21:17 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:21:17 -0800 (PST)
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
	mturquette@baylibre.com,
	sboyd@kernel.org,
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
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 11/15] dt-bindings: net: mscc-miim: add microchip,lan9691-miim
Date: Tue, 23 Dec 2025 21:16:22 +0100
Message-ID: <20251223201921.1332786-12-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x MIIM compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/net/mscc,miim.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc,miim.yaml b/Documentation/devicetree/bindings/net/mscc,miim.yaml
index 792f26b06b06..2207b33aee76 100644
--- a/Documentation/devicetree/bindings/net/mscc,miim.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,miim.yaml
@@ -14,9 +14,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - mscc,ocelot-miim
-      - microchip,lan966x-miim
+    oneOf:
+      - enum:
+          - mscc,ocelot-miim
+          - microchip,lan966x-miim
+      - items:
+          - enum:
+              - microchip,lan9691-miim
+          - const: mscc,ocelot-miim
 
   "#address-cells":
     const: 1
-- 
2.52.0

