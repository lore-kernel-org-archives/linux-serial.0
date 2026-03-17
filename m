Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D3346771
	for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777417; cv=none; b=RPueqMfrjoYm/G+r9RdCxGkQDGogzKIUbWNPSsM+0qekfee2A+xPZysvA9udavsIQ0FIAfmGqXbB7X7wXsLUSP0Hcw01Xmkoya/BnR14HI+0vnbgsKSMZvOaAFAupNTc62B0tF1UCEiV1LwJHNlgeDePzftfs4acXpLX1BAz2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777417; c=relaxed/simple;
	bh=rD6k5g0x5o7wNECzX7SXx9gUH4XhSPou5kQZofQmVG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcOWHDwycdSQhzI1wcvCAuImscmysSmLBmyI569mSlzkbcGAsYG+UbW5bTwa7ob0jRz8Jg+JxlySO67s/ginPsC4PRJ8ca4hdRSt3azchFlKYEi+AF1RGT2fgdT2Tj7yrCSmyrNfoYZUwUTU7R/gVvOPr4qt5ASV7zzeQCvE44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE+mM0Qi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE+mM0Qi"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso2359221f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773777414; x=1774382214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y0xsdwwhqtc3tEm3F1+SO5Z37i9orpFohwEEPl5Uus=;
        b=nE+mM0QiZNCf/ii+Tn+Xrzhit6Z4/YyBaFbI20nr13XbnG90YbzIPFdmRE5/Gzs7AY
         7lfzFGqrpZz7ihpv+DLOnuwialuZc/82kUgVFqbBsde91xIsnL8vW31yjXcdZD81+N8w
         tCcENoUwiELGkXm2k35A7JQABIIjLxpIlF1SIU5iQr+JFxnpC+JJAz5ijPMr9DJVjU9c
         hLlshWi4BcnWec39gTcXJR68UI4ByzA+iFCvWiWxlAD7RaJbuzZUk3piMASt08GpD4OM
         B4q24qLbeF+AsrCi8rMR/26RGIs06CBiHPtw8w4zgs8tTw5ffRyk6Ji5964eVLbGCaEK
         XlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773777414; x=1774382214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y0xsdwwhqtc3tEm3F1+SO5Z37i9orpFohwEEPl5Uus=;
        b=PNfUqdJBX5KSoR4YUcFV+4c6uL9wb7eWMgOPUXFZgOoD+584vlguMsphdpkLtX0I1s
         ZrL1O+grf7YmM51krdXy0ty5mYZDa/On1Dk26oD+NElyB6IPkn0jLaKqgf6yXfzKuuVK
         yOitZ9vhoVSigPM1hLj5sOhdrvDMiFdZ9JzNjkxs9/+shWO2yLDI32DkRKw3coBddIWD
         kzQn+YnNm7pp+XhpLLtVsv++WUuRiHt2BHUj/CptiPsZYqbfiPgQZFp8oxS49yfCPuud
         yeKEKWogrJB3eEvaAthH/3YSEZVXGCv+suFjFiLrLMDFjQiVmJiT7ax22sk5gPMNZNcP
         3Ryg==
X-Forwarded-Encrypted: i=1; AJvYcCXr5a3Akin4jWoCdGndkqJr4KV1KITELgJfiNPSlHgEMDuBMFeG0mEWnBjmXKOXJu4IUZbMlxs3VRvSyTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKG/pxlXS42AqX2P5Hpt1ySdC/Se4sRrpQ9q1IV7jH7kr6juF
	CqGSrnRnO5epjTTP2nZSUqWdV5efCNGy9PJ47vUjXQ66vIVgaQUoaPYs
X-Gm-Gg: ATEYQzwz17l/ySmOXdx+QVd8DTYPVO210OhKbbA7zVSd/+qW4aFDbiyQOBYnOFyvXzn
	O7reHNV+yY/8JEwcN/U6veFckK86rJbsPRPQvu4jQ1dyUrvMYZCtEISa0dGB35mkwbD3oFEwIq3
	mMJ+gBhqhiBiIFBmruv2v7dzEdt+FYrgqLRjcS3IGLMQZYMqgpbqoFnmQ7iSGGqNRvXEd/3ZmXO
	/gYrXWJsS0g+9Wb1nMFBG2XYz26QwaUXwvEK/vIGKzo6iB0j9N+SGJ2GP7xA5+mGjKwZ2HeUq05
	OU+ht780S42lZlX54rgbpC0ROg5X77g+jDcGZLs+94fVolmCQleOr2nwXve0zYoLYJjPb+UYBx5
	w6U1534kc/hbWIWqMZoQdMIowWGZ3j9uUOOB5x6G3CvDIrHweikAF7HnZqK71C+Dz6T6hleotvF
	2CzZ6apIzuBK0G0A62z9OvvRjlD15HwgunxM80XXRdQEDWTekz
X-Received: by 2002:a05:6000:24c4:b0:43b:3d44:6624 with SMTP id ffacd0b85a97d-43b527a07fbmr1060580f8f.2.1773777413952;
        Tue, 17 Mar 2026 12:56:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5189221dsm1339217f8f.23.2026.03.17.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:56:53 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 0/9] Add support for Renesas RZ/G3L SoC and SMARC-EVK platform
Date: Tue, 17 Mar 2026 19:56:29 +0000
Message-ID: <20260317195650.468330-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi all,

This patch series adds initial support for the Renesas RZ/G3L SoC and
RZ/G3L SMARC EVK platform. The RZ/G3L device is a general-purpose
microprocessor with a quad-core CA-55, single core CM-33, Mali-G31
3-D Graphics and other peripherals.

Support for the below list of blocks is added in the SoC DTSI (r9a08g046.dtsi):

 - EXT CLK
 - 4X CA55
 - SCIF
 - CPG
 - GIC
 - ARMv8 Timer

This series also adds SCIF support for the RZ/G3L SMARC EVK board (r9a08g046l48-smarc.dts).

v3->v4:
 * Dropped SoC identification patches as it is accepted for renesas-devel.
 * Updated commit description related to core clocks section in the
    hardware manual
 * Dropped CLK_P4_DIV2 from core clocks
 * Added MIPI_DSI_PLLCLK and USB_SCLK to core clocks
 * Dropped LVDS_PCLK  module clock
 * Added BSC_X_PRESET_BSC reset
 * Moved the patch series from [1] to here as it is boot-dependent.
 * Updated commit description
 * Updated LAST_DT_CORE_CLK with R9A08G046_USB_SCLK
 * Fixed typo 2->8 in dtable_4_128[].
 * Added critical reset table r9a08g046_critical_resets[]
 * Updated num_resets
 * Added crit_resets and num_crit_resets to r9a08g046_cpg_info.
 * Fixed typo R0A08G046L->R9A08G046L in commit description
 * Dropped R9A08G046L46 from commit description
 * Dropped unused audio_clk{1,2} andcan_clk device nodes
 * Reordered i2c device node and updated reg entries by using lower-case
   hexadecimal number
 * Added placeholder in pinctrl node
 * Dropped unused DMAC device node
 * Added pcie node with placeholder
 * Collected the tags.
 * Updated commit description for patch#8

[1] https://lore.kernel.org/all/20260306134228.871815-1-biju.das.jz@bp.renesas.com/
v2->v3:
 * Added macros R9A08G046_ETH{0,1}_CLK_{TX,RX}_I_RMII in r9a08g046-cpg.h.
 * Keep the tag from Conor as it is trivial change for just adding macros.
v1->v2:
 * Dropped scif bindings patch as it is accepted.
 * Collected tags.
 * Squashed the patch#3 and #4
 * Documented GE3D/VCP for all SoC variants
 * Documented external ethernet clocks as it is a clock source for MUX
   inside CPG
 * Updated commit description for bindings.
 * Keep the tag from Conor as it is trivial change for adding more
   clks.
 * Added CLK_ETH{0,1}_TXC_TX_CLK_IN and CLK_ETH{0,1}_RXC_RX_CLK_IN clocks
   in clk table.
 * Dropped R9A08G046_IA55_PCLK from critical clock list.
 * Added external clocks eth{0,1}_txc_tx_clk and eth{0,1}_rxc_rx_clk
   in soc dtsi as it needed for cpg as it is a clock source for mux.
 * Updated cpg node.
 * Dropped gpio.h header from SoM dtsi.
 * Dropped scif node as it is already included in common platform
   file.

Test logs:
/ #  uname -r
7.0.0-rc4-next-20260316-g7f7df5dd3d2a
/ # cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 1
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 2
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 3
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:        104        191        429         62    GICv3  27 Level     arch_timer
 14:          0          0          0          0    GICv3 418 Level     100ac000.serial:rx err
 15:          4          0          0          0    GICv3 420 Level     100ac000.serial:rx full
 16:        229          0          0          0    GICv3 421 Level     100ac000.serial:tx empty
 17:          0          0          0          0    GICv3 419 Level     100ac000.serial:break
 18:         17          0          0          0    GICv3 422 Level     100ac000.serial:rx ready
IPI0:         3         16         13         21       Rescheduling interrupts
IPI1:       315        240        180        217       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop NMIs
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU backtrace interrupts
IPI7:         0          0          0          0       KGDB roundup interrupts
Err:          0
/ # cat /proc/meminfo
MemTotal:        1887304 kB
MemFree:         1852164 kB
MemAvailable:    1819524 kB
/ # cat /sys/devices/soc0/family
RZ/G3L
/ # cat /sys/devices/soc0/machine
Renesas SMARC EVK version 2 based on r9a08g046l48
/ # cat /sys/devices/soc0/soc_id
r9a08g046
/ # cat /sys/devices/soc0/revision
0
dmesg | grep r9a
[    0.000000] Machine model: Renesas SMARC EVK version 2 based on r9a08g046l48
[    0.066480] renesas-rz-sysc 11020000.system-controller: Detected Renesas RZ/G3L r9a08g046 Rev 0

Biju Das (9):
  dt-bindings: clock: Document RZ/G3L SoC
  clk: renesas: rzg2l-cpg: Add support for critical resets
  clk: renesas: r9a07g04{3,4}/r9a08g045-cpg: Add critical reset entries
  clk: renesas: rzg2l-cpg: Re-enable critical module clocks during
    resume
  clk: renesas: Add support for RZ/G3L SoC
  arm64: dts: renesas: Add initial DTSI for RZ/G3L SoC
  arm64: dts: renesas: Add initial support for RZ/G3L SMARC SoM
  arm64: dts: renesas: renesas-smarc2: Move usb3 nodes to board DTS
  arm64: dts: renesas: Add initial device tree for RZ/G3L SMARC EVK
    board

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |  40 +-
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 215 +++++++++++
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   |  37 ++
 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi |  13 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   6 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   8 -
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  20 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a07g043-cpg.c           |   8 +
 drivers/clk/renesas/r9a07g044-cpg.c           |  13 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   9 +
 drivers/clk/renesas/r9a08g046-cpg.c           | 153 ++++++++
 drivers/clk/renesas/rzg2l-cpg.c               |  80 ++++
 drivers/clk/renesas/rzg2l-cpg.h               |   8 +
 include/dt-bindings/clock/r9a08g046-cpg.h     | 342 ++++++++++++++++++
 17 files changed, 948 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g046-cpg.c
 create mode 100644 include/dt-bindings/clock/r9a08g046-cpg.h

-- 
2.43.0

