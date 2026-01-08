Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022562F547D
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875203; cv=none; b=D2StTxyEAQyeGVhqQeh4I16QXzut9s3MGsUKo4LZrFIkgYR+nVeuWbYuWQ9f2TlAR2ob6iY2yRXC/wNAu49uMjDfENRIFhYRW+y1wTv+iTvC0wnLgVuRhpsvf5b3A/xZKfQzpmiw96VXec6g6AB8+cjVastkPxXmtPZIeRZipD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875203; c=relaxed/simple;
	bh=BmARFNdMYVDF85A9HHxy7Xy3eWz7vlysBnNURs7Ug3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYWmTbebAfvGslqV+ZLYnHpDObhTXhnFylcZqjaQr7fRUdSnYBBX/ZH1TFXMSutXb5CsLwTBrJny7iB4R4R02vaA06ry9S/58bd7ln8uLH0hCXHqC+00ERJOlKCH1VNI89HuZsMWTQDpFBcI3dsVtHtxl/GdM4wOnIvpXc4mKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=rz1YBrUK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="rz1YBrUK"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7baf61be569so2155127b3a.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 04:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767875201; x=1768480001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uE1KQ3Nap9wSa7ARNmv253D/zHZAcI3o2YellqaTrW0=;
        b=rz1YBrUKroTnNeMDZaTQs9VcwI4BQFjXnYfLhe2qBiLUjF7OvIcFBBXI2a+x8LYOgL
         qL1/xxR8ShU/8j5uulbM3QtIgElfHb/6Y8005PIt0laAAjkWs9zUqD7toQhwhljX/HvN
         QI+4XqVctbAaasKaqrffm+0sIgOnlYjmDNVzeXHqiHNt7SaBvrB8bYfyH6Cqu5M80EBC
         NXxlD537Gszp7tXWeJ16Q3UUIqEQBANvOGvhLA6+E0iM4wNaXTzfj9JYcdMgLgaSI30G
         aHB+Y/pZw77LIowicJj93QR69GUeCXU7H7kvEA7waiFO0WsyhBFBRFSftSLVxw58Q8VJ
         ymqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875201; x=1768480001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uE1KQ3Nap9wSa7ARNmv253D/zHZAcI3o2YellqaTrW0=;
        b=Vwu/Jxqcdt4a58c05ngCy5/YpALl5WlCM3MyPqzXOQ3m7KZdI1uJWA/5TSK9/AGE0E
         nTczrfZXRz93ETeUo+B+nBkfYxBgRF6SXZQ8eAlAb7oWZsKv2C1RrGFqW+9oqT4L2IYp
         reSeQs9UN34D1TWx96pwyW/Wcib3rD4IxgYm5f7Cmt9LFpHelDaBiBxg3C2Q3A7pc49E
         uBeqPQNdfiXvVX9brCPRx7UxHRYu+Gdc7TZ/B0KrdIamBKvaYczoHJO+5XNWqV0Ov4ph
         QVRFvfKI2+cgRCdyFbhsOW4hifHI9hXot+/3y9O6mNlBvzH1PhpPK8kx3QWZ5QVWpWpJ
         TrvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeQofR9uUpAXmm86PLJC49tGPm4k1K+ZfmlHxcBTqAfupDDbYg0zYQiYLSwzVeiuatUe849kRgssR7994=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4GPHpFK4vhXfRSVkjvd/dyHsl/i87Ad0NhwYT9brcklet6Su
	gVR010MZs9ns1iDKp920lKZ2SAkwON1ejK5bHbS1xU/lpeqp1bOvHkqot9gW2vqQinU=
X-Gm-Gg: AY/fxX6Ak2ZSOdIZepChioi9f78tC8Ku14JhNHIw8dZqF1hk423zgZoimRR7kH9R0jN
	PdJS/pCNN5IXPfWt7YfoaWNR14zRAvQBcm17g96pjqdOn3BwatQ4N4kT8f+JL5FPFOdV5et+9a/
	N6J1mfpQ+/jzl75tFEgHn8z5Wn/imfadUHxuAKmHCmhKcbFrzBcy4S66yJLg1YoDzJbDPjZ5n2I
	PMz0vYvH2r/UTAonJ8H0i9wMVwCwqLJ4DukxT7YmltISgz2yyQ4lLBcKIOnB78aIV7i8im5fCgS
	tPJs7Ev3cCdHP4aCcty/+ecUs4rPS+ZZfOk1u0zDrFwsyTMI9jwriSdwbdZgCl7C5s3MF0lqlx4
	3Sotui5rNqWw+wVOVb27no6dZZ4k5Hq9S6Wrdrg5Y1pLMCFOypCyuxeom+cl/xs1d0jKAY7/bSz
	UWVBNvMDh4xZW4p4j91VRwxOKoYvJ7+Iw=
X-Google-Smtp-Source: AGHT+IEf2mq8ef1YFTNrrFOuAanoejlFcGh2te7djhwZxqGKBzNIruQxKkJjwV3kGI0EiglOFPr0Pg==
X-Received: by 2002:a05:6a00:4219:b0:7f7:2680:7325 with SMTP id d2e1a72fcca58-81b7d6511bemr5205066b3a.13.1767875201339;
        Thu, 08 Jan 2026 04:26:41 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::40df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm7656401b3a.16.2026.01.08.04.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:26:40 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 08 Jan 2026 20:25:54 +0800
Subject: [PATCH v3 03/11] dt-bindings: interrupt-controller: add SpacemiT
 K3 APLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-k3-basic-dt-v3-3-ed99eb4c3ad3@riscstar.com>
References: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
In-Reply-To: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
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

Add compatible string for SpacemiT K3 APLIC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change.
v2: Add Conor's Acked-by.
---
 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
index bef00521d5dacc002d24c50843ebe6380a7d5524..0718071444d29fbfa36283fc9666e8cecd6f77e7 100644
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

