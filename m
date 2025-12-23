Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9535294D
	for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521263; cv=none; b=BKzRoUgjGWkMLw1AmrBs044QwC5ZJU4BUUHXw9XsRlbWEM3pEqHe+1ZtxvxKH519a6We47BuTuQbaG7ZqafG7YFPXZwUnb3SMUGJ/hQ1NUt2gUSdSxxn3LUNw/slWQedeCEgYjia10yw0RkrGsBtyhzy7jPBd34GT/BOIqH8Ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521263; c=relaxed/simple;
	bh=7hKH5EzmH1tw2QTQXNXPEJl0sVHK/le/PcpUxmqe6fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bake5IgyQR2MDvnanwUbRG/JR3nXEG1k6Ga7lyNUZkSv01EbMd9B6yz2/LmKLw/1O29Uuf430EbmOA7U5CTnjOw0onfwprA0fb0Wgxb9RWCGyUa49Y6BYVfuRpw2hHoaSe9oFQTdgHkSwEfim2g/nJDkAeh1m6qI2D+RtlMyrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=qEXm32uj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="qEXm32uj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso5382954b3a.3
        for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521260; x=1767126060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=qEXm32uj1+odh+mia+XgDAG39bxsV8BBnWSP0gbyH5RJhUfEzyjInuhiC1FtX9Wppx
         KLxk0YDYruP0rpIpgefdNHqLi8+C65Db06vxmizhWFJNlUeyE4PALzO+idf0NA0jEvMt
         4bfGeG4K9boAoeBljyhuYdHQPXx1fzDNbBeLm+/ymuEu2mywxvu0nFbFozqKna0aW5o9
         UF/l+z+RE/wWwKcEoAMBfnOLbiRWzz5O8Ua1eIoWr08agzCuSQBanUqTE3b4fvbRKl4J
         RwJDjpDIeBb/IhuLWShFAWC3/IHBkQBxlolO5/7LijryExtWwxx8zreGCz/caCv02scj
         QTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521260; x=1767126060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=k+QXVHgQjxIZcYdDWM6DjRJpkmdJp2agSXQoIVUzMvyu9HBJA1qgytYmsMi+5SzPie
         BvjZ7lfc6dUyF97OwZtFj51HsktvIWMhO4bHZVtkXhM7O7N5Q7nIitYwtYr5zSfBkjzG
         4escEq512bbuWJFAUz39/4sE7ZNmV2BCyj9Ossc46vsjOfSAl4l87kFV4GEZYCclX7Jn
         v052/weV2F9ZMztC1iSmh1S9R7Gk9WNisMlUwg36Sfs6z4bT1WPihBG8Y7nK+noGS8yt
         uOtxc+qpA6YkGxgSuWwTyuLIPrKRHzUCncE8jJOqE0gKTSgBbuZMqE8y8G4ndBs1tC3+
         IGhA==
X-Forwarded-Encrypted: i=1; AJvYcCXuFJiEiTBOZM0HQqF8/85DQUNO075TcnHl/fWe6yN2xbXVybcttMBVdgs32czSTuM06mAuNfAq6zHQ3SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmHe120I2TMcmeya1E9wtGjw2EtjleCPRRBmceuWJ3i1MQEP0
	ASV7nExEeQahXNeqolCSEbGSAWc2rIGFivUMtS+Q4v7IXl2s4sWqL4MI6i1f8gyPYBE=
X-Gm-Gg: AY/fxX6vSvgXEQCf3F61FK251JR3g/lp68yz49ViNOaIy+6guEr0NtyZpdzn5iPHrTT
	jqDaCmp8zwqSJmeD4ZhNK5den1fEruHXv6tfnnnfbIyLbcXUyiz/0KEiPvLe0mm1b198XEdW8Ea
	cnW5qhvEqf8WRfRZiaRu5peJ6oCe7S/fKN5gpA/fQWswDhg3VMfLapeM/ew7li5sQOvmPeZWSOw
	+v00ueHhQ/d6oQMorvqVxrS2vLuPwWHF8mBOcOWcolAg2gNC0xCiEfEDUVyx/CO8jjTDrZqoJHE
	PprUH6LOSxXEQXdNJ1r7MFW9k6qjikcrpyJdcmDGfkwwP/wjl/aINAWtLtPRDU0OS7OjnNtjS/5
	AbbFbPbxgfeoW3xpBJ98wUJKIkPxXe/yPi71MCjdB3vCzSN9Q57r05IAkwsZJWO7S+0+ylBJoqh
	u6whs9txyyfA/so/YZo1zydUw0jIFn06m2xpNNRFlPEGJX6eWSdGM85hRWxwiDix+45s8okiQg6
	tX3HUK6
X-Google-Smtp-Source: AGHT+IHKfwHDjFbBjFoOP1ZNZG2yYIy8Xdi86MslAqVbrnS76U8emwCJO7CURd8duOcxnItzlu++Ng==
X-Received: by 2002:a05:6a20:7289:b0:366:1880:7e06 with SMTP id adf61e73a8af0-376a5449622mr15082294637.0.1766521260025;
        Tue, 23 Dec 2025 12:21:00 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:59 -0800 (PST)
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
Subject: [PATCH v3 09/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Tue, 23 Dec 2025 21:16:20 +0100
Message-ID: <20251223201921.1332786-10-robert.marko@sartura.hr>
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

Document Microchip LAN969x SHA compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 39e076b275b3..16704ff0dd7f 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-sha
       - items:
           - enum:
+              - microchip,lan9691-sha
               - microchip,sam9x7-sha
               - microchip,sama7d65-sha
           - const: atmel,at91sam9g46-sha
-- 
2.52.0

