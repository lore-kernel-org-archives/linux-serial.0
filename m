From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 00/16] serial: sh-sci: Clock Cleanups
Date: Thu, 19 Nov 2015 19:35:57 +0100
Message-ID: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi,

The SCI driver currently handles two clocks, an interface clock named
sci_ick and a functional clock named sci_fck. Studying the datasheets of
the SH and ARM SoCs that incorportate (H)SCI(F)([AB]) instances showed
(un)surprisingly that the hardware doesn't have a separate controllable
interface clock.

All the platforms that declare an interface clock for the SCI set it to
the clock used as the SCI functional clock. The two clocks can thus be
merged on the driver side, which is what this patch series does. The
resulting clock is called "fck", and all H8/300, SH and ARM users (both
DT and non-DT) are fixed to name their SCI clocks appropriately.

Support for the "sci_ick" name is kept in the sh-sci driver to ensure DT
backward compatibility, and support for the "peripheral_clk" clock to
not break SH platforms that don't declare device-specific SCI clocks.
The latter can be removed when all SH platforms will declare their SCI
clocks properly.

This series serves as a preparatory clock cleanup for the SCI baud rate
generator clock support series. I decided to keep it separate as this
series has more stringent internal dependencies:
  - The SH patches 2-3 depend on patch 1,
  - The DT patches 4-15 depend on patch 1,
  - Cleanup patch 16 depends on SH patch 2.

Thanks for your comments!

Changes compared to v1:
  - Take over the patches from Laurent,
  - Add Acked-by,
  - Handle EPROBE_DEFER,
  - Add missing patches to convert r8a7795 and h8300.

Geert Uytterhoeven (2):
  arm64: renesas: r8a7795 dtsi: Rename the serial port clock to fck
  h8300: dts: Rename the serial port clock to fck

Laurent Pinchart (14):
  serial: sh-sci: Drop the interface clock
  sh: Rename sci_ick and sci_fck clock to fck
  sh: Remove sci_ick clock alias
  ARM: shmobile: sh73a0 dtsi: Rename the serial port clock to fck
  ARM: shmobile: r7s72100 dtsi: Rename the serial port clock to fck
  ARM: shmobile: r8a73a4 dtsi: Rename the serial port clock to fck
  ARM: shmobile: r8a7740 dtsi: Rename the serial port clock to fck
  ARM: shmobile: r8a7778 dtsi: Rename the serial port clock to fck
  ARM: shmobile: r8a7779 dtsi: Rename the serial port clock to fck
  ARM: shmobile: r8a7790 dtsi: Rename the serial port clock to fck
  ARM: shmobile: r8a7791 dtsi: Rename the serial port clock to fck
  ARM: shmobile: r8a7793 dtsi: Rename the serial port clock to fck
  ARM: shmobile: r8a7794 dtsi: Rename the serial port clock to fck
  serial: sh-sci: Drop the sci_fck clock fallback

 .../bindings/serial/renesas,sci-serial.txt         |  4 +-
 arch/arm/boot/dts/r7s72100.dtsi                    | 16 +++---
 arch/arm/boot/dts/r8a73a4.dtsi                     | 12 ++---
 arch/arm/boot/dts/r8a7740.dtsi                     | 18 +++----
 arch/arm/boot/dts/r8a7778.dtsi                     | 12 ++---
 arch/arm/boot/dts/r8a7779.dtsi                     | 12 ++---
 arch/arm/boot/dts/r8a7790.dtsi                     | 20 ++++----
 arch/arm/boot/dts/r8a7791.dtsi                     | 36 ++++++-------
 arch/arm/boot/dts/r8a7793.dtsi                     |  4 +-
 arch/arm/boot/dts/r8a7794.dtsi                     | 36 ++++++-------
 arch/arm/boot/dts/sh73a0.dtsi                      | 18 +++----
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 22 ++++----
 arch/h8300/boot/dts/edosk2674.dts                  |  6 +--
 arch/h8300/boot/dts/h8300h_sim.dts                 |  4 +-
 arch/h8300/boot/dts/h8s_sim.dts                    |  4 +-
 arch/sh/kernel/cpu/clock-cpg.c                     |  1 -
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c             |  9 +++-
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c             | 16 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c             |  8 +--
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c             |  6 +--
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c             | 12 ++---
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c             | 12 ++---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c             |  6 +--
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c             | 12 ++---
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c             | 12 ++---
 arch/sh/kernel/cpu/sh4a/clock-shx3.c               |  8 +--
 drivers/tty/serial/sh-sci.c                        | 59 +++++++++++++---------
 27 files changed, 202 insertions(+), 183 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
