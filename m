Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29B336EF7
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033624; cv=none; b=PP+pFmdBUzrNN3a581dXia8cGJ6cpraUgYBkhpSYkCjG2wnZHDvPBH0z58veeeT1PF/SziSzM4jLeJIpsgadwkflzxcIX1VbUYj3qkL5XKHjwSSRuGSIkYPwR437gd3KtIDf5WOYQvDnGFH50Jfmhl+QulBQ7yvYsmDlXbjD8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033624; c=relaxed/simple;
	bh=GSmfufS+BjcFXAR7DhKTmRXgeyl65npdKjntCPPDfHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBh8CXILq9cYEjEGzYowqDaKg7Mv0IhrMWimufU8uQhNs/eRpRpmfal6uKr4tzblfqkId24W6ZyUvjrGQUmrSqHds+Y2qAiLWZSt63NcchxFTuYzr2xa2Y/7qcEQNpWCVcsayGcVOf2NH/OS9BxpCRdFZpUMYDLC2dgHq71xKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JcqlzjRA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JcqlzjRA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so44613565e9.3
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033619; x=1767638419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2FSF4N3N2MYzlByPoECc2cAz8v8tXyMKGpnQtUm3aY=;
        b=JcqlzjRAY7GYd7DXROYgWaELXWB9Ssktmv0mSGBMky80lcqfObTvF++Aws/cnbhLIt
         yMn5+n7PQsVaPG5S0nSJdGjAQv+rbOP7HgcdcPpJ397mAkKVT5uX3fyEiZz4iNDImAv1
         ygQjSfkGsJtE4BH6mibkK5llo62IgL2R6umMw1dy0lu+we47jagIw6mQtfbEdcJbvIFs
         sj7gIiiZW5UrWkm0ZabFQQS5bX4/iAVnhv0/33iHD3qs/a9XjKvmtSqSoKgynE0Fb5bW
         zfOQUkXxivxUuLlwihW02aUZHmiajEMBEq4a1P099s5Ia7Jcqgyr+cJNoEthuSEHRpJw
         8pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033619; x=1767638419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2FSF4N3N2MYzlByPoECc2cAz8v8tXyMKGpnQtUm3aY=;
        b=lrv8Br16QMyLrfyxbiuQTbFo9Z2NkcbpEfOsQsw5ZNAZ3vR0FT9wwttfQa7VhvlWNq
         Kf0aA5twjYn5mcdSLp6HOPudfdipCx3xZJjHNO/IR1wXvK9JYvWtYI3Qs7FNt1CPVJRT
         V+XTibxU9Y9lljktE88UegkfJfVouRf5wKAgZY/ATr6rye35tdE9DN0beZxfgSjrI+Yj
         3EJZj+j4DoIOKmoQM+P/nWOWmvh7y/HTzqs7v62nYlJcWyt4UnUNqESaJ99FndnCP075
         SP8qgr3BF+i+ShLY83/mczcc1AHRKMQyn9rE8QcSyBXrMW3493IukYoY8DRmuM0tCrVi
         lQYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5+lmsIY5QQzSFJ4kqS4aCFtRHk+DPWCbCiJHMsGr8bm9UQfP0hRF/yDfpC37B2I5aUHEkb+A0gl88SWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6a5KP8oLlm0KhQP5C6cWoZ0m3JQ4pzTS5s4/Q4oJG1EuvlMpy
	yn4u1mPxJNCcExudamFAqJ/adVV/62WleYiXnyn1E2hqNG92cfj2hdvfX+eKrGxap4Q=
X-Gm-Gg: AY/fxX4clwqBIu6mRxKItjPr4n2TkkahQ69L/si7mJo8MacbHk4aK29K8SrMYN4XjGO
	hAOHF6Fj9YYupECUrFTQIGDRZd872p+bjmFmi5+jK/CkXpke4ZB1bwocms2tgeykPL5guQvgNk7
	W6UtW0lETNCrhvyAFwNpVVdtdTMIe5OoCO2a9DqFr7YJ7F9l8QmyMoq0NHJZE8lx0YSfyh+q1Fz
	8AbM1UZ88M+x8Inx6ZjOeFtgx+gNvJ4lEJ1HMiaNEzF62sVEVaDwZL3+iJPM/YTf7VproPuKyL3
	4o7zHGJnnlYDLFxaC8v8YH/KoXlOM+SK8qX7wbPQm1YRLJreip04Tiqv3eS8SQ26Iy7PAXcJuxd
	JxDiAcWam7lH3lbKqeoApNw9EKuvYkLFM+jWiX5PPhXpr8tuECKiUlBUDmEUXm5MDwBzK+zpffL
	vTYbSkneSAckfkqiMK/5vPfFLnk/m7pFDUb90QZPi/CRDhsqhb8pn4Sq63uO0QV93G/OT2cjJ6+
	D2yOme7iJSfm/Vihe+qh7XXzLsE
X-Google-Smtp-Source: AGHT+IGouKdEkhppybsCuf/IfO2U2/Dz9wh0+2E3/5N4x/PhA0Nd7PQ1c14nBgJEnbaurS5x35/GCw==
X-Received: by 2002:a05:600c:4e90:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47d19557183mr403585065e9.15.1767033618979;
        Mon, 29 Dec 2025 10:40:18 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:18 -0800 (PST)
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
Subject: [PATCH v4 03/15] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
Date: Mon, 29 Dec 2025 19:37:44 +0100
Message-ID: <20251229184004.571837-4-robert.marko@sartura.hr>
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

