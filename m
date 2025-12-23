Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0C34A777
	for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521218; cv=none; b=SBWCMGs3VTLwjWDZ4fLh4uyhW9RDjLRPLofZBHHKFmlB4yWkNYyDRW5lkp8O7Fn7iQ3XiB8DW35E5REGpd0U+36W25Ia/rcFXJNClaLK/8qkon95jddQzB52ADI6mqN+dGkDZPv3pVhFHygfcTfAqR2Hm+IVdPFIzMOvUZ/tSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521218; c=relaxed/simple;
	bh=GSmfufS+BjcFXAR7DhKTmRXgeyl65npdKjntCPPDfHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqK2ov5MaZ1NecH17doTShs1LSvh+FfcZ7X8Izeq2F5G7NxqsavyLVt/AthVUqgnjbnanTHD30fUWfbMO61HM9QIsPR/nX2KQObhdu2vf3Nsj+W+luYU/nLQ+zkvxgzJDPDCF1h2cYWSxwX5Zr7HUpIqnWtuLg1xYo8uqgdR6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mknI3aHD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mknI3aHD"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4489485b3a.2
        for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 12:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521215; x=1767126015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2FSF4N3N2MYzlByPoECc2cAz8v8tXyMKGpnQtUm3aY=;
        b=mknI3aHDk/xx6E1DXCAkhUtT53KYTa8H/fy7ZqYi5lMAYZ2pnjDOEBbpIn+PxzsEih
         Wi8gHCcxw6toR6SqJxa0bt8CxPRFrw2FGeuOBXtyqNd/OiX8LDNzXflhB1fmTCJggOR+
         YGkdiMbAf487Cc3/wOyoWB7V8JvpTpMJwDUOtBr7clyUt5ACpOC3y4DWtOmXN/0bgspv
         S+1LRRlkfT/LfRuRi8mvNfnDrTa7d0Rz3fVOwnNtuYqX9hOvYGnRNM8NwkprFzIiTiGt
         DCBGCog1PbUG/q40amKbvFtSJI3QV2PfA7L1Id37cDtu8ahGqYpYnBl3zRj+quKK05rp
         MSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521215; x=1767126015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2FSF4N3N2MYzlByPoECc2cAz8v8tXyMKGpnQtUm3aY=;
        b=pKU9NimsXNFg4a9wdQarXHfoVi611Kh1vjtoRNawwxNBhT7o7s2vAzkY25OGwnzQTb
         4K8OEbcAXuih75+HCEQ5fYI90QvLValwB3sHCjDhprWbhc+yAWImCuysDmpkQnZMN7+P
         Nxt9K7jDeuludE7Yj8gWQv7vZZ7IgaE02TUo+fq+arHjO+MpIcKxuV7TywmCNfHLdbri
         /4vTbPgfW6wNMiN1Eitc4J+r8rdiOiShp6XdjzoPKGaJH7A1/EbDEQ+OGwF9g/kaZO1z
         f600JeXdJFt3cr0iFqC/djkbb3CEV4hYTtaLxHglRNuAMYtcwCpI8fB6zI/eGVAdGXHg
         a5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWvnuXRMbfiAKWxyXNwIrApE57vkcDwsrN1tT9tesCyaIIdzw9zRLR+YHuWKinXDx2YIvhZ4vWVyZZ+32w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcaAR5GxAatoNgEUYT/59ndwoS2NLq4FVefdj83Fr4NYR0kWy7
	PFIHy/2dDdnExE/aSwWdA4Z7OpUIwD1vP0UO9wmUzqDpI5bkXARpSyohJYGuMuFZMA4=
X-Gm-Gg: AY/fxX5ap/CKS0l+IT2sTG2FlPLZO6k1ezEMR8y3SuWmZjevROp+A2RiziSybNR98Zl
	URELur/X/L0JwKRJz/ea7dJ74dkzISnd6qP9bhKOXdbIXD8WJfjCuFzJHsDcbITUwGDOo/7XJD0
	ioWvOvLgxxj4b8JMUcsiez9GcXh5CZ7/kOgaBfS37rPmJS9nX6n9wuYFP3cAhhekEfXYCxryCIL
	EaOaZTKvoyIJZNxHB0SGdqTuUslbkv1WT7TOGNABcKH3AdJTHg21X87B24fuG7UIhxOjDDJXtBt
	XXT4D9DDzkdpAJKvwS8KETT/D5GgZgjh1WAxGIXJ33LYsH6ZvxWvPh+yJ26Iybg57pm+u50005V
	Yu/zlWlE0qBSfpw5FdUGXGYUXj3BQsJ2CnYBr/C4n5iDNYDFJlpewRG2Dh9y2+aJPppG0eJPjVA
	MfUg9pSTfKKFfo/zg8Tqherfqz/2Y958vlwG1Jr4vycF2v82L6WpquDbSmTt3qHolSX8JPHV6oj
	aGgWLkG
X-Google-Smtp-Source: AGHT+IHTipKQ2GYkfIzCrgEkT5HgaT5cetpxH7RTkCWDpkBy3UcCKVeG1Kf0FvBM/eI9Sln/VDayPg==
X-Received: by 2002:a05:6a20:9149:b0:347:67b8:731e with SMTP id adf61e73a8af0-376a77f12e8mr16762772637.14.1766521214766;
        Tue, 23 Dec 2025 12:20:14 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:14 -0800 (PST)
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
Subject: [PATCH v3 04/15] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
Date: Tue, 23 Dec 2025 21:16:15 +0100
Message-ID: <20251223201921.1332786-5-robert.marko@sartura.hr>
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

Document Microchip LAN969x USART compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
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
2.52.0

