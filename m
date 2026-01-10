Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB531F4176
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022370; cv=none; b=iPEd01oVbS4GYwJqv4muYBVNhEJmmshgxWivXj7H0vExugB/0ApUOTNj0i/zH20504PAaXuh1EqIP8HcpUmsI2y0zhY95APQ9+tFc8TxNEGu7wDxBRniFz8tEyjywCds8ay1mrX2gL6uXQn1LWDHEznqhgJRL0/JdvkLQgjucI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022370; c=relaxed/simple;
	bh=II8WFpH5JkBA2vO5Ewa8JbzAofV200Cwmh6BSNiyENw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ag/THRtZncBld+4wP9WTq53WVkbNSHDfYF6bayM049VhmIQW21eyzLi8yqdtmOwsBC+J1d+u7DfxNg6QFC0Nj2enQBBg6h2zsJcT74HwPeFBs3Fm6ZNypq6e0eRzQvgeqodkNqzm+va5a+FLyhBLIwj0BRrke6aDw+/ZHDLHuLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=IW8JcpQM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="IW8JcpQM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f2676bb21so43938505ad.0
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 21:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768022368; x=1768627168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4Geuz70LTMH+K1+IqxpgAgsSYEP1GMgnx7rbwvE2Nc=;
        b=IW8JcpQMMAUhn+fF5meae29x54qupHzZi+j1JMnvaJKB5IKfhr5B0quG4P8TONZpmd
         8E7FF8i5yfO9reEilxiJzwSDjPe+DSkjh2xKLtwfZnhbWai/QycHjisukQiEwmtwkuwB
         +8gq7pyPSy+nUtxty2yBChrZVB/9b9K9DvxjU41ssprbhcFbvL6KvO1DkYyiZujTSVaR
         71nup9U482oXXom7ppdIycJVJer4Ihsu0BahT9OzbM+zP+MDAfqTkLxrfjrbKv5LIrmA
         feazvNhLdfR2xNHIpUWsQVWE95RdDQ4fGIyvzQUoXeT9Y+X160mxFqMtm/w0VXDud/Js
         bq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022368; x=1768627168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4Geuz70LTMH+K1+IqxpgAgsSYEP1GMgnx7rbwvE2Nc=;
        b=eKAJzDkquCu7IxjRF4QxgnZ4ptbPJJftGV5eUE+H6GV4my43NsKfT6B3skHu6SZycc
         ZSoFmeSpKqFjCL9vkoZCvkE8XXI6XU4ZpvVLtvytC6N5iHDWpcFLT/Iu8r0ZfoKXZ8sK
         qRK/V26lFjaPrQwxlth1j7dsmq+DLejO6XRfODXCewCTQzZvVFUT7d7bPgGBHBDNxb9i
         XX5g9iaouwUZZH1ansLJRQfb2207/Om4j1tJDfQaLvh7ZROJL09l8RuANTTzIYzd+MM+
         0yKPfzak6jOVg0Ax0MWAYm+glvSYzbqfJwNVG8gOUR4juEW1TX75H+YFhmygJD0XvP+V
         X+tA==
X-Forwarded-Encrypted: i=1; AJvYcCXGzQzd8LdPfz2haYmZ9V43hvz3iomJCgo9mGugxR8AD4Le4l8NQMftSYP5puZe1udnQm1BqtrWDTOMrwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBeSQeH+852BvYvRg7jFZLn8YLznybR/UTcD+rCTOqMNuyWIS
	BFqQtcxYEhNIuUwhAEbtzMbjP7Lqj7ViONO3XNhZO7cZrahvTFxgp+6UOjpW9U4FMrI=
X-Gm-Gg: AY/fxX4tpyonsEsI5us9Tb0bz0AIrScZMFNlRTE42vvpqZyaSN0O9bqNhtrQn7xeEO3
	Xoq7RDtWBj+MUxgA5oPHPUQEOxJ6lEF1sCAaN2MZ+R/pO0GeTLTmenSqaJcoHOIsksfvOCCTf/k
	gtU3Q5VyGHrdKzxCHeWzya80TRcU12fBBAkDJYvL+WGZ89OR1DKSlpAwKf3uLxJ/x8v1eLBH0u1
	PeQJCiJAGQ7+fEHYdBNRp7ES9ryPEtdK3zEbnWh2mPIW5/6NoPOSPr4E7/CqwTV1BlepwlIA0Rn
	lCRf1MmVEo7SSOIdPeK9FoiwCTUXOH8/Fb53lL1OQ1833pBK3EK7X6k/fxVm1uNrbDtiGVRozjx
	5qMLGqW5DHfHEu+L7BX4wleELiYi6NjH4pkKo86u1XGiJM3JzrDOJzOP7rSXUkm60ka9bmiyX8D
	rafIjLZXo9Cn+yiCq6o5NgswYN9C1/S90L7b0y78mEE74YTq1HaL1cDg==
X-Google-Smtp-Source: AGHT+IEhV3ebl9s1TopC0pjYDvYSTyDIROwqkU+RDAEMZaVwRS5ET19VZ04pbXXlgHjjsJSNiSZYpA==
X-Received: by 2002:a17:902:d58e:b0:295:1e50:e7cb with SMTP id d9443c01a7336-2a3ee444aa2mr109871225ad.23.1768022368123;
        Fri, 09 Jan 2026 21:19:28 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm118208265ad.73.2026.01.09.21.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:19:27 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 10 Jan 2026 13:18:15 +0800
Subject: [PATCH v4 03/11] dt-bindings: interrupt-controller: add SpacemiT
 K3 APLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-k3-basic-dt-v4-3-d492f3a30ffa@riscstar.com>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
In-Reply-To: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

Add compatible string for SpacemiT K3 APLIC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: No change.
v3: No change.
v2: Add Conor's Acked-by.
---
 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
index bef00521d5da..0718071444d2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -28,6 +28,7 @@ properties:
     items:
       - enum:
           - qemu,aplic
+          - spacemit,k3-aplic
       - const: riscv,aplic
 
   reg:

-- 
2.43.0

