Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50F426EAD
	for <linux-serial@vger.kernel.org>; Tue, 20 Jan 2026 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913559; cv=none; b=rpqt4P2I3kUGWKV8S2VCogvnIDxgQtwsGVk14m7knqZ+XytbFCqVRiGsmVKWn/Zg4D9/KxT8JBgBkTsjtAzJQaCgkk8P6OThBt+OvqBXlv3yO5PQuifI5XOctwCwKZjCTjKoxpfX/pWra1rJOFJCxNvHNxodM9jUWOc0Hfp4Z5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913559; c=relaxed/simple;
	bh=dLT4BztcJUHlJv2mbKW05XmD97+BUruAVhf1PrnKC0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5zDwx0ZJNlUa2PGP6Ol2x/KWBK9MPZuZsLg/XzDewLjZWFNRapB7uSUQ7gB09PBZec5rFMTQa42WY9Z77L/LcXK0T6GHQwkB50+TuSGqKv4mcQoF2DzGRbUAKclQgn21BqYxHbwO5tIZ7qnwbj+6y2r5jyOfk6nzxbuZ0v84NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3jWciWk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3jWciWk"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b87dba51442so325006366b.1
        for <linux-serial@vger.kernel.org>; Tue, 20 Jan 2026 04:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913556; x=1769518356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ttQo/ynjtoD9vPtncN+5aFty4ApifbhAAoI8HwtRUw=;
        b=c3jWciWkuZUsvfBQhPCwCkmAwn4UcWt4E0D9OSmWVlN6M/tyYN3Jw8yoe/CZQJc4W6
         4CnmXCrhl2RhzXfsK8mQ1zI4eV1j0KnJh9ZxLYstNe2cHIKDVBQb+sCOQB7aKuxQZl+s
         /kaD36AxieB5fVBP6RlAzaB4rx7oGu8YOUFM9j5WuUb37jSqYxFq+qSFfQY5oSuQvMPO
         oCTDGsA3zeciiKOT9IXpFACDJLWgLwiTXt7fZsuMlqg+uxU25VFztDPGaxrcpEoXOz2p
         8jwomSStQerQ1CSLunDVgX4hwT7IQ7imHz72vjlxF84U2jDKC7YYZOBJC9hFzEwDfsar
         +fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913556; x=1769518356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ttQo/ynjtoD9vPtncN+5aFty4ApifbhAAoI8HwtRUw=;
        b=D6xe5fIztyehHsVnp4wt30z5JhkI0nnufz9uRhsrlkYRsIlvyuwEijE5YQsre73oPh
         mwDwF4dbOU/e9W7mRjTSmMsD5IX9cQmvyEZB+H7Xwo0VYGeiwDT3xPOcUHIov2LOGWyA
         IpNHX5C+c2W5jRopsGzmyx7dI4+8VFZX1f/MnKmGwF7uWhI+evszB3nLo0Wkh5WPFTTA
         MvLWmqZDJ+a3a3LPFxjjgbIQgkGJwPIBUVEYrfUcOsLxotH8F/xF5b8Dz7yrHfJkW2pk
         eyFFS+jxkVFxSOHhO3phCUZ70fNXTEV+gJrWonj7JPCcwXazju+zht3RPa36MoqbsGiL
         eFbA==
X-Forwarded-Encrypted: i=1; AJvYcCWPxWHPz1KfSQGPppKMi3RuAJijb+uAoGcxXD8xNkI/ORWrLP0Pi+UUQ7/ojf+wP50lqgCshQmz7iW6M6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFnMIDQjqXwX+9xuHfaub60ElvDrO92YgF0qLLWie6zRPZhXRH
	aXP09Cv2vqVhI/oN/uwgLLQEI1crEybxCejGCJJMC5bVveBq2Fr9oEDA
X-Gm-Gg: AY/fxX4/E1J8Y49ATuApMBbX2mLhm5dKTRZx9DiHBRKiz2KO0pLXCcGlaz95drGnsFJ
	e4nqYJF6QVxSeXFsSIKyfMHsrAxN5f1AZcC6D6X9cnbfxGY4+mZ9sdGUMML3NSCWh4aLSu2vlf+
	u12RxBiS6C4LcQyD68t87++JTFlIo9jtJIPE8/FXE06qbX0Oei9UYSvzc6iEADm48eUTTqdI02E
	+x89d0LDYXfh4Pjj/OLRkG89bI5ENPB/h9OBHnlMxyGr8HldVXEfVY/TlLMN/dF2W+d8RLAarSm
	SGjWhU6yYmBqcXYVe1jK4OEVHgekfNGW3e/MYKrGuCUKh41IA4Pj2qMLiXojTr345FDEy75sb+H
	GsMUIRSHRA2uTuFmazH8jCB71zId21zWplNvX9EzbQZmJhLQoAtSt4w684yT5Eg3PS4YNTpMHnU
	EbyWF3yoELYyJBePK37ImZLHCeetIGeLd2vKXz1gSIDPqSUQ==
X-Received: by 2002:a17:906:209c:b0:b87:d255:39ff with SMTP id a640c23a62f3a-b87d2553c76mr452807266b.32.1768913555294;
        Tue, 20 Jan 2026 04:52:35 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:c8c7:2ef6:8ac5:5556])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959ca32esm1420626066b.41.2026.01.20.04.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:52:35 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
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
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 00/12] Add support for Renesas RZ/G3L SoC and SMARC-EVK platform
Date: Tue, 20 Jan 2026 12:52:11 +0000
Message-ID: <20260120125232.349708-1-biju.das.jz@bp.renesas.com>
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

This series also adds SCIF support for the RZ/G3L SMARC EVK board (r9a08g046l68-smarc.dts).
 
Test logs:
/ #uname -r
6.19.0-rc6-next-20260119-g31b78275d04b
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
 11:        262        109        324         98    GICv3  27 Level     arch_timer
 14:          0          0          0          0    GICv3 185 Edge      error
 15:          0          0          0          0    GICv3 186 Edge      11820000.dma-controller:0
 16:          0          0          0          0    GICv3 187 Edge      11820000.dma-controller:1
 17:          0          0          0          0    GICv3 188 Edge      11820000.dma-controller:2
 18:          0          0          0          0    GICv3 189 Edge      11820000.dma-controller:3
 19:          0          0          0          0    GICv3 190 Edge      11820000.dma-controller:4
 20:          0          0          0          0    GICv3 191 Edge      11820000.dma-controller:5
 21:          0          0          0          0    GICv3 192 Edge      11820000.dma-controller:6
 22:          0          0          0          0    GICv3 193 Edge      11820000.dma-controller:7
 23:          0          0          0          0    GICv3 194 Edge      11820000.dma-controller:8
 24:          0          0          0          0    GICv3 195 Edge      11820000.dma-controller:9
 25:          0          0          0          0    GICv3 196 Edge      11820000.dma-controller:10
 26:          0          0          0          0    GICv3 197 Edge      11820000.dma-controller:11
 27:          0          0          0          0    GICv3 198 Edge      11820000.dma-controller:12
 28:          0          0          0          0    GICv3 199 Edge      11820000.dma-controller:13
 29:          0          0          0          0    GICv3 200 Edge      11820000.dma-controller:14
 30:          0          0          0          0    GICv3 201 Edge      11820000.dma-controller:15
 31:          0          0          0          0    GICv3 418 Level     100ac000.serial:rx err
 32:          4          0          0          0    GICv3 420 Level     100ac000.serial:rx full
 33:        206          0          0          0    GICv3 421 Level     100ac000.serial:tx empty
 34:          0          0          0          0    GICv3 419 Level     100ac000.serial:break
 35:         13          0          0          0    GICv3 422 Level     100ac000.serial:rx ready
IPI0:        23         26         19         22       Rescheduling interrupts
IPI1:       237        385        152         90       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop NMIs
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU backtrace interrupts
IPI7:         0          0          0          0       KGDB roundup interrupts
/ # cat /proc/meminfo
MemTotal:        1887948 kB
MemFree:         1849056 kB
MemAvailable:    1816424 kB

/ # cat /sys/devices/soc0/family
RZ/G3L
/ # cat /sys/devices/soc0/machine
Renesas SMARC EVK version 2 based on r9a08g046l48
/ # cat /sys/devices/soc0/soc_id
r9a08g046
/ # cat /sys/devices/soc0/revision
0


Biju Das (12):
  dt-bindings: serial: renesas,scif: Document RZ/G3L SoC
  dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
  dt-bindings: soc: renesas: Document Renesas RZ/G3L SoC variants
  dt-bindings: soc: renesas: Document RZ/G3L SMARC SoM and Carrier-II
    EVK
  dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3L SoC
  soc: renesas: rz-sysc: Add SoC identification for RZ/G3L SoC
  dt-bindings: clock: Document RZ/G3L SoC
  clk: renesas: Add support for RZ/G3L SoC
  arm64: dts: renesas: Add initial DTSI for RZ/G3L SoC
  arm64: dts: renesas: Add initial support for RZ/G3L SMARC SoM
  arm64: dts: renesas: renesas-smarc2: Move usb3 nodes to board DTS
  arm64: dts: renesas: Add initial device tree for RZ/G3L SMARC EVK
    board

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |   1 +
 .../bindings/dma/renesas,rz-dmac.yaml         |   1 +
 .../bindings/serial/renesas,scif.yaml         |   1 +
 .../soc/renesas/renesas,rzg2l-sysc.yaml       |   1 +
 .../bindings/soc/renesas/renesas.yaml         |  13 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 219 +++++++++++
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   |  41 +++
 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi |  13 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   6 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   8 -
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  22 ++
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a08g046-cpg.c           | 137 +++++++
 drivers/clk/renesas/rzg2l-cpg.c               |   6 +
 drivers/clk/renesas/rzg2l-cpg.h               |   1 +
 drivers/soc/renesas/Kconfig                   |  12 +
 drivers/soc/renesas/Makefile                  |   1 +
 drivers/soc/renesas/r9a08g046-sysc.c          |  91 +++++
 drivers/soc/renesas/rz-sysc.c                 |   3 +
 drivers/soc/renesas/rz-sysc.h                 |   1 +
 include/dt-bindings/clock/r9a08g046-cpg.h     | 339 ++++++++++++++++++
 23 files changed, 918 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g046-cpg.c
 create mode 100644 drivers/soc/renesas/r9a08g046-sysc.c
 create mode 100644 include/dt-bindings/clock/r9a08g046-cpg.h

-- 
2.43.0

