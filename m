Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38C2D73B2
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408839; cv=none; b=WryUGo9d+AlmWbHibJc2C2KZ7JVWj2/S8HjPMDrNqtn4PoMBNhr2W/JcRLPZmB1TKT7oy8ICocD7+JAF30qosu8efpdSkBxLO+kE9yVkwwd09I8YpdNWB6u0DIJlHDD1gtPcAHpy2EPyp863jrlPBmd+2UEJrfcozeJvDrfMO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408839; c=relaxed/simple;
	bh=OBOvbsWkB4JX91DLbnwWud+gbnMSideHZUoDSFjfq0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q82tEDRuMzgzudmcA8FExbDYJyp+sNeMx+XRQZ9JnXqENTUdvMNK/S3OchsyP1mT7cjLHzW7N2hmovJiAO2o4x0VOgI0dgy8frmTt8ol1bvIL7/2NsY62yc8kZ5Kul4ZSBw4h0ZX7l9mFCjCFRMxvmHV5EkPvQ4OraIg3dwrDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Nrp0u+Si; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Nrp0u+Si"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso3373075a91.1
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408836; x=1767013636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmSKFLQJJOcL/UHZMWYDxU5qPoFtgd6eohGiohbnOX4=;
        b=Nrp0u+SiBotvIt80Mjpgc+E6Jl/6A+i9OBLJAgksxBSPFJ8V4Pnf4/fXEcNMx6Q0C9
         vfL9FmM5eaNeM+z0Y4hYHsMh3hR8JYiJf41PIeVXPMT9byKCZfhI3eAlmdxuxfCBaVzD
         zvEXDIJftVjbN34hX3QWtbhuy3zshYY3tgyROXBaloK+p/0dxW+pAl04o1wF/EP7LHgY
         o1xLklcR/7+dj+aGz3VFxOHRk+XkpiuHfcKekxPnzHfwVv0yKQPXTCxSoRgC3DrAAyM6
         2GQ4936lwbXqlPMzmM0rkI5V/k+RMPKq7xXXu5HZB/vLAzoqF23rqMxraghNjqcqtuTZ
         DDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408836; x=1767013636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YmSKFLQJJOcL/UHZMWYDxU5qPoFtgd6eohGiohbnOX4=;
        b=RO3PSCqnki0nZFY+t4W0YWA01BeqSvQSjmCvpcoloD3fybH1lLisHQjfYAI5upLt72
         qNOpch8oF2ixfFawDzvKq9IOFKyns0Pwoj9eeNDHP0z1ulHJcEWJ6i4RTkv3kxI+uBOc
         NZyAHHx7dC72mPflfI4JE1QfXtWhBBNjUotxzJ21n6ceDynDJQlScw3bahrcGapAoyvs
         Y0iuPsIWi2CxNVpcdZr3ok9eRc8SmYB87KIBYmQ9eLNfBMGiIzpwCxact6wfEhioz0zM
         fmdnfBE4c9roZhiDluTZggTTtVCFJqVnq8qXuNhTKsFTRZHS6CHsm8uyA26JZKTTpHS2
         UOjA==
X-Forwarded-Encrypted: i=1; AJvYcCVE4tAs3bIvka5UQ7nXJWW4TJtxkETXdGn7BZiANc0gNZz3DiC+GdvfUVrNfBdeeeSTOtoSUQtkHDv4JF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gXRvwd4kJEGAD4U/4F2bcoUcUtEuLZkb/Ae2Vr1h+J4/w7VI
	0DY2ZHhA84ew+ZwpoogxZ3BqSW4eb35U3bglStElgyWTFV/BR5Ef5qn56Y5DZIthMtI=
X-Gm-Gg: AY/fxX5GnuESUDcii1YjFsuV6ouKGROcTWyfKwA6GK9EzA0GupIeUFQH8/2A+BkqEjE
	yxZdY89+/F10Fauw1pz/UuCsnqlBXp+xY8PHgGtGBTSfc6FdY4P+lGKa9ck0CFUrkvnmk6sDpU8
	wPd+RHfMVHxjC/KHmrmk7OhtCy6ldnuReQX44OzVIpr3IgbwfrtSdQ/YgwAm0VsnNCgSpfbRwfJ
	IAGR9H6MKzLXtU+cnrtEnK7Fq6U6TD06tf3P8wrHRNUv3biIGYgztO2yL7Qpv/5DZxubtY9+c3M
	xtkWRDGqh8Sd0ZoAYZLq2EU7o0RiHm6regAcHriuKv2mmOZUKB7SQKA1LhyXu+ZyE1OWg2IhMRi
	Kn3Lze7uRp4UvV9a5SwQJUV53SBzvJy8jTUsu0933piHens6HTodlW716zBjVyeUPth7uxcwxAC
	Gll++Q1Byqy/cHm1lYGmOv21vlpPS46YOgsATayokT/w==
X-Google-Smtp-Source: AGHT+IErkmtgUVNEtdp486aXALGkmaBg1W9XZAspgQDXTKlho7yIRKAUKoJehNC2P2iVciq0Y+zRRA==
X-Received: by 2002:a17:90b:4f41:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-34e921b73b5mr9241301a91.23.1766408836378;
        Mon, 22 Dec 2025 05:07:16 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:07:16 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:15 +0800
Subject: [PATCH v2 05/13] dt-bindings: serial: 8250: add SpacemiT K3 UART
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-5-3af3f3cd0f8a@riscstar.com>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
In-Reply-To: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
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
X-Mailer: b4 0.14.2

The SpacemiT K3 UART controller is compatible with the Intel XScale UART.
Add K3 UART binding and allow describing it with a fixed clock-frequency
for now.

The clocks and clock-names properties will be made mandatory in a future
patch, once the K3 clock driver and device tree are merged.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: Add Conor's Acked-by.
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 167ddcbd880058b6dcea9ce33bd814ff8ba6b0f6..73851f19330d7f9fc254efcd32b5977feada0b07 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -160,6 +160,7 @@ properties:
           - enum:
               - mrvl,mmp-uart
               - spacemit,k1-uart
+              - spacemit,k3-uart
           - const: intel,xscale-uart
       - items:
           - enum:

-- 
2.43.0

