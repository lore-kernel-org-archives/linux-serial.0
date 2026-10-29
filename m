Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299654;
	b=h+ULUs9VoEw4ZK0G/G5eNaZwMdHjF0a/zEEGbbSkLUaLgFg7BK4aXquek0NKjjD9O+g4
	 mqSRGnAfi+8BCv+MtEAwIaxhSsNEu0Y3Cu1s4s4rwTuI6KQs9GqTj45EcEwwL4Z1Y5RYU
	 QgNohUZ8aGXea+p4Un7vZeSji5ZYEgEiCJcTzjX8MtHt+CAxmbnIcoV2+/VoazuJ//4F7
	 57SUWP/eulNdopqv1TZq9ZNdABP/2kfknUjMEE/87ae0NjTWXBkyQFaAi/nc513mVwxiQ
	 SAI35p7GX4oxMkA2NMlyb0NXkhrsgv0qUfW7wZNnYP0Q+x1d0B2aPCtlRzpSwRDcZYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=TEabyGl5Fif5n7bh2NaQdC92feX3sIX7C9fNc4h7CgA=;
	b=Gy3Ptxopz7+PM3ISkw5f+mbNBoRP8M5d6vq66/xLKxNjK6dXjAXQJsu7yzVWLzb1NyUR
	 3gc6vEfpESal2Hi8X+FT7wMXW2SIy3RP6HqckpEASxpGagGpc7RZ7jz37iffIXfl5CKHg
	 d4KsjyrqTIvtS/JwKWPwmuuwGeInpmLrrubkXYHRMTGvx/2bbAfn9puRgSteOBB9bQcv4
	 OpXxl89bRMDASVPSAekn5e6Ty+vBM3xCz9m8IIpvvswOzBwp4PX6H1U7ocd9OVg+WUtCJ
	 ZnOHSmXSwn5E1UwG7xcWi7+lWQlh+dbKbNBA2LdGz3Qysbieb9XZAbIcJu4DM/keaIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8s7fxd3;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B423606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 18:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B423606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8s7fxd3
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-8439fe796ebso1702096a34.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793299652; x=1793904452; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TEabyGl5Fif5n7bh2NaQdC92feX3sIX7C9fNc4h7CgA=;
        b=Q8s7fxd36naxP2kP8nJ9igBwF5+zYHiaVI49g7ZD2eKgyHEHMhh39mlj9JJ3T7ZJSo
         MSq25gT8POwtZcM/oTtjT9OLG0rBZYcPYrxhSGY+Tj4RHYqUJCsMeZiw4h4gDajPs9NO
         BSuyU+j28CDN3zId/4aCz2mFezy5nTbMV6lBt8dDt+qfIUyenRZZJ7rfYv0whokV2cbb
         X/Cbbamjcn0EqdXFdUpObWQ5WvN3e10IrGYA4HwqCcoxFaEpEORR3hXvJQMPLWW1oW3a
         lWuudorcPv46KdqhDXAAdaL7uCJ25jgaFxTrI3c515pFSiIzYX9lOIRtqSUaHJFL7Eig
         VVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299652; x=1793904452;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TEabyGl5Fif5n7bh2NaQdC92feX3sIX7C9fNc4h7CgA=;
        b=pd9IqteG5eD/DaBIfJimVGcOMzr1lVpMdl7wv+XOSqMhlcNCSwrFm5yKU7KU0woJ4G
         4Q7Nvy+gah3ASPAiDUxKKULh/9yQ3M3mjlMTbEh/zRtgF8GMdfT+li+Fvs3+1U3RDZRj
         T+VN/VXH981Gp9mxib0raJOWEssfBIhFDuhGZ1+axTqwMiBwy65gpAU3f561RrNhq3Z/
         8mP4pMP8A4dIRn9odVfUBDqUtCpS2iwmzzjxpAT4RAdlhGIkYSm+kTy6bSOhgAoYA4aD
         ko21HHBT8fDmux48RDwaizaEEaoVM+/cKycpi6ILY3a42bVKizIgibGgierZ8HSUAEE+
         AGBw==
X-Forwarded-Encrypted: i=1; AKwUvBymfuk5ZPrEi7CGJgDHZxzYoCO2EVlHgCBA2PsaQC2nu4z0ySxtIIrHqNy7ypO/9RUDA1xuM7as4hrxrpo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJo3Az3ldmxlpDwIPv6VPIta4lnu+p9/iIBpifqvYzVAmgohUeh
	Z9FJh2SoJYCtekFFwyYkIL1X63goC2eeU3nskRuS/+IZgxlZNf4iIoH/
X-Gm-Gg: AYBFou10LUvPi2TexCPgeI/ujNRpsPHwFlSs4g1+DMW0+XxHZpY4VbYN/W2YSOWexcf
	PMQ7zgG949YS7j9ILAW5EX0XmpxGQciU1ZHvsborCHgoAAGBRxkxSACQlwc2jazgIzR77q29V9h
	zPW2Ez5oVMSvzNxJ7F0d212sUcylLXHPL4gSEDH7sgUlRaesS+PoqhEEa1vnTP8JN+B7gwGimMz
	+j3fHuf28NwGq7ev54D+L273Grzaz5X/rpMyMB4EFfLJRVcnnHbdXaFwIiXihsYpI5ctMiiwjyx
	1lCYD61zzblT61ady/M55ko4RXjyjgKCdvZ25ES+bsumQtkvXraxa7HbnQcrXtTd5xOBH+54p9n
	EROnwpgh/V86mS1CLLuF+qx/OBkBob2o2b4aP4i8h2/DmJ7V8DMNmzn85pnEhIuNaT/UbiTiR2c
	kUeLgQTlaKLokng5zb7RYcGZLHE9JM91CUZHfvTRqVKRH4u8h5/Yjgd8Jh1ujQrweZBnfTRjGaH
	DOX6URz1FP6RsyNty78w44QVA0qwGHsCk9Ob7ErL0t/bk0C2ed23+Kdu5ZgN7Te/+3NFHVu9m8e
	CqcCA00ZQPjYV189Zb0URzJUwkS73QK6/lY+lyW2q3DLv99EKM2l9RdqvYpL5aIqlvAN1AlGirL
	EiJ4jagDjDbhXRQvY63ktf4VkJMrfFMwu7ah8xw9Rb2YdG/CVChITp84B+OytozmErs+rePpy9f
	4F8sig9ZvIpGZEQNLxLiJTvO1drZwBkK4GS3B2BmOZ4HDazqgYuIs=
X-Received: by 2002:a05:6830:25cc:b0:81f:6e05:c1aa with SMTP id 46e09a7af769-85d3657604bmr21613a34.18.1793299652493;
        Thu, 29 Oct 2026 11:47:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cfb83sm221871a34.14.2026.10.29.11.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:47:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v5 0/8] serial: 8250_dw: describe the Allwinner H616 and
 A523 UART configurations
Date: Thu, 29 Oct 2026 12:47:21 -0600
Message-Id: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43S3UrDMBQH8FcpuTaS73RDxPeQXZykJ1ukXTXp6
 mTs3U23iWW4IfTm0OR3/pyTA8mYImayrA4k4Rhz7Lel0A8V8RvYrpHGptREMGE4E4LmneviQDe
 GG7qDNNAQQ09HTr2G4JuA2jtGyvX3hCHuT/Tr6lyXu2/oh8mbTmxiHvr0deo98uncTxt5u035G
 EUF0gEKdFC/rDuI7aPvOzK1GcV/IVEgCEwvpGbKSH0NyTmk7kCyQKI2wXNXe+n5NaTmkL0DqQI
 10iLjdWgYmDl0PI8w4ceuLGk4z5U4yEjL/wIuK+OU00oG4LXVViwseKsNmIAGjQqaGWdrpWCaf
 Yc5w2m7y+rpOtr0JqCltdAlzydtYnkXfbpE5FRxyxVYjVzDb8TnW6z6i037IcU1bWPAIXZ42Sy
 nVvISstGMyWZur47Hbz39dWOsAgAA
X-Change-ID: 20261022-submit-h616-uart-fifo-v1-c5afcdfe5cb0
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

Allwinner UARTs use FIFO-relative receive thresholds and an optional
register layout that differs from the generic DesignWare integration.
Describe the H616 and A523 integrations through dedicated compatibles and
common sunxi setup helpers.

H616 has fixed 256-byte FIFOs without a readable FIFO-depth register. A523,
A527 and T527 have different depths across their UARTs and report each
port's depth in the FIFO Clock Control register. Use a fixed platform-data
depth when provided, otherwise read FCC in the sunxi setup callback.

Derive the transmit load and receive-trigger table from that depth. This
keeps one implementation of the common 1-byte, quarter-full, half-full and
depth-minus-two mapping for both fixed-depth and runtime-discovered ports.
Keep PORT_16550A, configure automatic flow control, preserve BUSY-safe
integer divisor programming and keep the UART clock gate enabled during
termios changes. The sunxi setup uses PIO.

The series first introduces platform setup callbacks and a shared RX
trigger conversion helper, then adds the binding, driver and SoC DTS
changes for each integration. Based on tty-next at 6b4b543fa187 with the
posted RX trigger callback-lifetime fix [0] and DW BUSY-safe divisor fix
v4 [1]. Platform setup runs before installing the BUSY-safe divisor setter.

[0] https://lore.kernel.org/r/20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com
[1] https://lore.kernel.org/r/20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v5:
- Reject FIFO depths that cannot produce positive, byte-sized RX trigger
  thresholds, report the invalid size and propagate setup errors to probe.
- Add the A523 UART compatible and use it for the shared CPUX UART nodes,
  including those inherited by the A527 and T527 boards.
- Read the FIFO depth from FCC when sunxi platform data has no fixed
  depth, preserving the fixed H616 configuration and FCC clock controls.
- Explain why the per-port trigger table is derived from the FIFO depth;
  use the same sunxi helper for the FCC-discovered A523-family ports.
- Move the shared RX trigger conversion helper into 8250_port.c and
  export it, following Ilpo's review; retain Andy's review tags.
- Use FIELD_PREP() and an intermediate trigger value when building the
  sunxi table, following Ilpo's review.
- Select the DMA setup helper directly for the 64-bit-only Octeon
  platform and match the single-line comment style, following Andy's review.
- Carry Krzysztof's Acked-by for the unchanged H616 binding addition.
- Link to v4: https://patch.msgid.link/20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com

Changes in v4:
- Introduce common Allwinner setup helpers with the fixed FIFO depth
  supplied by compatible-specific platform data.
- Rebase onto tty-next at 6b4b543fa187 and the posted DW divisor v4 fix,
  installing the BUSY-safe setter after platform setup.
- Use an early return for FIFO-less DMA setup, following Andy's review.
- Default to generic setup when platform data has no setup callback.
- Select Octeon's optional-register discovery with IS_ENABLED() in its
  setup helper, preserving the existing 32-bit and 64-bit behavior.
- Extract the shared 8250 bytes-to-FCR conversion, including the
  unsupported-table check, into a preparatory patch and use it for
  H616, following Andy's review.
- Set the fixed 256-byte FIFO depth in H616 platform data and omit
  fifo-size from its binding and DTS, following Krzysztof's review.
- Precompute the Allwinner RX thresholds during setup and retain the
  sunxi FIFO-depth helper for filling the table. Use named FCR encodings
  in the helper, following Jiri's review.
- Share threshold-table initialization and callback assignment through
  a sunxi RX trigger setup helper.
- Group and comment the H616 trigger and RS485 setup.
- Link to v3: https://patch.msgid.link/20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com

Changes in v3:
- Introduce a platform-data setup callback in a preparatory patch,
  replacing skip_autocfg and preserving the existing Octeon setup.
- Describe each H616 UART's FIFO capacity with the standard fifo-size DT
  property and use the value already read by uart_read_port_properties().
- Derive the Allwinner RX trigger thresholds from the FIFO depth.
- Use an unsigned trigger index and conditional runtime PM guard,
  preserving error propagation when the device cannot resume.
- Rebase onto tty-next, replacing the earlier DMA prerequisites with the
  posted RX trigger callback-lifetime fix.
- Separate DMA enablement into follow-up work, retaining PIO operation
  for the H616 FIFO configuration.
- Link to v2: https://lore.kernel.org/r/20261023-submit-h616-uart-fifo-v1-v2-0-af0593504635@gmail.com

Changes in v2:
- Keep PORT_16550A and set the FIFO size, transmit load and capabilities
  during setup, following Andy's review.
- Select H616 setup through the matched platform-data pointer and remove
  the type and DMA burst-size platform-data members.
- Use get_rxtrig/set_rxtrig for the 1/64/128/254-byte receive thresholds,
  with port locking and runtime PM around register updates. Keep the
  standard half-full FCR default, selecting 128 bytes on H616.
- Advertise UART_CAP_AFE so CRTSCTS enables hardware automatic flow control.
- Rebase onto next-20261023 and declare the posted sun6i pause/lifetime
  fixes and their prerequisites for DMA enablement.
- Link to v1: https://lore.kernel.org/r/20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com

To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev

---
James Hilliard (8):
      serial: 8250_dw: select port setup through platform data
      serial: 8250: share the RX trigger conversion helper
      dt-bindings: serial: snps-dw-apb-uart: add Allwinner H616
      serial: 8250_dw: configure the Allwinner H616 UART
      arm64: dts: allwinner: h616: describe the UART integration
      dt-bindings: serial: snps-dw-apb-uart: add Allwinner A523
      serial: 8250_dw: discover Allwinner A523 FIFO depths through FCC
      arm64: dts: allwinner: a523: describe the UART integration

 .../bindings/serial/snps-dw-apb-uart.yaml          |   2 +
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     |  12 +-
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi     |  16 +-
 drivers/tty/serial/8250/8250.h                     |   2 +
 drivers/tty/serial/8250/8250_dw.c                  | 162 +++++++++++++++++++--
 drivers/tty/serial/8250/8250_port.c                |  21 ++-
 6 files changed, 182 insertions(+), 33 deletions(-)
---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261022-submit-h616-uart-fifo-v1-c5afcdfe5cb0
prerequisite-message-id: <20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com>
prerequisite-patch-id: d8219673210dac82d3adab41578ff2f76f5862c9
prerequisite-message-id: <20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com>
prerequisite-patch-id: 9a9395c715c2bf7bbcae5bdd16a339d7f2af6269

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

