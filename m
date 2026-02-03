Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3C26A1A7
	for <linux-serial@vger.kernel.org>; Tue,  3 Feb 2026 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114637; cv=none; b=p2Ncvkfrn+WQCUQbKGpIQeOv+AFIETSBMapgF1XjA04ObVPlG5ns1DvHRah/xiX8VMZ4KlZz6OZXAxFcWWR1S/emO6fEz1bjMZt2L8UKxTzOvGNpID7I95Ba8jqkFyn+K2wCX7R0pv1+6Qgz4ZOds92Gn9Q9m3nulkPz+Be5zVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114637; c=relaxed/simple;
	bh=PCnvYowvS57a0Nh4ri2yr2Df4UtEVSPTo7WzEhNb9NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqTdLkYkHTO/KV8fZ41KQmDu+lcHSutszv6R0juP81Ci6+SMNpJ8AZZDCaewkWdU17HHZ19+/NjhGsQMmOM9H7EfU8EmXHHyQzupjHYdPCP20yj8Fpi6z73baO8MYV74HSQ3HkXb/jjBiZqIVMndXKpRWyFkeh7IWDm0aMWTpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llaDFgcu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llaDFgcu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so4445315f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Feb 2026 02:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770114634; x=1770719434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUB7aym/7mJiHZlEcvDbwQm5CUiw6OddIgLw67f2MAM=;
        b=llaDFgcuZ/l89KujlTjUDcTpjzDr91EuFY0hhHDxCJVNz9TW07/4IfEglXbrN/xOij
         PAOxlaxMge70BxacHxEb2jXCHycBSZE3LILLN3capxQHahOU+kYdZWrEeE5RFaCRovlz
         D4TP9RIV3uVc4dQ23nHKYSQsbkwBAEew1zGg6xKGxtbFXmt9LS6eyMcEQFwGWjAA5ii7
         ZtZhEJqwgfaLOR7LkpZLp8CiryFfcp/63rw0yjjFcR9pupqnUYxmJjyH3WfHrvj/Oe/a
         8jb4liI2k7XEDT62SAoEjpHFLU/GsnOcd9tKAjtisPn9gccbCyJA+AdZpjU6pskBIjRE
         ToaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114634; x=1770719434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUB7aym/7mJiHZlEcvDbwQm5CUiw6OddIgLw67f2MAM=;
        b=sl4hTeIAabgfToCWAH7i6nYQmTKydMyysHK1fDhaMyIXamwusmca0poZ1xyj/cXLua
         6qdjLbxIZRakaoyMFq6ULbJT0sGzEMNDHXAwpcy8cge61QPVRNJTPkNrZKx/Vh75iy+N
         4r5POeQfmOulhWfVwxf4IOarpiqOona2NWmVP8HQWxUbS7qL6ZWHN3xJcGHWB4ogsI+s
         0oXF+piiY5+yNyydm/U/2Q7972Z+e15L1Nd9ieF90zh8iCBq8Dc/aUCnsYECofMWsTHp
         nilDafvHzWSVFR+GWcp7q7ttUXTyt1XXVaVcF7rWvDqOpWsEfLnoFHA9U/nHiaCRZuie
         ldbg==
X-Forwarded-Encrypted: i=1; AJvYcCWE2DqnB+31cWEpeq72gWgWReDoqIgfX9iaBtjxRWDMm5GGZUALIgznMn5KyJa3QvN2/uqcmzlz1vrrLY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJz5D08WaiMepsOyN3EWWxR+Zzai3/lQPmN9DT3ZmKpQpwGJXY
	rcOGt8t3eViLTQgyRhuseZxPjvrj6+xoxC9xBRayJogV+oEC+fuofSRq
X-Gm-Gg: AZuq6aKYtv0VPvOyEZHmOq5xbOJfGBOwuzNFi6H3MDpZ8jZ334y+UFux2mEwRCTGIGW
	4ZeT5tIGqhK2vBIGs1hRs6aQ1TNlCsE2ooClNVl/2sECYNpXrD2YTyWgFlc3p91fKjRoxzhalFB
	T6WZ6wDEVmV3yirpdV36CPuNS1WIV4Va/0P8ERhSPCILzbOtm61hpBswl9ghlGE9cN7/oEJz1lS
	p0tAgZEh7byNds0/I0+Ip6ZU+OrGDbsQW5mfq/OuPBD7A0dVuR9HifxHtCRmFahY17CKZY5spo2
	3Nw+NoTp4pCQ9BJuCCOuBCbmvwEMB8KUgn2G12Qg8z4JvDp9AsQ1c+7Gfs1y0n7aOhDH1aoliWx
	8oIBbgumfPuQ8A4C4sUXsRTCPGTemVaJKL0LMSuW0IMPTGvcxhK42cOaFAf6XWHiY5nR+E43HSr
	8L+tlzok0fVK6POq+iCw==
X-Received: by 2002:a05:6000:26c6:b0:430:fcda:452d with SMTP id ffacd0b85a97d-435f3a72b46mr20486720f8f.22.1770114633786;
        Tue, 03 Feb 2026 02:30:33 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:9cd9:f748:166d:55fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1323034sm53160961f8f.35.2026.02.03.02.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:30:33 -0800 (PST)
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
Subject: [PATCH v3 00/10] Add support for Renesas RZ/G3L SoC and SMARC-EVK platform
Date: Tue,  3 Feb 2026 10:30:08 +0000
Message-ID: <20260203103031.247435-1-biju.das.jz@bp.renesas.com>
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
/ # uname -r
6.19.0-rc8-next-20260202-g61054f67d824
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
 11:        271        105        273         62    GICv3  27 Level     arch_timer
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
 33:        222          0          0          0    GICv3 421 Level     100ac000.serial:tx empty
 34:          0          0          0          0    GICv3 419 Level     100ac000.serial:break
 35:         13          0          0          0    GICv3 422 Level     100ac000.serial:rx ready
IPI0:        20          9         37         20       Rescheduling interrupts
IPI1:       238        226        223        248       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop NMIs
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU backtrace interrupts
IPI7:         0          0          0          0       KGDB roundup interrupts
Err:          0
/ # cat /proc/meminfo
MemTotal:        1887812 kB
MemFree:         1848236 kB
MemAvailable:    1815628 kB
/ # cat /sys/devices/soc0/family
RZ/G3L
/ # cat /sys/devices/soc0/machine
Renesas SMARC EVK version 2 based on r9a08g046l48
/ # cat /sys/devices/soc0/soc_id
r9a08g046
/ # cat /sys/devices/soc0/revision
0
/ # dmesg | grep r9a
[    0.000000] Machine model: Renesas SMARC EVK version 2 based on r9a08g046l48
[    0.039307] renesas-rz-sysc 11020000.system-controller: Detected Renesas RZ/G3L r9a08g046 Rev 0

Biju Das (10):
  dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
  dt-bindings: soc: renesas: Document RZ/G3L SoC variants, SMARC SoM and
    Carrier-II EVK
  dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3L SoC
  soc: renesas: rz-sysc: Add SoC identification for RZ/G3L SoC
  dt-bindings: clock: Document RZ/G3L SoC
  clk: renesas: Add support for RZ/G3L SoC
  arm64: dts: renesas: Add initial DTSI for RZ/G3L SoC
  arm64: dts: renesas: Add initial support for RZ/G3L SMARC SoM
  arm64: dts: renesas: renesas-smarc2: Move usb3 nodes to board DTS
  arm64: dts: renesas: Add initial device tree for RZ/G3L SMARC EVK
    board

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |  40 +-
 .../bindings/dma/renesas,rz-dmac.yaml         |   1 +
 .../soc/renesas/renesas,rzg2l-sysc.yaml       |   1 +
 .../bindings/soc/renesas/renesas.yaml         |  13 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 251 +++++++++++++
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   |  37 ++
 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi |  13 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   6 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   8 -
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  20 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a08g046-cpg.c           | 144 ++++++++
 drivers/clk/renesas/rzg2l-cpg.c               |   6 +
 drivers/clk/renesas/rzg2l-cpg.h               |   1 +
 drivers/soc/renesas/Kconfig                   |  12 +
 drivers/soc/renesas/Makefile                  |   1 +
 drivers/soc/renesas/r9a08g046-sysc.c          |  91 +++++
 drivers/soc/renesas/rz-sysc.c                 |   3 +
 drivers/soc/renesas/rz-sysc.h                 |   1 +
 include/dt-bindings/clock/r9a08g046-cpg.h     | 343 ++++++++++++++++++
 22 files changed, 988 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g046-cpg.c
 create mode 100644 drivers/soc/renesas/r9a08g046-sysc.c
 create mode 100644 include/dt-bindings/clock/r9a08g046-cpg.h

-- 
2.43.0

