Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140D3EB7E1
	for <linux-serial@vger.kernel.org>; Tue, 24 Mar 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352618; cv=none; b=TktS/XRbq3Fl5cObB+OexNGaqYDS0uGWGG1CGOp/6rnTi2rK7vsMuLlHGe6y2A+7CgDEpHBWciDeve1fOQ350DIcxW8akOfGUvdbZuBL1+iqarfep5AHLN1xhhi3jSh2X11n2iSUgN9+2QxBwmKlhoAHWXtoz49D6yyX7+JyhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352618; c=relaxed/simple;
	bh=TwlhH48H41f6nkLwYVdb7F65uIhaLQQ0ylzP7pSxsqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcUCIojcKeUSo3W64XkpSQoAz9s7JiqAk/HiV1TOv6s5UMdVYkFniVsdF4R920M0i9VbVWNgUDag2b0PJ9XvWmCJ8MZG/xc7mfnztAAWkJsAcviv7NS3O/PrwX2A4a98IeVt/htlBzPsESknLBuGbD3ZTukjHv16EeiBUetFicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6hCPe+g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6hCPe+g"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso10062835e9.1
        for <linux-serial@vger.kernel.org>; Tue, 24 Mar 2026 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774352613; x=1774957413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBXjCkVQF23TpxKQAgzN2hDo50cJIARW68eQv7UBDm8=;
        b=E6hCPe+gbwOpu5gTsV4mwVR4LSVJ4deumLmm3wjB/Kay+zgp0nCXaltHqFycA6Z/1c
         OPU6npuMsrIEiYAMBT/8PFVEr64jOwGM+xveZ/brzXQhVsNMbDuwIN8iRiXFQkbIa00l
         fzXLj/ROzzuZfVkj8Z7k0X8dKXvfG/u1OHyD4X/5RGNiCtZrdLWWBPFFpRY7C3wp95Ym
         6UHXKWw6r+MmXrd6mTmFytB1B1ml7oDmg+HKpaxP88tmvT4emqBIfCkEb3AfQFAmR+31
         8GeQv90d9VpmJdZUHbA5auvyox3ncBXbiCjNUEafpfBmR0vjObLF1jfRCupV4t+c7cOL
         JKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352613; x=1774957413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBXjCkVQF23TpxKQAgzN2hDo50cJIARW68eQv7UBDm8=;
        b=c9bsnRKfGjfqntjrkVEqJmQ6CaaiU8fclZvgv2nQ77P+xRtwcAdoq4Q79/zX6QvDln
         YWMq4itgrcuxyELv7/Qzp7vpGacp5THo3iPXndqZdopahgDeZC+S1yAy2LBwo21GnKhY
         lntJnvy3TKQTLE12p7vu3/m5TtZ4+RNydluuXjTvCAuJKRifccsM1IIBX9JXYQ2kXeGP
         fhRdINUU3JxKI71jc3kxsBIA4ZQI0p/Zpt4CFanmgYcKg7EcYfw7uVSijlSgm7+VpRJf
         6qLqdrISmVXRS6KW6rZ+e4u9Mf41bvliwXOWFTI8NL8jECvQG8QW7VJhhQNU5zP7ddDt
         NZog==
X-Forwarded-Encrypted: i=1; AJvYcCVKaAdxg65gL8XDSlFHvgSf1Fu7PrmDXvTf7cJK+shWTb+f900dVj5wY/Y/PQZTQiGSssDWXwy5I8obk6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxukRLef4zaL90lkHZDLgKHvL6AT6xEe8RjU3Ir/XfxMUtf3KLp
	l3KfrcwXIFkiv2yN5zjxkPBT3jWNAuR06vxYbGgIEgEgRV0m2ADkYm6uPbPngg==
X-Gm-Gg: ATEYQzy4E7IIYpG3uF5IopRRcv3IbzX5nIpFV6l4mFAhvrLpmFvaW0azmm7xjaOybj2
	oisbkmqO8zvZrU4cZCSyn0ViUeW21B25sZsxT/mfiZDXD0sU2MhS+CxPRx1fnDgLBbMsmur3Bxx
	gYlCt4HsWwOpo56k1a7zFUXl0K8DKQnZZ2oAMKpMGFVwS6H6+nI+xJX3IWtc26Qpc8kskAAth/n
	pWcp+KQsUMvP4rQpzwngeeTuuvqHU9PmNdEe4CiNSQHoqHuZwT9FK7y9+RJ8OtXonYBFvnSonif
	xlptcokMixuEssLRGhS/Nn8pSNKiJV528/6QBil0qVIKCBBCVXk/c7lI2iSvckxclMnMDEzfEao
	sIkuZdpd8D/zgHDnKMKpEdJ74/RtQ3yB7TDmdjHEMNmA3QBG9begug1UawMWdDGvXdcm7cif8bH
	NqvPr2AoKY11QP2enrFi4oVH4B+XFhMEvR9x8ytp/vP8q6xN7J
X-Received: by 2002:a05:600c:4e02:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-486ff0271a7mr210878545e9.19.1774352612304;
        Tue, 24 Mar 2026 04:43:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:a4a6:e61e:cd81:c756])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f7f5682sm25416465e9.3.2026.03.24.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:43:31 -0700 (PDT)
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
Subject: [PATCH v8 00/11] Add support for Renesas RZ/G3L SoC and SMARC-EVK platform
Date: Tue, 24 Mar 2026 11:43:05 +0000
Message-ID: <20260324114329.268249-1-biju.das.jz@bp.renesas.com>
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

v7->v8:
 * Added logs for MSTOP state during suspend/resume cycle of s2idle.
 * Fixed the R9A08G046_ADC1_ADCLK macro value 138->139.
 * Added helper for mod clock enable/disable to allow callers to control
   whether the module stop state is updated alongside the clock
   enable/disable operation.
 * Fit the comments in rzg2l_mod_clock_init_mstop_helper() to 80 character
   space.
 * Updated comment in rzg2l_mod_clock_init_mstop_helper() as resume()
   calls this function.
 * To avoid setting module state twice and also not to update the initial
   mstop state for the critical clocks state during probe, replaced
   rzg2l_mod_clock_endisable()->rzg2l_mod_clock_endisable_helper().
 * Fixed the typo RZ/G3E->RZ/G3L in r9a08g046l48.dtsi
v6->v7:
 * Collected tag
 * Updated r9a07g043_cpg_info by inserting a blank line before
  .has_clk_mon_regs
 * Replaced r9a07g044_critical_resets->r9a07g044_crit_resets,
   r9a08g045_critical_resets->r9a08g045_crit_resets and
   r9a08g046_critical_resets->r9a08g046_crit_resets for consistency
 * RZ/V2M has critical clocks but no mstop, so move the mstop check after
   enabling critical clocks. After this, we need to restore only mstop for
   module clocks, so remove the inverted logic and continue statement and
   directly call rzg2l_mod_clock_init_mstop_helper() if the clock has
   mstop.
v5->v6:
 * Collected tags
 * Moved loop variable declaration inside for loops in
   __rzg2l_cpg_assert() and rzg2l_cpg_deassert_crit_resets()
 * Replaced r9a07g043_critical_resets[] -> r9a07g043_crit_resets[] for
   consistency
 * Introduced rzg2l_mod_clock_init_mstop_helper() for code reuse
   in probe() and resume().
 * Dropped the list implementation.
 * Replaced  rzg2l_mod_clock_init_mstop->rzg2l_mod_enable_crit_clock_init_mstop()
   for enabling critical clks and restoring mstop state during resume.
 * Dropped dma-ranges, bus-range and comment from the pcie device node
v4->v5:
 * Rebased to next-20260317.
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
7.0.0-rc5-next-20260323-g862cf6e2b2bf
/ # cat /sys/kernel/debug/mstop
                           MSTOP
                     clk   -------------------------
clk_name             cnt   cnt   off   val    shared
--------             ----- ----- ----- ------ ------
gic_gicclk           1     1     0xb6c 0x0
ia55_clk             1     1     0xb70 0x0    ia55_pclk ia55_clk
ia55_pclk            0     1     0xb70 0x0    ia55_pclk ia55_clk
dmac_aclk            1     1     0xb80 0x0
dmac_pclk            0     0     0xb80 0x8
scif0_clk_pck        2     1     0xb68 0x0
/ # echo enabled > /sys/class/tty/ttySC3/power/wakeup
/ # echo N > /sys/module/printk/parameters/console_suspend
/ # echo 7 > /proc/sys/kernel/printk
/ # echo freeze > /sys/power/state
[   66.381552] PM: suspend entry (s2idle)
[   66.385460] Filesystems sync: 0.000 seconds
[   66.390461] Freezing user space processes
[   66.394563] Freezing user space processes completed (elapsed 0.000 seconds)
[   66.401515] OOM killer disabled.
[   66.404731] Freezing remaining freezable tasks
[   66.410340] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   72.270183] OOM killer enabled.
[   72.273365] Restarting tasks: Starting
[   72.277266] Restarting tasks: Done
[   72.280780] PM: suspend exit
 jfdngdf/ #
/ # cat /sys/kernel/debug/mstop
                           MSTOP
                     clk   -------------------------
clk_name             cnt   cnt   off   val    shared
--------             ----- ----- ----- ------ ------
gic_gicclk           1     1     0xb6c 0x0
ia55_clk             1     1     0xb70 0x0    ia55_pclk ia55_clk
ia55_pclk            0     1     0xb70 0x0    ia55_pclk ia55_clk
dmac_aclk            1     1     0xb80 0x0
dmac_pclk            0     0     0xb80 0x8
scif0_clk_pck        2     1     0xb68 0x0
/ #

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

Biju Das (11):
  dt-bindings: clock: Document RZ/G3L SoC
  clk: renesas: rzg2l-cpg: Add support for critical resets
  clk: renesas: r9a07g04{3,4}/r9a08g045-cpg: Add critical reset entries
  clk: renesas: rzg2l-cpg: Add helper for mod clock enable/disable
  clk: renesas: rzg2l-cpg: Add rzg2l_mod_clock_init_mstop_helper()
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
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 212 +++++++++++
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   |  37 ++
 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi |  13 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   6 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   8 -
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  20 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a07g043-cpg.c           |   9 +
 drivers/clk/renesas/r9a07g044-cpg.c           |  13 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   9 +
 drivers/clk/renesas/r9a08g046-cpg.c           | 153 ++++++++
 drivers/clk/renesas/rzg2l-cpg.c               |  91 ++++-
 drivers/clk/renesas/rzg2l-cpg.h               |   8 +
 include/dt-bindings/clock/r9a08g046-cpg.h     | 342 ++++++++++++++++++
 17 files changed, 944 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g046-cpg.c
 create mode 100644 include/dt-bindings/clock/r9a08g046-cpg.h

-- 
2.43.0

