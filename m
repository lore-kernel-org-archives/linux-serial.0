Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5E30DEBE
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459956; cv=none; b=RrWF9NybOFX/hO6bwixD3jQb7rdps6C91U6BmNSem6bd6M7/B5GhE0axejHzFQhcu1H0T8hZChjpUzwUMbwAHY/QZRHfJVO5TAiMqyW+B4rmDNK1T7+XAMkc5a2V1iNGwScCEKkymzDFpBSzcfANwCfRR3PDo2Y7Y/BlAfKwrsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459956; c=relaxed/simple;
	bh=l7hGjeH41ncx+nOi6rKBCh5zMtnv08NYJtvw973zNG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WnxHbSFCk4pqw3P63zGer4CsaPdPcphEmGquXi/8Hs2sU/CxHXuBe0WGrUrj3P7lmCJOJ49zMzD/YQtjRQg2mQmOkfZpZj+9+7sAeW9tB3EoHFF8jvxoBJ8c0yR/low055C/XvohyLVC7VmtAud1j37RPXOWE6BBIZ9rAF5k1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=nOX42xKa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="nOX42xKa"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a110548cdeso4393355ad.0
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 22:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768459952; x=1769064752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkACyF5knfi3YNNtTGrOijDE0psaJA8wPiea8JJZ1Ng=;
        b=nOX42xKaob2IGyWNkNrhREpj29Kd8NaAG2fCAgDUANPuHtYuomwhUzg3YIs/BZO/Gy
         2mZOHRIyDWu8MKp2C7MCR8Gb3EP5tUGFG1MeXoIOJ+W8QWPcOpmbWvncYbAW6DQFLwh5
         LTt8vy62uURJtWJ5W0FN5QML1lCgEzEeIGm5qD4QeJUxjJEhZToM6tUDwniOfyjhur0d
         +F8QTUJ3ZMEbMrBRhD5i928XX3XJdP40GFpXJMYa+9f661sl9id1AaRvlGXt0alMxsp8
         eC8z7UfeylpCZHVVsETjXL1TtIGL348IwbiT4zuhfXwS6oRh+H6gm9yyXKgcqqgiCakL
         eblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459952; x=1769064752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SkACyF5knfi3YNNtTGrOijDE0psaJA8wPiea8JJZ1Ng=;
        b=IhN/bGXH1edMgV82uPNaUdwNJqWHnlVMub44i1Gytq5Oh0tSRFDV6LsNrXSEZuOhra
         vDJUvfZn+FhQim4FwnOxlxwTXREwQJs9jXpZcqc7hRQieVC8xeFzAf8GjH2t0IYD/V4D
         nqIpHNOjq4OUXJLHnWxFS4LqzE1cpGLLVhgNUWVdF/XFeHYq2YOJW0PamoUHv/XXlGYp
         26vhi7LIU7qXRA8UceJCj6hCF7rGjX7TxW9VVxQMg9kdUx9IDVyZVgQDBoqYVbR8odYH
         726LVI4fVKuUewwqnH8T4MSURl9CPlbswhM5ReF5ycYt3PpsfnwO72g3hPX/udG5JqH3
         vtXw==
X-Forwarded-Encrypted: i=1; AJvYcCVNN4x/ZIQ4u+/M4UmJ/46QJXtxhjTFaBu1v8rRziz6MdSJ51vU/OvkxhF19Z+HwJvtMmmvWV94jmKTmRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqo2qVZO640KdQfHozR/QGbXRrfKD9RBQDsKbbnaSRdathDAG
	gE+4iEjGSAd2rkDzGCfDjsE43lQi3BRxzETvdTAX/ydyVTXCen9HKnu/j83dOP4qIIU=
X-Gm-Gg: AY/fxX6NA0GcrKTjNm+86o8DBVLfyEQfc0OsyPT/h1VlGYdcqkiIzo5lo+diVQS6WNt
	7Gj4IB2z4FsOMHI+ubR0PE7fiOs6ZVVzF3iiksqXX7iP2+jyCVCnKdgnslX1sXiM8a3rCDdPYgu
	lRjET982TblndqjBScRxlnti/ZKFQXCk9M+fxgyx96x35zMGF30FpX1JrDQsUurflJisj3xYfua
	nA+wMxj6UvZaaOwSBae2CZoT/dgpkp0vTF6hJllPJfIsBIVcYCHYERPfQxl5e0M+mTJJxvlQcII
	Zz23cussSO/+J3eGuU6Cja5ADoeFzZtX+dsoUaQVSR2tq1erhVrPDe1HQrWElouDoIh/OfisVjw
	qTVd5BKipeQnP5X2G+HqrhuYSVQlwVUBauZXdEGuMReM1J1a/h0tkZJtsuzeSzb2wcHErxpUTEn
	NJ0jbUx18kaSV5hEfmEqpMEjupKE4i8aDQi6k6Sj3NE5Z+789Nbb7hK/Z4hvgdglcT
X-Received: by 2002:a17:902:ef08:b0:29f:5f5:fa91 with SMTP id d9443c01a7336-2a599dd69abmr51861225ad.27.1768459951907;
        Wed, 14 Jan 2026 22:52:31 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e7a3c6fdsm235081015ad.15.2026.01.14.22.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:52:31 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 15 Jan 2026 14:51:42 +0800
Subject: [PATCH v5 3/7] dt-bindings: interrupt-controller: add SpacemiT K3
 APLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-k3-basic-dt-v5-3-6990ac9f4308@riscstar.com>
References: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
In-Reply-To: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>, Thomas Gleixner <tglx@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
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
v5: No change.
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

