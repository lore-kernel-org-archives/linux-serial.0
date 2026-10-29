Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250356;
	b=KKo3EMGToGXo1QiUU5jgDAp9SIQPuCifNW3Cff35H72d+oISozGD4U8LQsQi9RFzuh6+
	 vwtgfZkTC0gieqEPIK8Rim5flIK3FM2AqiYMsKO1fl0jy7d7tYNRWj5jnJAbbC1NNjNDH
	 qE68T9Wbh5idIvlxXIS5lwsOj3caonkytmoEApPqkJqFXo3mY+6rHT6CPT0zFlkndoDZM
	 X6UkUKEHPXErmV4jYKLQZb90OPPr7eaTsmqBC5h/4vpyF3x6AzIwZvQt2Q980jdtHxxQd
	 RpzDCE3NSEurooY/zwP0OH6P9CtSW3gduLDDk0vp4zoJoIJUkbKW9hgXMSb2VzYjeog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=qzyK/sep4k0pgE8m3Kj8rFxd4gj+fEVyhh5FmlJnLT4=;
	b=x9OrwntwMdseeb0cBvGgE5P4ePr/KRzcoR6X2crMKqQs8JxP/OMog5gM7YXaHtz79IO5
	 1yrj0LtweYnSauNBPx4a35M+ZidgFau3PujIslxA05cVyEDhVaDlGEad6FBiwnvs37p4N
	 Hyz8HEaMPoIJbE+cPVXb+nuAD03LcwhyiPvNpGaEH0AmItJsG1UIhdMd7TaHvNy/pEuUH
	 TLkO1VQutODIgtXRnNFIgjqk8hLVfyYXBORfUrtOCK92jAi/ndSXYkra00c7yZ2qqO/DD
	 OYwWVd7pRd0HjmsAfHfy4FMIb15nh60Vxh69EfPuePUaNRtHhhCnXYzyhDLQhPnX0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=If3Xgjta;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137C606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6137C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=If3Xgjta
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac6fe4aff0so1665455a91.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250355; x=1793855155; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qzyK/sep4k0pgE8m3Kj8rFxd4gj+fEVyhh5FmlJnLT4=;
        b=If3XgjtaRu0jjJanap+LIdclkOSsGDozBMQjUhhi0DZKT6XoadeXOYBixTQ3hbQRIL
         NBNjcTU09Jc102qL/PavE3OOkzvpbnFyFWhMRb68Es6+JMpgmJc4/izTGUTq90BcXTR3
         MKd6bgSoe6osDyeEYSwYPa4F3DwL2LHNFW+1vsTfwU8engZ8qtf5sC3tdJyp8e751DM1
         eesZ7OM6Afhm8vqNxrhRkC8muaarybhUX8uQsOoFIo4PE8H/xzAw8pBJkYCyX7Hz2Zo4
         p1I3P4zwd0Ysq1u35IdcewQBFN/0NUZtaNzyjy42mRVVKaooyKdiM41Mz7BocsBZlfjd
         3Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250355; x=1793855155;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qzyK/sep4k0pgE8m3Kj8rFxd4gj+fEVyhh5FmlJnLT4=;
        b=fHNGIzZkvAvhEL6+Jibnf1DnnJfWyhbLDnqcTj30KYCG1N9prhsRy/tjcmZOUwmBgm
         Bw7yoeZg3CMgrrzKFMx+AF+Y3J5dAb5ZNTIRBIlQcGMyaEjNqKcWMF4wVg8OQB4S6i5k
         Ve7mEG04RGA5+AC3M6tSYmg6xnua4zodXCwv3aChx0z5tKGgMXZ4LhZ8L33Al6ufeTZF
         dKwvGYTHhsHQbw6jBpYVJai+euTqN6ENbEGyq2HC+aFTPHIchlg1Vm1NxHhLfKbd/Nkm
         2VU5s5W2FV1FFCSa/OhYqjEeVEJ6SsHJXbsMNz0Y34Mc+eBYlUMJg7Kgfkh6SRRJRZzd
         qfsA==
X-Forwarded-Encrypted: i=1; AKwUvBxrZq45v/645vU9mlg5bY7LhEcXkF9DLFBcxIybvhXYrwguFk/Ka5ML3fnWHtkK44+qyuItckYVObGRdQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYDHW5X86DSVuam12kFOQv+l6h7gnlLJoWlzzn2Cyqv0SG57gl
	QAyjH7seP9oH+xd7AgOGgUYxYDrAmXLGtj1/l9fMDiiIaKSmU6NgzHD0
X-Gm-Gg: AYBFou1a8iLqAbr4mrL1ItLmKUEvVwP7tRuWXKwuufJSfYUVvf0W/Gs4nWIkcTMtTVD
	QbgxwVfWl4AK22zgcdakaqEYU6vIdgIYrAPiPwhXXJ3+7lLRInN3Ur9gjcocRK7da15DJm0puCc
	pA0SAyxcw9eqRb43zBcyczavsqPASiyKHLzJ+85HEn0R3QbQeZ9h3Ua+swxQ8EK9Ub6rmMJMv9q
	ZS8t24EgyU3jQdA45T9ZkIkbJTBI1z0WMUK4PYpd/wNKS6PxH/NMMpT+MApgSyS4OOGPQMTQLWz
	8wt7CYehCmkvlJ7OizrmgLl2x6cHmZq/+7uXunBfhTWhnVitqHLRFOv9E8nkIESIhxUeVzSJy/6
	vR1MA1m7E2B9W6x0bLoWME0sO+5CgFnVPcUfL3A++/Y4XBxAlfEvti/OfzErc8+q6o0fNGkmlIu
	djgEqbLY/BtCQj2AX/nNGvbaJseN2qqGMseayr43Uxboru84qiUc542UB5EqRXtIr0RwOiBxl/y
	2RklHat7bdM9POGqoUdw+hnyc6U4aGeFvM2Uz2zsmjeGNcYPTc4VjhJpqvqnI9NeRT6T+7I9V90
	n951EqCS9mULRB+JkU5ULa/hN3K1
X-Received: by 2002:a17:90b:562e:b0:3ac:9176:e81c with SMTP id 98e67ed59e1d1-3ae580dd6d0mr3805262a91.46.1793250354465;
        Wed, 28 Oct 2026 22:05:54 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:05:53 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Subject: [PATCH RFC 00/12] Add BL808 UART3 support with a Rust serial-core
 polling console
Date: Thu, 29 Oct 2026 01:05:41 -0400
Message-Id: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXU4moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNT3aLS4hLdpBwLAwvd5Py84vycVF3DtKRUw8Q0YxNjkxQloMaCotS
 0zAqwodFKQW7OSrG1tQDtuKqpaQAAAA==
X-Change-ID: 20261025-rust-bl808-console-1fbe1af3434d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Kwanghoon Son <asdfkwang@gmail.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce minimal Rust serial-core abstractions and a single UART3 polling
printk console for the BL808 D0 and Sipeed M1s Dock.

The BL808 is a RISC-V SoC used in boards such as the Sipeed M1s Dock
and PINE64 Ox64 [1].

The serial abstractions and their BL808 consumer are adjacent patches.
Port registration is owned and device-managed. The adapters provide UART
locking for termios changes and normal console writes. Userspace TTY I/O,
RX, interrupt-driven transfers and DMA are not included.

I kept the driver limited to polling console output for now, so the
initial driver and Rust abstractions stay small. Does this seem like a
reasonable starting point?

The Rust abstractions cover only what this driver needs. Is there
anything missing that should be addressed at this stage? I'd especially
appreciate feedback on the port ownership and locking interfaces.

UART3 is registered as ttyBFLB0, using line 0 of a one-port driver. The
board selects it through a full stdout-path at 115200 8N1 without aliases.
Firmware initializes clock routing, gates, reset and pinmux; the board
provides the existing 40 MHz fixed baud clock.

Jisheng Zhang previously submitted BL808 platform support with a C UART
driver in 2023 [2]. The UART compatible, bflb,uart, is reused from
Zephyr [3].

This series depends on the exclusive MMIO reservation fix posted at [4].

[1] https://pine64.org/devices/ox64/
[2] https://lore.kernel.org/r/20230518152244.2178-5-jszhang@kernel.org/
[3] https://docs.zephyrproject.org/latest/build/dts/api/bindings/serial/bflb,uart.html
[4] https://lore.kernel.org/rust-for-linux/20261027-b4-rust-iomem-origin-master-fix-v1-1-16215ae197af@gmail.com/T/#u

---
Kwanghoon Son (12):
      dt-bindings: vendor-prefixes: Add Bouffalo Lab
      dt-bindings: interrupt-controller: Add BL808 PLIC
      dt-bindings: timer: Add BL808 CLINT
      dt-bindings: riscv: Add Bouffalo Lab BL808
      dt-bindings: serial: Add BL808 UART
      rust: serial: Add minimal serial-core polling console support
      serial: bflb: Add Rust BL808 polling console
      riscv: Add Bouffalo Lab SoC selection
      riscv: dts: bouffalolab: Add BL808 SoC
      riscv: dts: bouffalolab: Add Sipeed M1s Dock
      riscv: defconfig: Enable Bouffalo Lab SoCs
      MAINTAINERS: Add Bouffalo Lab BL808 support

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
 Documentation/devicetree/bindings/riscv/bflb.yaml  |  21 +
 .../devicetree/bindings/serial/bflb,uart.yaml      |  57 +++
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  13 +
 arch/riscv/Kconfig.socs                            |   8 +
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/bouffalolab/Makefile           |   2 +
 .../boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts |  18 +
 .../boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi     |  19 +
 arch/riscv/boot/dts/bouffalolab/bl808.dtsi         |  70 +++
 arch/riscv/configs/defconfig                       |   1 +
 drivers/tty/serial/Kconfig                         |  16 +
 drivers/tty/serial/Makefile                        |   2 +
 drivers/tty/serial/bflb_uart.rs                    | 334 ++++++++++++++
 rust/bindings/bindings_helper.h                    |   2 +
 rust/helpers/helpers.c                             |   3 +
 rust/helpers/serial.c                              |  33 ++
 rust/kernel/lib.rs                                 |   2 +
 rust/kernel/serial.rs                              | 505 +++++++++++++++++++++
 rust/kernel/serial/console.rs                      | 107 +++++
 rust/kernel/serial/termios.rs                      | 104 +++++
 23 files changed, 1322 insertions(+)
---
base-commit: b7ac81a9d691d0af65a5e1d3e16ef03d5dc8f2b4
change-id: 20261025-rust-bl808-console-1fbe1af3434d

Best regards,
-- 
Kwanghoon Son <asdfkwang@gmail.com>

