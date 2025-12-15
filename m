Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA7336EFD
	for <linux-serial@vger.kernel.org>; Mon, 15 Dec 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816743; cv=none; b=dONDTHzPsLn2XAdgmM31AcinUOr0nyIvyGGWoRICfoFkYnsuZtfC1elqdJL9AiekZYE1aml5/IVKcThNEN4lGsYeIacTg16RtgSzHZ92vWD7i/MCvRX8+VlkLU+kxmeNa5y0OMTyu7KzHlNH2tAA8n987YUtsWa5/omJGJFyg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816743; c=relaxed/simple;
	bh=H5qZHJBlkQV6+/j+zTVqie7Q24nFHuF3MlV57DgQSPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRgoOYa1bWvBcghAjkElYRUYEZQMACbs/AQkdkIqCnD7uh+yMJvyi8PM1s0KinsxK9eqlWXRt46O7IkS+h/XPlJRva7pn29njBY146tJ8H++LEKY8+D0i5QYdDtj2FG5FJuVRg3FpmJvbd54nOc+6r91Y6kz4OOqHaSmlx6vuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=g+Jpw/Rq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="g+Jpw/Rq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477b91680f8so36978575e9.0
        for <linux-serial@vger.kernel.org>; Mon, 15 Dec 2025 08:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816733; x=1766421533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cvy2LXuomfpj1nBing2L+jv3vaShIDCdMet4k/EboCs=;
        b=g+Jpw/RqdSE8R3RrrjQvhbjLiVU5JJvGAMD4icDPe28PPyf9q7p33NAR2brta51Jk1
         vhKfrzJqyBKDndGSaKieS7beK81YB610auUCmT+2t2R9OxgxySm5j6UcXqt7vDwr2yca
         IuvDhLzV7LpgZ2naTmCudKK9fP60HkJlmNpO5/Svow1GgRTRosFh1KiW3zICe/wl6SKe
         gjELLThAa/7h/I8jFCkxujmPa2VFPMEilRd1q68bEJMPgd/hEtLuCCXGcHJ6yfTsFE3e
         VjMvyu9I5um1nsezeE1uGkkQJcEcPANF4u/Csjni370le8TjbMdqiTU/AQK+gb7/fSl9
         q2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816733; x=1766421533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cvy2LXuomfpj1nBing2L+jv3vaShIDCdMet4k/EboCs=;
        b=YsO11Vh+PdC9NzhGcoL3I++UXNuCb1ayg52h6cLhw0vUUPfQEwC5QF7DaNNeT024nx
         /EbqgFhKUD/1+VmWUKxdyP8A/GnJr7StPV7YkpGqZiL+xI94QD00dRjgsYlZa5ptLDNq
         lGIokg9/yIWJLJWeybpaX6JpFVDy3U8Y41oNVN9KDVLJNNrdQ2sPNr3sSxYal5twGld4
         +h54RReRpf+/MTqWifqcl2JozRCc/Ijm7yZPXQqev6XIYSq3fHlaG64hu+b/qUWq+fUE
         ABET7LBgyOD1iPg0oS9k9yacinPsMf+EZFRCGWHynmrby4gAlcywLYcEheCylnLsg699
         QK8g==
X-Forwarded-Encrypted: i=1; AJvYcCWQEshfMR8xsZaBDRGHS9bHW38UoSC/rkIHmu74Rp2tCq1Gn1DKEd6ZVTsi/uopSKpVRWxdMV3TgQTQZmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpeI0MSXbOMcn6PQ8QyZIWAmaymepuD6q9v7S/oxJ8gQKgQtH
	MKh+lZ7uaO023rTzqh+7Nkcz0wMWsZnRj1YxRu6M1vyLMgE+vR7A5Lce9VujOBSNPgk=
X-Gm-Gg: AY/fxX6sAXOHYZ+KoURAi/M1fSF45GZxwhIZZy6L9N8b29FWF9eDF2QS2hKzvGK7JqC
	ss9CyKXYTuZIamD252SAYa/XU76MI1y447ZWl2WFfvAHjDIxmSK3CeOfaD8ywhSpinNASJ4p/zP
	5g4yYLZEVreufxFV7YaWmH/tOtwkX+PztZgYDRpQ0MRnhIG2qH7qp3JkVCO6DCzs9CUZixZpdEg
	7v1UmmHYEaDTY7DRZo88MFzDwrMlB/I6EHn6L859GbJExLBZAt6nZ/zJx7Nsrmw0bkqcRNamMa+
	/xoINAccg5/oB8iQtA1fBIZo6lxm5rK4krTQh9lImGGh3ggcbO6YYhLhmc8oTZvdUPrA+Ho3679
	JzvDMlj8fVSDRGlADMFnPj9zmXCZeZxU3rbPdCh5r8L8gyK988/GcnIym0xIiJKaCyus0/FODKQ
	6HmHHjadp4wX4V22VuMuf362sAE3kBNYwh1RH5HZWfkzbM
X-Google-Smtp-Source: AGHT+IFiI7Ni2LKcVl3YPoJbZhPL5dwoIiYSj1m9w7GWGjr7ZRqjP07iguNywDfLKiIq9PsRU4kDWg==
X-Received: by 2002:a05:600c:64cf:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-47a8f89be65mr106452615e9.5.1765816732996;
        Mon, 15 Dec 2025 08:38:52 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:52 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 11/19] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Mon, 15 Dec 2025 17:35:28 +0100
Message-ID: <20251215163820.1584926-11-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x AES compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 19010f90198a..f3b6af6baf15 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-aes
       - items:
           - enum:
+              - microchip,lan9691-aes
               - microchip,sam9x7-aes
               - microchip,sama7d65-aes
           - const: atmel,at91sam9g46-aes
-- 
2.52.0

