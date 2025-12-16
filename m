Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738703B1D1F
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891976; cv=none; b=ie+7Tp514yrIvdo9mVm0hNqnk/q0qE7bOn3iHPssRGgbE+SzPinTbiSXxlaCNnD1Ztn+rrW78g7BTxtgKfbEgmDAZmbAVKD+pwZXN/z7RIlQBfzBtNxfzcNgDCuY12gmfZzP7N756KWLVy81fCOPDp5LK36Lokzppr8HhaEr0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891976; c=relaxed/simple;
	bh=pU0oP5/c/7ypY5esHJsYEwlRjlrC/o562rPa9fS6psA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AYcT3rZTJ2s4z7Pvf5I9ZEvo/FkTP0dvR0Qm/vp7HO/HOX5t83ithfzTony62xWSjKdM7KPXoZiMmTZEPy3x0KefVWHgdP4tu+7VS1TMfZvMUfbKpEikeBCJSKbppnUrgEQC23UjAqaaFCLmiJR/yL4PETUK2h35fY9+0v5ndy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=xmJBiovh; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="xmJBiovh"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a081c163b0so33189765ad.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 05:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765891974; x=1766496774; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/JfJQXcFgX18niVnHrsIFrsFHpq0fWX7xoHVIFhehA=;
        b=xmJBiovhlF6wAgNlJ/xyglkPnnA+dECBnyxFoMVhdRWj6PWVJ9nbgG0ZJjwE7Iau9U
         L+agjAW02YptT6uSt/E2HJ2idL5yw+8ZOn4XRB4k1BhnErxZw+B3gHKhYI7zH4oM8Yu2
         TqQZ4s24PYYx2WwF2CEyYYJYd1NMJdjvLyGxZ68AO9GPSNhz7QFx9GxwmrRdwRw4yOpf
         vGoBP30K6XP8802QUDJuGahcbAnL+7ugPJ8kpnOrbgn+sokwcHz0SLwhH27JXO8ceoD7
         affumjNeAC/wOMFV1kdhiaWJAlwAAwCC3G1WqumIfw8RIBS1DxHoLrAtgESqKGPEsUjY
         q1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765891974; x=1766496774;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/JfJQXcFgX18niVnHrsIFrsFHpq0fWX7xoHVIFhehA=;
        b=JVR2wD6mLjhXonKnMd68scOPF/43elhR3SzDn6D5mRwXNW/qwdMWvhY/GbjySySoPe
         2xZ0HDcmcNABNPMsgF1cKMyLW4QzSn0MhC42F8OP2Yst8TqPqvwyM4nuok+uAPCecBQR
         M3zXe6ZzxHVH0nugK7eT4EiGGk4PCCTrIO19sKnEVQi9/6i5H8JhBsbPz4mqXb0A1myx
         sfyUlqrobG4M9Om2DITpgVp/emm7W/5QrkQMInB6aPovyOfi6TZ8iNAKljYSrJRhaBAH
         i4wmPn7OwAvQXhfcbca2qIUPoMuSRl8JuUbwOoxdpeQm7JlNozTfNdvb9Ns1B2xJoLBZ
         7hoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCuDI8HALnvgAi4Vw3Aaig0vCQH8cP/OSfMcrcNXATrBddCdhRcA/NlxUVlaQw+OZEnf8mp/GTF6a6Vxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGHrdkGfiGeXrEHoV2Qnso09zZlcCBXd7+eJSegrbj9FSdKsR
	hxYYzD5rgaahHV5T91H8Y1sPI+mCk3s030FFA9ao5VwOWg/tR8OOSfS007IBbqjIdn4=
X-Gm-Gg: AY/fxX7NLQA1C0BlWGw+L//X3XY+vM1nxuloanp6NipKKvqFYhdJ3zTOUwBjPf5oWtb
	CkUn1tgEJiDaBzbJjCQ68RyrI54D6egHlUx+7Hr3NtSLMZ3XZes2t6rLQZhMkbeKP6LTbQmJ97Z
	71XrJa9y/dOzB7vXze7vBTEMmIkOa6SkK93B3a0hVUYBcO6bu9R6iBnXeWTW145/Htsgo3S83Dl
	HA34W6ekKJdgmbM3XVibhXA7OZJMy3ug3ihkYbC/dHLO67a+bUhpy0QEAomKElPkpg/p8tJeZQ5
	nNekBsTHV+XIYPpl6bf8nHmfZIADR4tK9JuNcqOTvSU2kwOncKPVM3ygFbnJ+L9rbwKwn4OLLqw
	8FlZ44j8nqb9pM4tJInbpQQ6Zv9R1who+bquxVI0Apd06Pjf/XgBsZpGsYLa69oDwPSbuAhbzj1
	Yi0V4VIGaGxe0Y39RHXgFmCjdwK5DEnIiEL+QtW8nLtw==
X-Google-Smtp-Source: AGHT+IHT8YPzl6f7Pnw8yu1d9OLksn7u1Cax08hiwcjf1bsYEfnVPO1K1qwPGMHdLgZugryriieEFw==
X-Received: by 2002:a17:902:ea0c:b0:2a0:f47c:cfc with SMTP id d9443c01a7336-2a0f47c0e76mr73502685ad.34.1765891973637;
        Tue, 16 Dec 2025 05:32:53 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a14625add8sm15829525ad.61.2025.12.16.05.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:32:53 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH 0/8] riscv: spacemit: Add SpacemiT K3 SoC and K3 Pico-ITX
 board
Date: Tue, 16 Dec 2025 21:32:24 +0800
Message-Id: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGhfQWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Mz3Wxj3aTE4sxk3ZQS3eQUS1MTAwMzQ0sLSyWgjoKi1LTMCrBp0bG
 1tQC0HgM4XQAAAA==
X-Change-ID: 20251216-k3-basic-dt-cd9540061989
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
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

This series introduces basic support for the SpacemiT K3 SoC and the
K3 Pico-ITX evaluation board.

The SpacemiT K3 is an SoC featuring 8 SpacemiT X100 RISC-V cores.
The X100 is a 4-issue, out-of-order core compliant with the RVA23
profile, targeting high-performance scenarios. [1]

The K3 Pico-ITX is an evaluation board built around the K3 SoC.

This series includes:
 - DT bindings for SpacemiT X100 core, K3 SoC, and Pico-ITX board.
 - DT bindings for K3 integrated peripherals: CLINT, APLIC, IMSIC, and UART.
 - Initial Device Tree for K3 SoC and Pico-ITX board.

From an RVA23 profile compliance perspective, the X100 supports all
mandatory extensions required by RVA23U64 and RVA23S64. Ideally, all
these extensions should be listed in the 'riscv,isa-extensions' string.
However, some mandatory extensions (e.g. "ziccif", "sstvecd")
are not yet supported (listed) by the upstream riscv/extensions.yaml
binding.

To avoid validation warnings (“Unevaluated properties are not allowed"
when make dtbs_check W=3) and to prevent the kernel from silently
dropping unrecognized strings, this series only declares the
isa-extensions that are currently supported by the kernel bindings.

Link: https://www.spacemit.com/en/spacemit-x100-core/ [1]

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Guodong Xu (8):
      dt-bindings: riscv: add SpacemiT X100 CPU compatible
      dt-bindings: timer: add SpacemiT K3 CLINT
      dt-bindings: interrupt-controller: add SpacemiT K3 APLIC
      dt-bindings: interrupt-controller: add SpacemiT K3 IMSIC
      dt-bindings: serial: 8250: add SpacemiT K3 UART compatible
      dt-bindings: riscv: spacemit: add K3 and Pico-ITX board bindings
      riscv: dts: spacemit: add initial device tree of SpacemiT K3 SoC
      riscv: dts: spacemit: add SpacemiT K3 Pico-ITX board device tree

 .../bindings/interrupt-controller/riscv,aplic.yaml |   1 +
 .../interrupt-controller/riscv,imsics.yaml         |   1 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../devicetree/bindings/riscv/spacemit.yaml        |   6 +-
 Documentation/devicetree/bindings/serial/8250.yaml |   1 +
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 arch/riscv/boot/dts/spacemit/Makefile              |   1 +
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts       |  25 +
 arch/riscv/boot/dts/spacemit/k3.dtsi               | 529 +++++++++++++++++++++
 9 files changed, 565 insertions(+), 1 deletion(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251216-k3-basic-dt-cd9540061989

Best regards,
-- 
Guodong Xu <guodong@riscstar.com>

