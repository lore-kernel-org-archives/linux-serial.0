Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526F30B51D
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459929; cv=none; b=b9XrppG1peb7OWWA9eE+URbJsTJd+9dyULDesHXEtE7mYwfyEALOkk79QJxbEftKHrGSi3cer4Oppj7pso+2DvgmqelEr4Tls1QdjygSYKT/567iI2K948Cp9kr236ZwsQGIa6UKBspK8pgfK0MjPGH8WFSELw8CMxFmmX8PY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459929; c=relaxed/simple;
	bh=yLe3j6lF/FJQaVVvG1o4P48aeD+Y8yDZi7XfHMnNJsU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KqAhsNVcXFbGBZZCpuUyJ2AIFF+JHngEyrTkdpKdkuee5Y/4bwWfqoR6PsFFuGnb2IicsVxjuP11nnR6KpQv1dWz4GAecZG2Iv8W6aUfXahDYdbuhFQvbYadO9kTv7F1xDS+1V3yOWQR9ZU/eJaTLlvbAlr7vgowiU55I7uBOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=pQOUhv1N; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="pQOUhv1N"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a110548cdeso4390565ad.0
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 22:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768459923; x=1769064723; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WD5EX5DuQsu6pRaXLnKPwypf1PUd+lvHZxR7rQ8Qqm4=;
        b=pQOUhv1NELnPKMTiqePDyzYhIJs0y+NQlVUmt2wi39MVWWvpuDsP7ZOt2bX/aQW7lb
         q3vlf/GhekvsSLCzqjUoyYVJc5Dj+C3vzAdJJfPh/pqqmZQF+qDcn3+4fY/Mxs4pgJuR
         13YGzXfIrebwsdtSMnUUISh2dvy5s0+yqiJKkbsIt7WmkTwBq4c+5Oh6T57MMO1tMW8n
         7PY+xFKZ9Sm+6Pc9Z+XO6ZttX7dYZPW3+jW5za7N9KsfDDFWkdGZLz+l/2LsO5t592pU
         l6jz9pzEH4zyOUUoGlj81E8FMAoW10mIkR7ZcSG/7lDHcSfIKTBeTUubuqzTRFCeBy9s
         8uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459924; x=1769064724;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD5EX5DuQsu6pRaXLnKPwypf1PUd+lvHZxR7rQ8Qqm4=;
        b=r3Q6Ss4kGJt3CTb4TlflkUqQbrCeVpsKJNyEXihSSlkTCx9g0zhIrgx5zfL5RztOkk
         00Ekx6mbifRz38Z+2erGsDzBfFEs2BiN/ioABBKG2zH+i2GTVrB3s3qExtOAr+fLFoGS
         acnevG3W9PW3JKWAxhCcr+5L/xu27uH3JsKFf7GN6nkirbCmIv1PD6HfDfaEL8++TSMG
         0rfcI9YldHK9PGC5/jcaWm4sY/24pJjG/l1soeAqRCM14y0HX6Erq6urg875OABfNLHS
         8FgoqpHF9mVCCcQ3pwF/o+hbs+/u6muuu2BPl3f2blJGEyfkN5I05wFZKvc6ww93nBox
         yXug==
X-Forwarded-Encrypted: i=1; AJvYcCWzoZ99yP+gt2HhyD4zelgNSgzKcsZLvjlPKuCBtYlW1KjCuYQqCVS71LtK1OHCFBMDVed1/Zpjuj2RQf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTfc//PbIWj+rRQBfQcT6omwVUKRoUACRFeutA3egzL1SezG1
	SxIJaajCjWjMvmyOocg/wzcn7kKiR0PtV2KjtiOTBpdseasTki8e3bNYBJWhi87x4zE=
X-Gm-Gg: AY/fxX7RCvY3Dyc/NONwp5tz2T4IkfmTQWgl5jiVUicKdbk4nO8oPIsnAHghRCtcpEe
	OMR+2I8YRqhagTpJegvCSZMDqKJRFz4ITng3B+HzuOmjfd08hjf5+4K5yXQK1xkAntyUD5fEi13
	14GW1XZNLRuhAgmBth2HrchkRt4Vd1bSFY94ZX2+didBEy6D/LZYrmHt5MSdbAqQ3dQQQAQ9U6n
	mjfR/BDPiatl3fm1MJctTxqooG3D+biBnV16yxJ1BwjrYjHhvH8JXHIckNsC7jEanGSboCrL+K9
	pk2jGCf1yoEyFt4tOiiamGeeiqkix/MVqqmv6DwIG9VSfvw0hNNuI/QbTfPSP8l/XBwItBOMvOk
	MK/gcM4LkkCbaZFcMSM2iNf4JWcSZHMg1SGNaKe2b6428Ajd4jHN91cmsX3k4IsewzlDW9ky3MQ
	8TfeViYBuMQiwLR/F2XC2WfkMyUDkXDgmryi02fx7q4J9VdUPjb3szXx99R39E8oD/
X-Received: by 2002:a17:902:e54e:b0:267:a5df:9b07 with SMTP id d9443c01a7336-2a599da5160mr56673845ad.12.1768459923615;
        Wed, 14 Jan 2026 22:52:03 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e7a3c6fdsm235081015ad.15.2026.01.14.22.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:52:03 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v5 0/7] riscv: spacemit: Add SpacemiT K3 SoC and K3
 Pico-ITX board
Date: Thu, 15 Jan 2026 14:51:39 +0800
Message-Id: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHuOaGkC/23QQWrDMBAF0KsErasympGNlVXvUbpQpFEjSuxUU
 k1KyN07SVqIi5d/xPuCf1aVS+aqtpuzKjznmqdRQve0UWHvx3fWOUpWCNgZNL3+IL3zNQcdmw7
 RdRagN25wSsSxcMqnW9vrm+R9rm0q37fy2Vyv6z2z0aA9ROz64GJw+FJyDbX58hymg7pWzfjAE
 ZcchZNPlChESINf4fTHezAwLDkJ5+gc72wgH2mF2wduYMmt8GgdJvIEKf3//XIfpvDnl6zb7us
 o4azl/ZDbdjPyqenfcivi8gPXxYELlwEAAA==
X-Change-ID: 20251216-k3-basic-dt-cd9540061989
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

This series introduces basic support for the SpacemiT K3 SoC and the
K3 Pico-ITX evaluation board.

In v5, patches 6-9 (dt-bindings) have been dropped as they were accepted
by Conor and applied to riscv-dt-for-next.

The series has been rebased on linux-next tag: next-20260114.

The SpacemiT K3 is an SoC featuring 8 SpacemiT X100 RISC-V cores.
The X100 is a 4-issue, out-of-order core compliant with the RVA23
profile, targeting high-performance scenarios. [1]

The K3 Pico-ITX is an evaluation board built around the K3 SoC.

From an RVA23 profile compliance perspective, the X100 supports all
mandatory extensions required by RVA23U64 and RVA23S64.

Link: https://www.spacemit.com/en/spacemit-x100-core/ [1]

Changes in v5:
- Patch 1:
   Add Acked-by from Paul.
- Patch 5:
   Add Reviewed-by from Yixun, add Acked-by from Conor.
- Patch 6 (Patch 10 in v4):
   Update the copyright year to 2026.
   Update the commit message.
   Set M-mode maplic and mimsic status to "reserved".
   In maplic node, use riscv,delegation to match kernel binding. OpenSBI
    accepts both delegate and delgation, but the binding documents only
    riscv,delegation.
- Patch 7 (Patch 11 in v4):
   Update the commit message subject line.
   Remove the unused aliases.
   Update the copyright year to 2026.

- Link to v4: https://lore.kernel.org/r/20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com

Changes in v4:
- Patch 5:
   Adjust maintainers list in alphabetic order.
   Declare spacemit,k3-pico-itx as an enum, which could save future
    code change when adding new boards.
- Patch 10:
   Fix missing blank space after comma in simsic compatible.
   Add m-mode imsic and aplic nodes, per suggestion received from Samuel
    Holland.
   Adjust node properties order in nodes simsic, saplic, mimsic, maplic to
    follow the DTS coding style.

- Link to v3: https://lore.kernel.org/r/20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com

Other Changes in v3 include:
- Patch 1:
   Acked-by: Krzysztof Kozlowski
- Patch 4:
   Acked-by: Krzysztof Kozlowski
- Dropped Patch 5 "dt-bindings: serial: 8250: add SpacemiT K3 UART compatible"
   as it has been applied to tty-next.

- Link to v2: https://lore.kernel.org/r/20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com

Changes in v2:
- Patch 1:
   Fixed alphanumeric sorting order of compatible strings (swapped x100 and
     x60) as per Krzysztof's feedback.
   Update commit message with more information about X100 featurs per
     Yixun's feedback.
- Patch 4:
   Fixed the order to keep things alphabetically.
- Patch 6:
   Use "one blank space" between name and email address.
- Patch 7 ~ 11:
   New patches. Add description of RVA23 mandatory extensions into riscv
    binding YAML file.
- Patch 12 (Patch 7 in v1):
   Removed aliases node.
   Updated 'riscv,isa-extensions' with new extension strings available
- Patch 13 (Patch 8 in v1):
   Updated the memory address to the hardware truth.
   Added aliases node in board dts.
- Patch 1,2,3,5: Add Reviewed-by and Acked-by collected.

Link to v1: https://lore.kernel.org/r/20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Guodong Xu (7):
      dt-bindings: riscv: add SpacemiT X100 CPU compatible
      dt-bindings: timer: add SpacemiT K3 CLINT
      dt-bindings: interrupt-controller: add SpacemiT K3 APLIC
      dt-bindings: interrupt-controller: add SpacemiT K3 IMSIC
      dt-bindings: riscv: spacemit: add K3 and Pico-ITX board bindings
      riscv: dts: spacemit: add initial support for K3 SoC
      riscv: dts: spacemit: add K3 Pico-ITX board support

 .../bindings/interrupt-controller/riscv,aplic.yaml |   1 +
 .../interrupt-controller/riscv,imsics.yaml         |   1 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../devicetree/bindings/riscv/spacemit.yaml        |   5 +
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 arch/riscv/boot/dts/spacemit/Makefile              |   1 +
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts       |  29 +
 arch/riscv/boot/dts/spacemit/k3.dtsi               | 590 +++++++++++++++++++++
 8 files changed, 629 insertions(+)
---
base-commit: 78ffa9bb137071c00eec2d4afc247ef92d5c0b90
change-id: 20251216-k3-basic-dt-cd9540061989

Best regards,
-- 
Guodong Xu <guodong@riscstar.com>

