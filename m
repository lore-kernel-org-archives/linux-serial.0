Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7033A9EB
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033634; cv=none; b=LXuisXt6jEirNHUnBwrcs8cBkoJVDErLg/2i8yLnkA79XUbDBIfbO54Vlg/pXJPXKFE6Hmi0QHVDDKCXPpn9YmBUShcqTnOHlBwtVlgbMpl48B21yc1T5CAHCRHVVX+grMAZYaS5O6SMqM4RSZV9oClpcmMoPB+w3OUjMYFsrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033634; c=relaxed/simple;
	bh=7jtkvldmPSo6tJBxZSibRZu5hmUTyLaiO8iQq/Sa4wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPtO3yFpZ/ValDVQe/OjyeGgGtmywanJLPvY1O3ezVToOIc/CDvyHlxayjjaeOBwf8ygSC/SC8qvWxGLVdatSmZpyTV1Gn9S38/AAER3eWnNFhhHLC85vtcNir/UFXYJf0vbewwdD2jmniGiSIdNimZoCEf4TjZIflZqL2s7VdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=u7HmGPkA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="u7HmGPkA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso74515545e9.0
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 10:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033630; x=1767638430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY5t/vT8/2JoNFBpsoZEjWJnrTyKVma3HFBR0NVkIKs=;
        b=u7HmGPkAkdP3R7rcUekjuNxY1rqjuIdNyca9I/XGM9QnG+kfzr1RniY05coFnav3Ng
         RYHUu+lqU0wDiflHit52ZG0t1bmh/XBC+sQTV348FEuYagsi0eLdDABPMr2PVkaD7inJ
         smarDUYRZ7OjWsdOyQ7pkBVYoLoQKrRfREcBHdttYvdam13AsICcjYpaIixihY848NF0
         4+AVUcKCS1vvv6tkvlnLJv5CroC9pr3VorsPqY0IGKUkVt2HWY+/PhFxoJpOM5MxrRZR
         rn0bKm0ktUYeG/Ov+a8MT9JGcL8LG7NbpQ5e7zQAkwYV+aLTTb3hvAKTdGWO/w9MZ01Q
         gN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033630; x=1767638430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZY5t/vT8/2JoNFBpsoZEjWJnrTyKVma3HFBR0NVkIKs=;
        b=oqXqxFdL0JjCZC1mM/Ue0X7KTkN3RBWP1nfT+Fl2fY7cgrUzUlTG4WenYTe5oAlBHz
         2bsnxRnLo5dqSGD2zM5OXRR1kpvcaLpSK7cQp3tbPy+GRVJeGnujmw3kYSmefsSX/oC1
         uBZLiWfghGca4EVttSLICdy8/X8vmM2WB9Pys3Ape/JsBt9DLUkbuimx2jMdxzEXSGDY
         Owb17N3PE3Wxzg5Idysv65D5bymw88fPEZYw+K0nlEEJ8UKMdJF6H2ZWflepeliTbDMO
         p20fgXD0OKQ+hwSSdpIoo4nG9ScSd6Tw1Fu1DYmZzLFPLcY49mwySToQlnv9yTcUnbu+
         7h+g==
X-Forwarded-Encrypted: i=1; AJvYcCXqzKCpyGgMPh2PHBzkVKNC302fd9awDiyBnGMeoKHN4nTiuKhZiJm/iWKtPd07o/liUPvGIGGAFgiVQ3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQxrYyDA1lJmDuqYCeXD3vi7qeLxpTQJF1HKzH/nQXxcQgYwp
	QHk9m6R7Rz2qLB2cqtWBylwKiLvOgsGBKcmjJmKlU8qb6AsebI0ZwNds8s9daoSCAEU=
X-Gm-Gg: AY/fxX5M1hDx5wDsd0epPsGK0I06I8zzoLfceZrjg1yqs4zEX5ZPsqHxcysPiE7439t
	6XPzxUeytm/cp7jnlFuRtBmSzo8Ev/7ob3IAWQu/rafvxYpcpdtzer37+YqKC7CdQiqABswRpg9
	XqsbjeLOtosXMFp8ZICO1mPVLJEc9vL975PrZp7yRjWZ61khjD7DZkIronuHarY/eUQdRHFmp2K
	i0BkqRrPBSq9w+LzjrJ/50ie/pqSp1pfyyg2yW5VkJP+3WEbVBkPASNtmMkzi7A1GNNyPEy4Opu
	wREUurIFLjZrfCgkWn9sUAKc2I0qCn8RuMkhZoLopP1PrFWW9ijAw1jC6oikP6zpYADxkYP8vGk
	WVGEcoyVz+iuwKzhymfw3sBhxzG1mbwDxbCjVuaNskz9wjrPf0U55eNHLBvKt/wa6ij6T5i/xUo
	r4CBQleChkdjLiaFCjq3DMScrsujkfciLW9mgfGpQfTyoH+4NvYntNbXZGa2C2iPUKkuerOakDf
	78eh15ZVug2xBdZyINYC/gGzlim
X-Google-Smtp-Source: AGHT+IHU5TUgf1GXiZLlNhFvhk9NZs5LXOVfATsL4H0x67DGWgTd0xHPjLFDLe/wLhfc9aOjmrDYdA==
X-Received: by 2002:a05:600c:8b11:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47d2d273999mr360424715e9.15.1767033630467;
        Mon, 29 Dec 2025 10:40:30 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:30 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 09/15] dt-bindings: dma: atmel: add microchip,lan9691-dma
Date: Mon, 29 Dec 2025 19:37:50 +0100
Message-ID: <20251229184004.571837-10-robert.marko@sartura.hr>
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

Document Microchip LAN969x DMA compatible which is compatible to SAMA7G5.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Merged with microchip,sama7d65-dma since that also falls back to
microchip,sama7g5-dma

 Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
index 73fc13b902b3..197efb19b07a 100644
--- a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
@@ -33,7 +33,9 @@ properties:
               - microchip,sam9x7-dma
           - const: atmel,sama5d4-dma
       - items:
-          - const: microchip,sama7d65-dma
+          - enum:
+              - microchip,lan9691-dma
+              - microchip,sama7d65-dma
           - const: microchip,sama7g5-dma
 
   "#dma-cells":
-- 
2.52.0

