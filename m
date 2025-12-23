Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62901354ADA
	for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521271; cv=none; b=T3Tf0TYzaibqipDM/uIMKjCxyP96/UGTmbh+W7ELsNkWZODWDTrir19eyoYFkMvgJ6V8cW7FbS5sAQ85ifrU6AsSoXpS7KAbky0xzMjxcJ5PeI+RqzZ26OrVE8ngABlbM3UVGdsbi1nZu0+2nP7R31n6y1PjPe8S4O27jikoiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521271; c=relaxed/simple;
	bh=7jtkvldmPSo6tJBxZSibRZu5hmUTyLaiO8iQq/Sa4wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhwAc8CM/+/rARVJnnUNXYaAQjDDDmYBGGFNseIxpRcGAX+pPwh+ERRC/T9YiLb3j9cCwHlaRW88kMRXGRsIBTcfWwI/kaN1KUScJ2PfdJWHkdsvZHIem6AS2XD4WIt5mLGeKuwd7j5D/5jl1e8OeMWE8atg46gdkqUB46BLHLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ojfFSlET; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ojfFSlET"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso57888385ad.1
        for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 12:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521269; x=1767126069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY5t/vT8/2JoNFBpsoZEjWJnrTyKVma3HFBR0NVkIKs=;
        b=ojfFSlET0cv79OaTDF1oKOqUXItgurMOgYcFv8b26PVp6292pJdfQ79anRb5B1+0uZ
         crU6noIRI5hrwH6+UBj3tgm9TBiCgBtq1MFeUM+P/kFaGiC3sxHi5NwmveHrG+90Fq5o
         +fRaB9u1u9Ldhg65JUonooSLko3zOgChDlBBUota2eUoVVNbVpEE9ZJhAK4YnlT13kuZ
         E8AIksIE7PjEyyrs7wStSwLN6vio4NMCgjATLzIr7LsdS7PcEQ/s8WsI174oVmnIoh9i
         daQbQa+9rLjpjcUf7Tgx8EBLVVp9f44DfK0v7fmYSVhOHs9bQMd6l9J1qZdOOXgjmz0K
         NS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521269; x=1767126069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZY5t/vT8/2JoNFBpsoZEjWJnrTyKVma3HFBR0NVkIKs=;
        b=ilj0tKDbG/eUjPGBvBnxEKrTNmPJBF9/1RbMmjhJxjwZS1PEEeBTSnZT0ypfO92Xme
         DeTxN8jgDXnRexCY2+/8yILAM1kq3ZfNrJ7uSbq6VZ9jE6oE5slFQceOaB3Of0JVCrrG
         lZd+5c2EO41UvhbvaoSO0TbboAgQWGLshHo8oqqfV5zn8t5K+/gC/EtwOqxSWYpaxlVm
         KSuRzHR5Co9oGRACVNKYNBwAlwWHRkhkWPy5e4txw7JLd4M6SImY42EkOV+QS2r1bSyW
         6eqnHZFltLbeRs1WtbYjcTS5uw7v2bnatKItXy8fxZut7e5O0Ew+Vx+pB0JPi56PbzBe
         rB+w==
X-Forwarded-Encrypted: i=1; AJvYcCX1L9Xo1PnF++4g1GBd3+LovIAGIeANArqIZdsn5lb+Tryx3Fdeoc7+ToQnJBDM4amXmxP/JxbVznor56M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAq2iU1ZObcL5Dj8xur7IXfNtn/IjzIfeQVFq9D2r3s/8lXbi
	JUCFTxC5ytUOi5JYAzFR4NIu7iYJuCH03wz9ZeJCWi1y/klituMnMu0MjQzis5X9He0=
X-Gm-Gg: AY/fxX64Wt5RUORNl9NtdGDnHosiqZyXHFHXVQq3PAtkkZryHzg3vl1+7kRaS2lrg9g
	O50TxomrdTTmG+n6JhVkf9gYYgNpfISv5e4f8UtxNpC3z4qDIFxf1WN6cjKYN9755eAsCs/7neX
	xXhnnugqLcUnbr/mlTZFU7fOYst2WxBneej4qnJj+/Dba9ysuTkQMKa8fQ6Q3b1BDVbSdWspl47
	ZqqbyZffIiKtcVpyZ7gXqkZ5QOuGD+iXI/vJO1a73kM+EYQcITdxb+Ok1RY8LLxFN0xskfEBapx
	lgh+LIRI7yNfKt6D77VyIKE8E5qKQCXuF5fWj/oTLFF12r54RZjbsZOxG30ZQ9lMG90QvpfhEqn
	yvPbcIbluw0fGnVy9iWcQHMAkSY+j3Z4YH3mURDWf2I49BKbOLbxJ8AkzDxSioqY3PCI/3EGLIQ
	+Vbz7R6KHQJ0SLawkMBE5zKvokwV8ujntn4Xv9xYpYPdmfbfbweR8ClaBUjeZns7herMFwf3aFC
	VbOvGe6Tuic9KD3lsg=
X-Google-Smtp-Source: AGHT+IG1vVzPBAn5k790jfykavL0vRFl8+h9Eo75I4DE3aZwMJ8QtXRL/RgKMb5SBrHdzfjqO29A2w==
X-Received: by 2002:a17:902:ccc4:b0:2a2:f0cb:dfa2 with SMTP id d9443c01a7336-2a2f222a763mr171273565ad.13.1766521268730;
        Tue, 23 Dec 2025 12:21:08 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:21:08 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 10/15] dt-bindings: dma: atmel: add microchip,lan9691-dma
Date: Tue, 23 Dec 2025 21:16:21 +0100
Message-ID: <20251223201921.1332786-11-robert.marko@sartura.hr>
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

