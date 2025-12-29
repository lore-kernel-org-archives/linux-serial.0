Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48F33987C
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033630; cv=none; b=OugiKkzNX6lShjhmQkEBQWMDcziEBDRoV2Of/SSLzAUkpikJC4YTzPU4fWqU6TUlW1bwKiZvAzeR5reI701qX2GZDKL3oMtE/g7X38mRq2ew1iUmhx/nHJkYBsqGz7InYjO4+4tD/bx8K5++7HVpR56gD7XPzTo1MhxQe7+ot6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033630; c=relaxed/simple;
	bh=zUvrtsolEdengocgVlyXQxoSJXOg4mGPqcC0PLdIbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc+Vwoo7egipa1vEvkZGLm3vaP7xDqj7GhKLhiiG7MGSbcy+oQHXUV8wkV+xm7mi41YjvWocBxhVrIFeph2hxiYCSZ/yUvo/ClyZKnMjAt3hgJtIqvGZ9kE3UW+sqUVY/oQHbUafmXEIBBZAdQ83hQGjplLb95ofZzL2Ke2HZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=nrSYBFVg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="nrSYBFVg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so68342915e9.0
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033627; x=1767638427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=nrSYBFVgIwnAefLeDPgYgl8LqPiDckGltKlnnW75XVRuK+1yY9xg3gh3tZq8mkufWc
         bhWiM36cUBWMUAHYQq5VxaauBN1JBIGM1CoAC8bv+EjP4ME/nR6R7Y2d1Atbm5cJQNSE
         YakDsZ/R1kZY+j4wBQsd5PAXPwYKwrwuFRZtmYDWxrtbnG27rLcX1oBpHJzbZkBOJeRG
         /O8465TNdb93NZorMxyrz+2AaTqkqW0Uztj86TFG1zFVqHK9e3/M7xA6e6pQgFYtDjDu
         S5XivWOem/+RsxE7b3hkn3aI+uUJz/5pGcDpvkkbhxo4xpt3Fb/AMTvy+Y9k6ba8G5Sh
         L9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033627; x=1767638427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=vYtjm7d94kVfMH4WPc7lPRUiVGiC2rH0vn7Ml16yeboOTY0jLigED3MXYRpLlCcfij
         1S1tZ0DCfr38HKsEwjGbxZCRQODg6gghTv7T8DF+3p2+HilmFX0TgTbVvuAQNX1FYKq9
         uAxn2FBZXEIyDq62VdrZPVhpKo+voq9dAV9+Lz1mkEJy4e7LEtVKKlJ4KbimHf5pquFw
         IX66uXcJYuxek8ftfRwBm4+34irW71wWLkk1L5ucMl6B4KAb+MRgxi8V10AlZggLG/eh
         TDewt4JYzMQMq4Gq+6weuPIgbp0A9mQzFkip8itv8NaXCdaTnr/sdID5vzjlpdGsWxoy
         YCHg==
X-Forwarded-Encrypted: i=1; AJvYcCV4P9RZcV0QLtFek1VeiJl2TaHWMOHEMeNKI0XUf0fPNQqpSPJn3gytkGORlPUb+PrgE2wVib/nuB+RlGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQ2g7iTDdWpBdfFBZzhkzTXGi5CcQuaSYr2hj2hxxs5k5yDnt
	teA77BvTVLBfrRSOdkU5uJ0y11GvK1dLaNdzWZJMJDL18kfUVfNMyw+cxXgCEv35Cqk=
X-Gm-Gg: AY/fxX793UCR0q6/CtBE4fgzh3cTy07OlZhWBtRV9Jp+MxMRLy3MMcRPjlmiuBGoC9x
	xNte1swNzY6XqHUtSE4ta8G/NJ3GKehcv7eJt4l38KliBcM0oqm2+mHRDS2hWx892gW59bXEimZ
	VFvMjWS+90hd34yeCIHrvfeWVqU8sLez+iFq0FHI8G0nbxWZR7XOt4RAk9ScKPzeovNerBJGoEt
	2NMHqzccwseo3mdsb9GaAPiI+QXgVHWStO9axl71b/TQhH+4Ljopu+Q8nva79mWHqZpvKCr0z2g
	hFDDAjDSxkWvpfsjPn3wvarHQLIG/e3t7FM0jKguFC97rhHWSGNbRY+VFKo3NofxboaHj8opeIo
	+MZsNdrTfrgYyZ2vyTZPQB4mXt/ZJwEF2fbEP+HdU/H2xsfxLp/D2QfYYENXhH2AcmJi/62VnU6
	hQN2wT/v7EuETKB6SPWdaSzcQFel6nhVrcnMIvkvYubUShQaKLBhG0rfNaQk6XjKv6q6RKkNQSM
	EkSb9uPMeRE2jacGwx4KYvI93si
X-Google-Smtp-Source: AGHT+IHcFjQCCkIHzURsiMd4ZffbXQCjBanKlfgaAMAIAjZSkOlosZ6OaPn7ElCbfUOqooZC1IjlJA==
X-Received: by 2002:a05:600d:108:20b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-47d1c038664mr255230805e9.28.1767033626661;
        Mon, 29 Dec 2025 10:40:26 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:26 -0800 (PST)
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
Subject: [PATCH v4 07/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Mon, 29 Dec 2025 19:37:48 +0100
Message-ID: <20251229184004.571837-8-robert.marko@sartura.hr>
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

Document Microchip LAN969x AES compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

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

