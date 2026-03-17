Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC03446BC
	for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776690; cv=none; b=qzxM2BNYzYzValGParIq3VK5KflFJpNwnbuU8lowSAgxFxQ7SYAO8RttDaP4s3NFEkwZp6/iN8Mhw1M/aemt9tNTUAPuTYTSZgnr2zM7QDXf4qiWIA/rwLxXTYHsNUyBNjc/mdeC2lHnXY0Y9i3Anwf+hRkFbdZ7ooX0m+hq7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776690; c=relaxed/simple;
	bh=rD6k5g0x5o7wNECzX7SXx9gUH4XhSPou5kQZofQmVG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alSQtYbaMmVTpyO3rtL1gM7GqbzR8iRpKtONHlAH+T2r5E/kHt6PO8GkVB0vSWS8qS6e+xHJUbFC8z2sHPMcQx7jZk325o2QZ1U6e86Cb47QDdH7Zp9ZssRsvI2Q3VpjWocQQynsGef6PpJVVnVgP3XLaYI3Wl+H8XQfLtb7l9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny/8g0l3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny/8g0l3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48539d21b76so44914325e9.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773776686; x=1774381486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y0xsdwwhqtc3tEm3F1+SO5Z37i9orpFohwEEPl5Uus=;
        b=Ny/8g0l3chyvelhxH+n/HCihlAf2BAvI89eZVXi/0ouXmUvXuvFe+Gy/VfUSRghVBt
         S9dLAttoJ8+qWjaNx64kyE77/mDKesRhgIfvDm3euxRcqxE/6JbdncoO4KVTmFPJJS1M
         vY/na6Hbnp6GwBPhwXizwfUdqthzCzN9ucgH5uNMjH03YfT9JOt+u8dZsn1xhfheDvpE
         O4XBHnlXWbdEAj9Yh0KWh2924i2IhDMx/GIbHKnP+mbgmZT1APtuvldnRl913RaNwG6r
         Dzi5bdcn35k1G2x+J3h1N6MObJc2GuVZI23madXnrULRzb+CPTeUAvhmpwVH4Y47fDU2
         dbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773776686; x=1774381486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y0xsdwwhqtc3tEm3F1+SO5Z37i9orpFohwEEPl5Uus=;
        b=FB08ptp23H2djtbzdQwo5+8yUjW6ywqQ8th+hHrwjYW3A18QJelDC1KDYFWmXzya57
         fzy6tEv9k7QyQ/aiCExIznkHssTA6pZ9oYSDUQvosbOhHdz39aKoUc+xAk4StdpB1GkV
         WAnq7gLmhL5QwHJ78ZEXLOphgGW8Rm9MCU22geqHj0eV45/qlQGT/MLj2yTTM4BisJ1y
         Gyw64+/EP8NEOmGGZ7nU8WaLrr3JmqVEQFe1IG89LSXD8RfLGs9yKIDuUsvOcbp1ujFC
         kltZnQ5ybg3/aypQWhXbYoKzH9MaY9qms9jHkFeEZncGaID5lVwnlxQiQjLpbQ1PuBfd
         yKKg==
X-Forwarded-Encrypted: i=1; AJvYcCUUSGNmePP1qVpktzlK3rzX8hm2dAJV2xsQIfiwyAnJu7AJCfnRCowgtF+GNQ4pehojp98wMYSZ6eA3m3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EX0aPNsTvPLLkIe+X06nsTPahEbgn+rXN56RrUnYK6mPQIu7
	x0Ar8i0V1cerUslVBcpHNP75jiCAnRMExARq+s/LSdO09MU9CQCe2o8g
X-Gm-Gg: ATEYQzycuxc8aEvnESpGzZPxpcy+44Z49aaDbqLE3GYi+omRF5CWlVWh4j9zGlDfNnr
	zpwlTGxdpa3RbUFdjGBF8w7jUX8JmmA8HZDuI1hOXfvKYAQpB3U/UhlJhonbhoCAfMfYsZMpDR/
	XjXDAQIoxA+rfb+Iv554A9DNVdwyDwkAHiNEWEcKbJw3mwnA6WYS9ceeSeUaJP0H/B+h89geN6q
	3hTPuZE/96MVmtzAo+eD8MHwkhDw5BHOnHsOFR/68NbTas+CMcyV/wdS8TBWWDY8bYllOmnAB5p
	eOS72oECWx+XpwQKKdKkXXea7EsNbqdc6ahsNrmigRPyzxZOnIBsunTv6LHu3f4nciThfURNYZ+
	ON6w4Smx1Fyn2Rnc3sUe97sh02HGu8nN4GNxPjgMJzbuBl/Bxumpj4BW8VBDZCj8FjkNs6I1SUz
	Mr4s+PivuAdVQssqlMFXcGwJelkhBWGihQve2QQFa7GRyrHvsn
X-Received: by 2002:a05:600c:154e:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-486f4441232mr13771455e9.21.1773776686355;
        Tue, 17 Mar 2026 12:44:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892161sm1788235f8f.21.2026.03.17.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:44:46 -0700 (PDT)
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
Date: Tue, 17 Mar 2026 19:44:27 +0000
Message-ID: <20260317194442.468147-1-biju.das.jz@bp.renesas.com>
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

