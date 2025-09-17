Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56192F25E8
	for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143070; cv=none; b=Fhvjcmy+KjQQzInuNyU+YFz67Q0L9/29vJ2e4fKOxuq6ak98Ip6tolG5USjbuzrIU9WXbKHGu+Pn49fpfPIuQDWV6wrxuWS2/FQk/oX04F10SrTOE2pwmXDY6WLea+snLQXxuqEfZoa0RlYZMSAqW1vmEoKsrRWK7VlTVaFcOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143070; c=relaxed/simple;
	bh=7/q7KnmwWMN+hTZMk53R59gQ8vuRN9Xg0o9/pqcgARc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNo/ZOlLQcTvJ7CztXCjcVLPAsAIF5Zt9/TJKWk2MHU1A5UdpDWFIvUv/82i2DrzMrDoc039OHJ0LjF8mJnJY47pqcP8OeLusu8HSonStbHXgOLbeAxObr1sKP61LAVXvsj3cv6r1hlEZaMJwhgMquEjVFDer9MF9YRujD667Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bsc8cXkh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bsc8cXkh"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7240eb21ccaso12544606d6.0
        for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758143068; x=1758747868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0t+vzUv4eEyq+7X9KCxZxjlUuJ4kfiiop5UEdAli8J0=;
        b=Bsc8cXkhS5VP7kLhiIooXz2q+HLVCLIeLtuK5NhUBCtq9n2QTe7pLDxcrKeqOszsF0
         qz9ur0zMx3NrFai1nLAvbCbfTEcjYHsQgS6Y9OQDxgkh+d6CwUXn/rQw3uBjvANhrIfz
         wM9ZeXAGhLa2RHf0ZkwEoeoVOa1uTLquMzTpZ+4PcdcmTIEwx7t0eTjZQuroxyJ1OFif
         YZLZQ1ztKKfscr4J0GwgVHtYr2bGP+tx0ZYrzAqJWDr4N+mxC1TTTokWmHBBu8+4VfWU
         GiwJH7KAT3IXpEpZbNMHlAA2jOImExueJ+PwAw/AvAuR3uo64imXDE9I7tDQQt/uQ0n6
         W/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143068; x=1758747868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0t+vzUv4eEyq+7X9KCxZxjlUuJ4kfiiop5UEdAli8J0=;
        b=Ob0o5/io4+HO9lYPanDPUA5O02JrUgDcw6bdf5/b/5sKHtxzr8RTdi0De6xgnR+K4c
         +ZOKAokvMAMv3n8jEU5Qhm5Y+aaRbb7ItgenPnJPbWrFHKlBFX9I/6zzpgjaZKRZlwR/
         vRQP/g/nLVAsDANV7V09qss+nelsxX8MYWpkoys+L4nOwgSVwasKyPslIafNWZpDBWPG
         m75DjXLugraSc38F13k7YB48LboP4S3Gy4me/8j2o2tcznL+XcJfY0uemwuuXJtCs82j
         jBDVz7sdrY41hZqlEQia9LsSfAlM20CawlgJ5gXdaPmCPOWcYwETcZf5wtkj0aL6Gr2q
         +Hfw==
X-Forwarded-Encrypted: i=1; AJvYcCWfT+NGBmhN+/1IcsfqHl32HZZ0oVgLkwsP7n2okXoYwTIcUAI4UqCHvX2zSoc4iEs1KKSHwHA1RpHEvog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8LI6cgSaDv0i+Itd8SQ86hmdNjSKyqg/Qwaux1IimrEuGoqo
	8HLkRbiDT1AM37FEjaGwY8hXcbo0m7zKW+j9YTC8GSKu5bVe9AzIsmlU
X-Gm-Gg: ASbGncvZMGJAePDa6xSIXvcA7izQ0uO+ofTMm1HtJYAKusrh/VtGrCDNgmifx9KMlhs
	R/ihR7dZC7pCEV/KRqR1VzcFh+IZqDL/NzpEb59s02P5mc5ttPvdZymCdraIY/ygbHALzsqnrvs
	cnBo/QXO4KkqawAbeY4X8xy+DlrSw+MaM8C8tviU9e1DyyXz7N55s++DMRArkfAuSVfHW+6re4I
	X98OX55oh22jzT8MgoThiH19aW+uK3yR//hnmFt1Q+5pUyNilpN+UbMTDTHoQ55EKc+a/j0dHXf
	/bgH5m3oo8I19EyA0tiYw7vuyVx1eGDGcYQ1UulFbmox4NWZuopBJscUmuHRxzKbz9l2uTx6JeB
	R0N/pnsG0+AO2oZ7lg/Y6kKeq0lV92tdj3YvwoH/gu4yY
X-Google-Smtp-Source: AGHT+IHJJ7FxhXppLqJ5pbKIB4bHEdrdsbUH4s0x4UPdSktVG1rpEIlRtsQvoMJIpZSNXgt5/AVhTQ==
X-Received: by 2002:a05:6214:1943:b0:78d:592d:fd03 with SMTP id 6a1803df08f44-7926a5f662fmr12311516d6.25.1758143067540;
        Wed, 17 Sep 2025 14:04:27 -0700 (PDT)
Received: from [127.0.0.1] ([51.8.152.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793543ffae5sm1897226d6.53.2025.09.17.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:04:27 -0700 (PDT)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
Date: Wed, 17 Sep 2025 21:04:25 +0000
Subject: [PATCH v3 5/7] dt-bindings: serial: samsung: Add Exynos990 UART
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-perics-add-usinodes-v3-5-a3629e4666ef@gmail.com>
References: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
In-Reply-To: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Denzeel Oliva <wachiturroxd150@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758143062; l=896;
 i=wachiturroxd150@gmail.com; s=20250831; h=from:subject:message-id;
 bh=7/q7KnmwWMN+hTZMk53R59gQ8vuRN9Xg0o9/pqcgARc=;
 b=zSJtklfi96dJ/A6QI2dd3ZrhnFeXwIcQhVDiDgn5BvYrAU8yIcIQ2Q9o4HXUTv5q1HGhchwqS
 BMrhT322R83D2qom3YkcUayxCcLHizrCd+0DeW7F4War6bIhHDCxbDq
X-Developer-Key: i=wachiturroxd150@gmail.com; a=ed25519;
 pk=3fZmF8+BzoNPhZuzL19/BkBXzCDwLBPlLqQYILU0U5k=

Add samsung,exynos990-uart compatible string to the Samsung UART bindings.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 1a1f991d536491007c7a87b24a6efd4ec3bc0ec7..369eaa9054908f7e1b63bba2e83be612d22f0718 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -49,6 +49,7 @@ properties:
       - items:
           - enum:
               - samsung,exynos7870-uart
+              - samsung,exynos990-uart
           - const: samsung,exynos8895-uart
 
   reg:

-- 
2.50.1

