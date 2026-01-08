Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989A4DF3A1
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875193; cv=none; b=tefZbbASdz4ZGyrduzEQMz74/X8mcRZfCKxW7YR0bOEBpMSMFUWKAZiesz0Th/6twTJ/SKeln/+4K6vzU1PhchrRMTSvDSNXbzZGtYasfE7i6WWmDX6ipxXKmBazpLRPewmy+1jc0tMRGN8dVWAxWhuKKOreru55uXimhxCKw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875193; c=relaxed/simple;
	bh=jwDsgL7x7nOIt2v7JDXtla8T7Jp+LG2ZQ5oLy5SV1cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIaDeV5kkAkne9fY0u47Rn9c/q113AOvQHRhqA4k+6IJ9dtp+l59wvAsT8xtYjVueFTPRq3rgKuH/xv0rJYZWucN0+us7rJ9lnXHC5Mu9QfwykOu728/rfLsB5KI3eAPtZUPK/KRKNKN3KomhPbD1r37A5T6l9XCu2oprYKuLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=2Dualw3x; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="2Dualw3x"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso2347511b3a.2
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767875191; x=1768479991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rdFmdZfR4eNmRMqejKMXyCR2tEpYJOIzk9O2le0lBU=;
        b=2Dualw3x6CyTtbaLuwn209P7JnYoSt18gXMKqevEXQc1Nr/DD1SuwY/p4U+SyJtufO
         p0Vfm7MPX6qUL0c8HLTqKg9XbZwTtVRu9ythgFYVjsiTzhg9iyZ/ldKT1qRJYnLG8Y2N
         nDPq9f1MWelS550yaXM9EOXhfTNRRGUtWSBdiTHAeM8RvVmxW7mZ1zsoyTF2X09eixK2
         nBOL6KmkKT9UHHlcLU/zGz3jEXu01H6KUdp6ULdgdjX2b3XmuZplrlBr6/A2tQrNFkxn
         kovqqUAgl7MqIdHl08MlGmgZLbM/65pqQ6kp7yPtZKvv3Zt8Gi3KOdH31nUNW0LRKUKH
         i5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875191; x=1768479991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4rdFmdZfR4eNmRMqejKMXyCR2tEpYJOIzk9O2le0lBU=;
        b=GMD9DAWIJxNUnDR6M38lF84cUmycKU/mE+Bxw0bnyB6tQ0tn3/i3q0z0iLQMo5QLj4
         WMEjirgE9s9DnERmBIKFP92KOYZlChusjNzEF/htvFZzOdn2ewxgAhWZ5gAhalLg3psF
         5k7Tpx42iE/elcOAJysH5csrrEsS4O4jPu4M2slxA16EEuT+cB8w+HnsAS5HJs+8uCg/
         e8s0s4ma3Se8QQVa+VA3QsI1AliWChe581Z2KYS+Ok6JlLedvZBaoH7zVJDJRtCIW+xm
         i9BZpdsMBMksE6jjvl5Pi+oTfCbarSBBeIhHgigsK+0IOtuojBXpf3Auf+KHZeuoUHfk
         Co+g==
X-Forwarded-Encrypted: i=1; AJvYcCVYF5+Hl54nf7oAGiq8x7MXuv3f4zm2ekhUyo2mqiz80mjnNPX43DGj0TeHwrVngMRJ+14nN9sJk+FhKqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMIS2pa85bbEhi0RAyu3EMWrP1bRijyddMA+WoqeYFKCufqWGU
	hg4CPgX38LqkBw2NWNlqKJ2xZcsPVj9+h8EZ7KkZfoZG0P6aNpjkYdgVGHjtthX2NAU=
X-Gm-Gg: AY/fxX6d0n0VYOLnLlE0KTY9kIY3Xw4B2TcmYAbgGXBtdZJmNr0xx2DF9EFHAUoK0nS
	bIlcgr5MWHD9h2LwSyDBTvNP9wUPT4kAy9Srzm6EuIsUcTT03hkpEKtlF0Itg29MTKqnA1wPwHJ
	8e62Hs9o9CA5Qw0D5lexEB2QBobKg+4wctFP/fNasBHhrTzpgOcjYWXCyMiYlpGGCMRjFsBl54s
	DCehRXLA8lxEiyVLvzM2BeTonIKusr+bJMwaF3aiexORbjLxPq2bM73FXDtszvxUFVpB5l3vCLY
	RZdzUKDl7Ii189S+UfC2hARzZu9qr7Pal2mZjgx7vjwsKsuvIjCk3ud/uPx0IEbPaCfP3mErzFD
	F7Kmh/klZ+PxadXu0ncQfOfujo76KvP/Rg1J2x4A2Xt2ONTurb1RDyBTsGcW/A0T2NZFJEhTvlt
	wnQS5d2OEPG1tCsl5nH0pZqxSgGXvU1bM=
X-Google-Smtp-Source: AGHT+IHheKi+WINIX/sN2F5BrXIlf0KDIJbSmAHkyxZzFI0+gQsjVJ9XwXI3CiyqReN01P5B6clk5g==
X-Received: by 2002:a05:6a00:440a:b0:819:4284:365b with SMTP id d2e1a72fcca58-81b7d95f67emr5827148b3a.7.1767875191060;
        Thu, 08 Jan 2026 04:26:31 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::40df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm7656401b3a.16.2026.01.08.04.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:26:30 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 08 Jan 2026 20:25:53 +0800
Subject: [PATCH v3 02/11] dt-bindings: timer: add SpacemiT K3 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-k3-basic-dt-v3-2-ed99eb4c3ad3@riscstar.com>
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

Add compatible string for SpacemiT K3 CLINT.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change.
v2: Add Conor's Acked-by.
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 0d3b8dc362ba7e8d0ca6d0cea692ceddc5e1f89e..3bab40500df9bc2ba4f7d6f1bf340c8cbc06f9de 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -33,6 +33,7 @@ properties:
               - eswin,eic7700-clint     # ESWIN EIC7700
               - sifive,fu540-c000-clint # SiFive FU540
               - spacemit,k1-clint       # SpacemiT K1
+              - spacemit,k3-clint       # SpacemiT K3
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100

-- 
2.43.0

