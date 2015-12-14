From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/7] ARM: shmobile: dtsi: Add BRG support for (H)SCIF
Date: Mon, 14 Dec 2015 19:58:08 +0100
Message-ID: <1450119495-1416-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Simon, Magnus,

This patch series adds support for the Baud Rate Generator for External
Clock (BRG), as found on SCIF and HSCIF, to the DTS files for all R-Car
Gen1, Gen2, and Gen3 SoCs.

This series is an updated version of a part of a series I sent before as
"[PATCH v2 00/16] serial: sh-sci: Clock Cleanups"
(http://www.spinics.net/lists/linux-serial/msg19762.html). To reduce
(cross) dependencies, I split off the core patches and some DT parts
into separate series.

Changes compared to previous submission:
  - Rename "int_clk" to "brg_int",
  - Add support for R-Car M1A (r8a7778) and R-Car H1 (r8a7779),
  - Add support for R-Car H2 (r8a7790), R-Car M2-N (r8a7793), and R-Car
    E2 (r8a7794),
  - Correct internal clock source ZS_CLK to S3D1 in patch description
    for r8a7795,

Dependencies:
  - This series is against renesas-devel-20151214-v4.4-rc5, with the
    following applied on top:
      - "[PATCH 0/7] ARM: shmobile: dtsi: Add SCIF fallback
	 compatibility strings",
      - "[PATCH v3 00/12] ARM: shmobile: dtsi: Rename the serial port
	 clock to fck",
  - It can be applied as soon as the DT bindings in "[PATCH v3 04/27]
    serial: sh-sci: Update DT binding documentation for BRG support" of
    series "[PATCH v3 00/27] serial: sh-sci: External Clock Support"
    have been accepted,
  - Later series depend on this:
      - "[PATCH v2 0/9] ARM: shmobile: dts: Enable SCIF_CLK frequency
	 and pins".

This was tested on r8a7778/bockw, r8a7779/marzen, r8a7791/koelsch, and
r8a7795/salvator-x.

Geert Uytterhoeven (7):
  ARM: shmobile: r8a7778 dtsi: Add BRG support for SCIF
  ARM: shmobile: r8a7779 dtsi: Add BRG support for SCIF
  ARM: shmobile: r8a7790 dtsi: Add BRG support for (H)SCIF
  ARM: shmobile: r8a7791 dtsi: Add BRG support for (H)SCIF
  ARM: shmobile: r8a7793 dtsi: Add BRG support for SCIF
  ARM: shmobile: r8a7794 dtsi: Add BRG support for (H)SCIF
  arm64: renesas: r8a7795 dtsi: Add BRG support for (H)SCIF

 arch/arm/boot/dts/r8a7778.dtsi           | 39 +++++++++++------
 arch/arm/boot/dts/r8a7779.dtsi           | 39 +++++++++++------
 arch/arm/boot/dts/r8a7790.dtsi           | 29 +++++++++----
 arch/arm/boot/dts/r8a7791.dtsi           | 54 +++++++++++++++--------
 arch/arm/boot/dts/r8a7793.dtsi           | 54 +++++++++++++++--------
 arch/arm/boot/dts/r8a7794.dtsi           | 54 +++++++++++++++--------
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 74 ++++++++++++++++++++++----------
 7 files changed, 235 insertions(+), 108 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
