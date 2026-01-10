Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865D23817E
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022381; cv=none; b=iajG91c7Mu6XCTb67HqtysYMDVOrSkzXee82tqavz+D8bx7zTjAGG4IRun0YCTHrldqz3h0smkoGREX52ZMwDbHTTsyeK5ALSTVE9+pbAG4WTRP0UcsekCHRJjwP3yXH0TDTrNedTRfaDNYgv+7PJ+10SiPvvmPw473gFRDt6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022381; c=relaxed/simple;
	bh=JVOErVuwqnxyZxfJUVNdtb8rdirOsuMdezkExIjs9So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1r2M/RT7Qn8wdv1v9uFua/2c+1CtH3lWGJHehjCjJ13KbMpGWdbFyk0iCv+XAZX6K13NlJsKdKbh3iBwAZ3d+bo97wNqqcY18ywiy7D26sEUmmNrFN74zpS1eNd5HJSea4yogrEPJQAhCnOSBgO1Th/myYpiKWjf/JrBpZH7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=QPxGXUkj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="QPxGXUkj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a09757004cso46060035ad.3
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 21:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768022378; x=1768627178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RB1julTcwsVwIqkOMTaY5tjMY89z5qQTP6TBk69d44k=;
        b=QPxGXUkj5VrrTCjbRaN3GRPkFHE3nFyPxwU+6v7KKm9QsSkxWlpbOYJZ8SZj7EkVLc
         bfXBy6epKKGMXorGjRN3YzhW5xx7NUnwd7hfsAj8gdbjE3NZQtdmwEINlNvFpiVWpNGE
         9on/NhWB6w8a9OY3sdoS6WWEerCfOaiEjo0XXlwgGQgIH7cnTQf7MX/p4gqmRwgq0TO+
         i2UjreAvIxDxsKiQJnBH2q6N3U4eLoRhgaG+hY+1vzuZG8TrREhCx5QsSXnuX4n3KTV+
         t6PeG6ZHkc6nfD5oohGv/Vtv42+hPOb5sHAxUckz0LKJqZ2OX9pAUUX9b8pduqRbB4uf
         ZivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022378; x=1768627178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RB1julTcwsVwIqkOMTaY5tjMY89z5qQTP6TBk69d44k=;
        b=fFGbzd0TibzPtWjEhl0Iwiv0x1vBs/WHvsiRoYxEoKh5GvFMp+wO7PX33HlA52ND8v
         fcHy3NiVjPZPc6cMPML6LzQN23U2wQSw0Jp4Qe4SDysHPvqdgT7Z/up3OVHESlpYsRFs
         hwObz7Kd8ogE36rgRGvfL0nI09U0kBauZtqsS5jxZLHzCAeOCuovC3NnNQ+qs+88C+5q
         xgZ06DEMbuYKpFtxN6f99EPz0ddPtE5zyX/SiRp3Xx7m7VpUvCysWLysSyqd2DllOdLb
         sgj4vU2VmTJKx5i9y90p3WJEE50FGpKcW3HHDBBH2TG/U5ddD37HZfGTsbeHqS5XFuSg
         u0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE+EHrI82KEU0+SN6qlLPKRpj96uVmuZrFRUBsrXzeIONmQ2T4op6X6q0BajwdJ2SVn5Mm4PTHWaUzRMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQIEU92A06KAEr7oG+A5xLimr4Lnpmymxt4/I9wRGXEU6IV0U
	qp4vfAtO+F7kgZb4KjitRpELwsHHgEOzSmzmnoyndoRaALSBAkTORRsXUU0bBmGho7w=
X-Gm-Gg: AY/fxX64Tx3y5HgaroYKIJ+m/rIkQ8svRJZXprjMXft/1FNKFUVdzUzUjvH19XAw9d2
	9GUqp32xkuhiCSgg/HpKWDDr6rJaMXhErqoS0/awM7BFx4RFfbOr4p0r/09JJ6W+295OW+4/qUJ
	rm4f4orSRbVu0awtVi6hME+BnZEOwk0lACFVgDZm3q94XRRQswnH68/2nO548/dgKW0CsoBpxam
	9QImueLCr5O8WucKEd0qs/Ay1WUDPiVCR6ykd6OXeQy8v4W5+zpkw8iuFMkjXMeVjwocCRuv3YG
	0T6PQIv08viGl1Y1RURK72wVKnsPIM4hK2slTYPtlg7A/cjVPOhLHzb79aIzl42ueoIxDsEN7F7
	c01Rj/Msk8f7y1WDZrPjhrKPteXOn4sEfT6kWvoUKnHNNUXa+kFhzAjf4edRuborDRHtEKorcK5
	jrXS46LuARhHkokA8XccnodjotWirLBuqQwUkfVHCUehBrtjT0XTKyCw==
X-Google-Smtp-Source: AGHT+IEbLN+ufDRbhXFu7As22NIuOsgWDNIIPN8ZaXZZdRrHya+Ppa2gw7UP6RqhkdSdQ7NFe5NtJg==
X-Received: by 2002:a17:903:1a6b:b0:2a0:a484:6b87 with SMTP id d9443c01a7336-2a3ee49c6dbmr128077985ad.47.1768022378403;
        Fri, 09 Jan 2026 21:19:38 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm118208265ad.73.2026.01.09.21.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:19:38 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 10 Jan 2026 13:18:16 +0800
Subject: [PATCH v4 04/11] dt-bindings: interrupt-controller: add SpacemiT
 K3 IMSIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-k3-basic-dt-v4-4-d492f3a30ffa@riscstar.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3

Add compatible string for SpacemiT K3 IMSIC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: No change.
v3: Add Acked-by from Krzysztof.
v2: Fix the order to keep things alphabetically.
---
 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
index c23b5c09fdb9..feec122bddde 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
@@ -48,6 +48,7 @@ properties:
     items:
       - enum:
           - qemu,imsics
+          - spacemit,k3-imsics
       - const: riscv,imsics
 
   reg:

-- 
2.43.0

