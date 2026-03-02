Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017B361DC6
	for <linux-serial@vger.kernel.org>; Mon,  2 Mar 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450528; cv=none; b=SZovub+abwXL7foCIMqEmJ3W9/3aBRYGd6aLHko5FznKM1qxFiP+dEsHO+LU/Wa6hdzORToQfjmNJqhMRjVYsOq72S1KiZDRRk/NYOzsNbflLXWPGRUNYsj/QTD/L0W9icmxfTJ71G/m1LmYvcqhhn+kSsmzVPv5nvsKMtahzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450528; c=relaxed/simple;
	bh=oX67Uf2cuE1+33M2za+xbEhq+YUjBZnozzKI30MQNUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfBvlT9c2hIaeSjFA33z2oWTKuhKHZcoTrt5oHZ0Mhh7QjYj6abiNLvZKZ0ENbUfl2vOR6KyN08LTkjJ+bSTa7sg5aI/+8pu6UOy6v6v56h4n8Tm8Etqe9P2i4qWzvGxtmSYf4zqpZpSj8/Ij6knoq+yYBo7kW2wQCsqgk1KljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=LCeKqbO1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="LCeKqbO1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483703e4b08so37977435e9.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Mar 2026 03:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1772450524; x=1773055324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5eHw3BS810lHNeg7f4xIwnSQSat/sp8IElQzLbapwg=;
        b=LCeKqbO17rP5109OTJALG7smNOybvBTsEVgvkM3TcmGnYCcAzUN5fSoAOK1zB9IkmQ
         WeEeXt1F1GMfZb542AAlvPWN5q/DtUezGrgHUpwtGBrMw/rlyQHPclh5dFoA6h+K41jn
         XEM0uGw164ChBXSCR/q6znMhnkdqqPZlWBu7Mkq7+YbSaJtH+ULVDYO7G3DajKhF2Md0
         NNj1G2CPYwGVQ+9IqnEeU3Gv7oVuhJLyHQpbEKUKI0+uR+YqgSqXFhfYsNWPZzn2sMcN
         25nSYvtPqaHgedcPA8CIx65s1r3ilq/EnNxbcbzOL8eJhQJJqnlwOgqszGl24mP31upQ
         L2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450524; x=1773055324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5eHw3BS810lHNeg7f4xIwnSQSat/sp8IElQzLbapwg=;
        b=SiUagwnHgPbc1u8k7+j5BD6sjlm7zlH6rZN8Q94f2ePJs/8wzJVTiw/pSLTgJiGcgL
         jPvNTfIlW3mnVrcuq29YvH5MQCC/xHT3JrGmKhAQDDEuwGpQ51kWyKlwanmESUY7oHJq
         JSUaqlhwn5ntvSblRBoi9VtPSEFa48de+DWj4XrDS/R13h9mTNCyD1p/tltCTaLQdYKn
         E7z1v6PttstGLyuv9HkoH1WY6hXwYRCZvoK5kCj8dEwt1p7SKYMcu+FBQMxS4AW8Vtx7
         7BYiNJY09FFWOMXXb39bZ14kItEK+tk1gAX2VxdTFw0Td3bpbox294cOX9UPudW+Q3Bl
         J06g==
X-Forwarded-Encrypted: i=1; AJvYcCW8WKtbqs1gxO1EQIQrBJ+bM3+gJwnhYCJS/HJUMMO8cEhU4p/ZIG+qaS11hKCNQnfHVFQj3+csgC4Pb04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC44YMTyOSvQk9oXWrSkZkm+IWupDLSIFZ2qE3jjVInuoBxfJ0
	WJT99p8BHvVeoLlEBxohzlDI/mPBBGU09bMZz4bEdzhhCS2X2SoAUBUplyONj144FCA=
X-Gm-Gg: ATEYQzzPEWqADCB2nxEPzlTJGxn1L16qSDYb0OMHCp+vpd7TOq0pxkiqeySLCkfxSiU
	OuXJIph2lRXsrlRWtEvd7reNYyN0bcf1W/sNcR85pNuHuXkZikHBvX3RgXYb2qlJMiyC+sooqNy
	EMkh7SCQMNXbWknb0jNH2U9T1POZMDXUbbwBICcPjouaMVeK/Ci0Q/TqZkCrS7XHHb6gr8tVOAl
	gK4/1en7VszMLfPXO28q8BhnXkVkebllYWGM0Z+bv/jjQ0S7BVy+VRq/amtit7X4B1PY8Z0UlmG
	P2Hle81uvL3veF/3FtrDUEJu+P6YGupPTqMukEbQ8U12f2pAmxSMrFhOvXDoMXW6taZimjeW4tB
	GiwUYqFjO9rqASYcJ4ME+SG4fQrjb9RIYuhYk99lhIoL19B4pOHtFuqmj8cd6/bhdvagZphqRYJ
	PVU6MDlf5BzFWeBUxvL+VNG6ZWgeHlHF24r+t6XyBR3/HM40Z9Y0v5+Fp/gDHVsFBg5r+AJb9gN
	cu3G3rKi8jrtTjfWOwk4Pba7ISdFy+sybYFVrsTP5c=
X-Received: by 2002:a05:600c:c8c:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-483c992e3a4mr192566935e9.9.1772450523941;
        Mon, 02 Mar 2026 03:22:03 -0800 (PST)
Received: from fedora (cpe-109-60-83-135.zg3.cable.xnet.hr. [109.60.83.135])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm292493035e9.3.2026.03.02.03.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:22:03 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/6] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
Date: Mon,  2 Mar 2026 12:20:09 +0100
Message-ID: <20260302112153.464422-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302112153.464422-1-robert.marko@sartura.hr>
References: <20260302112153.464422-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x USART compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 087a8926f8b4..375cd50bc5cc 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -24,6 +24,7 @@ properties:
           - const: atmel,at91sam9260-usart
       - items:
           - enum:
+              - microchip,lan9691-usart
               - microchip,sam9x60-usart
               - microchip,sam9x7-usart
               - microchip,sama7d65-usart
-- 
2.53.0

