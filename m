Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5A29B778
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408775; cv=none; b=WCE1jiwpBOH380zrwMXDSIhCESKXqgAmAOVI74vPgrWAqXezfnCqF81Yebyh+1Msi19HpeWrnm3RTXIVILzSuYQ3+tF2o7EHNPAwbDW/PoW/HlFzMbvb6F4emhXYcocXgki29H4J/8w4oe/u66FVMO2iI8xJKBoItwETOvduCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408775; c=relaxed/simple;
	bh=6X67lCmir/2S11a1n7DUM2/s4Tf0fqpcdoiIQ36e88U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G7X8fuBuKgiC4V4/JBAPWeR4GUmx0WxJFqN6E91bxWa8yOgTOI8j6TI3nSSpPNuWyhl6qwBupeOWZuhZNzA/xqwEW92l6DK35xF1z97d82E68K0yabj7rfTftBxCNes1QFEl0IKZ5YO+rgg0yCIa/v2jYhnARWrulqkIoTzmfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kHFpYTF4; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kHFpYTF4"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso5186956a91.3
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408772; x=1767013572; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSLBcbUhwlgDEaLrs1/PzmUOuvFFTI4tz34GWoit1b0=;
        b=kHFpYTF46RZSFDHHPaqL5AFkShfMAqiQg2ktyM6gaYjMeIFtyJft2qOW8BmkZ+IK4B
         MslR5UKRf7a2euo3D7WfyiEsDZIGzaoapmuUlCcSAb5HXhNNbtgSt0sqUYP3W6NftWaf
         OZ51Dre69FhhlcfQphmCbxVw8okRgUcT1CRJlsa/FGd2PH9PtJ7q7tBBRS3Cvqol4FHk
         F5nhS42Uq5YrRIQSgqlwTSh3g44/lJVE4A6B9lLD8dZgNMyVpchf6gBtttEQ0ajpFWVz
         UKuO2jSN17E5yCWc6xNNwRtqO2aHkNQsfQvHMp2IM4fKHfHwl8H2O5K1ydP1GVZnn8ll
         kxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408772; x=1767013572;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSLBcbUhwlgDEaLrs1/PzmUOuvFFTI4tz34GWoit1b0=;
        b=KBhwm4aQ7dRj1S8jURiTUJGhuJvaSjfFwCXhe2At7jKHAZE94uzEv6RFxwqeWTmueM
         T0a/snWhshzmAFVfdJ+sH5b2YxfGp9ursN2RIHxjYRiZmjXUHfKLDfAV341I3Vpv62ed
         UT8UxcosnY15PuwlatHqNGxAm3NAuiQewEpCSbIN+8QGV9zllD8VKgbZ0e/yWUD02ZMo
         PCfLWGVrAdvNkKriMU8TZwS47Vbj9F0jjpD/rl7vhpvQJwYnAK7DtwQTrGcHjJ6b8LrJ
         zl3Aq408q77yxKpHwXrCPyJ/vVYU0cmvgjN4wdF2o1AtaVkvjT4y7Rkbrq2OyhZYHYn5
         Ww8w==
X-Forwarded-Encrypted: i=1; AJvYcCUXzUUMn6VjUKV+lLvQv3I5qr/yA5lRceJzZBUM9zwwrecTKyP5t371eABkr4Y5OEAkHBaSkUf9ns5ugBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu97c5r2U7U53hyCTblint6TV38JcJyaneHa3C1tsoGOFc9goK
	4W9V1mE8BGJgnp/DEEQPBLneAY6bYsJegj7L6fe8njf0/nJpmzcE5mWNWt5h2sZX5F+fowlBAZI
	Oe53X7PM=
X-Gm-Gg: AY/fxX5w3yC9Kxs1LgVcKtRgVmioLIhMrlNKcfQnSOLaW5sz1UvXyF1T85eqqiLpAHM
	FQOtHNXKOAIBW6xST/8ftuRswivZAhBXObR3L4/SrP9fScx0YzVNYHBLW3S4REXmcawKCPNr3bU
	Vdn6/IJMeMyesDcHUX2oOK3BSVLSWUMRc+wQ9nKNuOmoFLT3SnA3YMwvvxYgbqW7eCYzFRKRQb/
	7f+2KpDNgPA9ajXd7HQkzHpjPM8uiglMrBK6NR7DlvMLwQh9ciyQ2MTMWg3F/JFkvZhDwuIiJXy
	3bV8kBmNj0PHORg0JEX/p2RKY1PG/tl1IW7cGiE3PsT5HY93uG8EOzayNvLbkdr5C8Vy82+o3CK
	9+BCOvBq0BfZfm0kWGk3Qy2EkEYxVAWVNApIiTXqK6UllkUS3UUP+sR8kYTKlVCwQ8EHf4Jtt5x
	mRkE2fOowxtkDd91oOMQ5t+Q1+MR6rQgPfs2fyUj2GnQ==
X-Google-Smtp-Source: AGHT+IHXI9Uk+L57JPJ2MjX19LtjvDYEjxYY7iQ/11Hl0xX72T2G5hRIIcsMHGDw/P1z/NE6Wuw7Mg==
X-Received: by 2002:a17:90b:3c4e:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-34e92139f2dmr9527010a91.13.1766408772522;
        Mon, 22 Dec 2025 05:06:12 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:06:11 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v2 00/13] riscv: spacemit: Add SpacemiT K3 SoC and K3
 Pico-ITX board
Date: Mon, 22 Dec 2025 21:04:10 +0800
Message-Id: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpBSWkC/23MQQrCMBCF4auUWTuSRFOMK+8hXcRJtIPYlplQl
 NK7G7t2+T943wKahbPCuVlA8szK41DD7RqgPg6PjJxqgzPOW2dbfB7wFpUJU0FKwR+NaW04Bai
 PSfKd35t27Wr3rGWUz4bP9rf+d2aLBqNJzrcUEgV3EVbSEmVP4wu6dV2/t9tfw6kAAAA=
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
 Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

This series introduces basic support for the SpacemiT K3 SoC and the
K3 Pico-ITX evaluation board.

This series (starting from v2) also adds descriptions about ISA extensions
mandated by the RVA23 Profile Version 1.0 into riscv/extensions.yaml. These
additions are implemented in Patches 7 through 11.

The SpacemiT K3 is an SoC featuring 8 SpacemiT X100 RISC-V cores.
The X100 is a 4-issue, out-of-order core compliant with the RVA23
profile, targeting high-performance scenarios. [1]

The K3 Pico-ITX is an evaluation board built around the K3 SoC.

From an RVA23 profile compliance perspective, the X100 supports all
mandatory extensions required by RVA23U64 and RVA23S64.

This v2 series includes:
 - DT bindings for SpacemiT X100 core, K3 SoC, and Pico-ITX board.
 - DT bindings for K3 integrated peripherals: CLINT, APLIC, IMSIC, and UART.
 - Initial Device Tree for K3 SoC and Pico-ITX board.
 - Add DT bindings for mandatory extensions of RVA23.

This series has been rebased to v6.19-rc2.

Link: https://www.spacemit.com/en/spacemit-x100-core/ [1]

Patches 7 and 8 from the v1 series have been renumbered to Patches 12 and 13.

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
Guodong Xu (13):
      dt-bindings: riscv: add SpacemiT X100 CPU compatible
      dt-bindings: timer: add SpacemiT K3 CLINT
      dt-bindings: interrupt-controller: add SpacemiT K3 APLIC
      dt-bindings: interrupt-controller: add SpacemiT K3 IMSIC
      dt-bindings: serial: 8250: add SpacemiT K3 UART compatible
      dt-bindings: riscv: spacemit: add K3 and Pico-ITX board bindings
      dt-bindings: riscv: Add B ISA extension description
      dt-bindings: riscv: Add descriptions for Za64rs, Ziccamoa, Ziccif, and Zicclsm
      dt-bindings: riscv: Add Ssccptr, Sscounterenw, Sstvala, Sstvecd, Ssu64xl
      dt-bindings: riscv: Add Sha and its comprised extensions
      dt-bindings: riscv: Add Supm extension description
      riscv: dts: spacemit: add initial device tree of SpacemiT K3 SoC
      riscv: dts: spacemit: add SpacemiT K3 Pico-ITX board device tree

 .../bindings/interrupt-controller/riscv,aplic.yaml |   1 +
 .../interrupt-controller/riscv,imsics.yaml         |   1 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../devicetree/bindings/riscv/extensions.yaml      | 180 +++++++
 .../devicetree/bindings/riscv/spacemit.yaml        |   4 +
 Documentation/devicetree/bindings/serial/8250.yaml |   1 +
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 arch/riscv/boot/dts/spacemit/Makefile              |   1 +
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts       |  38 ++
 arch/riscv/boot/dts/spacemit/k3.dtsi               | 548 +++++++++++++++++++++
 10 files changed, 776 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251216-k3-basic-dt-cd9540061989

Best regards,
-- 
Guodong Xu <guodong@riscstar.com>

