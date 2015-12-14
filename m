From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] ARM: shmobile: dtsi: Add SCIF fallback compatibility strings
Date: Mon, 14 Dec 2015 19:57:48 +0100
Message-ID: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Simon, Magnus,

This patch series adds fallback compatibility strings for SCIF and HSCIF
to the DTS files for R-Car Gen1, Gen2, and Gen3, as defined in
"[PATCH v3 02/27] serial: sh-sci: Add fallback compatibility strings" of
series "[PATCH v3 00/27] serial: sh-sci: External Clock Support".
This will allow the sh-sci driver to match on family-specific compatible
values to enable BGR support later.

Note that fallback compatibility strings for SCIFA/SCIFB are not added
yet.

Dependencies:
  - This series is against renesas-devel-20151214-v4.4-rc5,
  - It can be applied independently, as soon as the aforementioned DT
    binding patch has been accepted,
  - Later series depend on this:
      - "[PATCH v3 00/12] ARM: shmobile: dtsi: Rename the serial port
	 clock to fck",
      - "[PATCH v2 0/7] ARM: shmobile: dtsi: Add BRG support for (H)SCIF",
      - "[PATCH v2 0/9] ARM: shmobile: dts: Enable SCIF_CLK frequency and
	 pins".

Thanks for applying!

Geert Uytterhoeven (7):
  ARM: shmobile: r8a7778 dtsi: Add SCIF fallback compatibility strings
  ARM: shmobile: r8a7779 dtsi: Add SCIF fallback compatibility strings
  ARM: shmobile: r8a7790 dtsi: Add SCIF fallback compatibility strings
  ARM: shmobile: r8a7791 dtsi: Add SCIF fallback compatibility strings
  ARM: shmobile: r8a7793 dtsi: Add SCIF fallback compatibility strings
  ARM: shmobile: r8a7794 dtsi: Add SCIF fallback compatibility strings
  arm64: renesas: r8a7795 dtsi: Add SCIF fallback compatibility strings

 arch/arm/boot/dts/r8a7778.dtsi           | 18 +++++++----
 arch/arm/boot/dts/r8a7779.dtsi           | 18 +++++++----
 arch/arm/boot/dts/r8a7790.dtsi           | 30 ++++++++++++------
 arch/arm/boot/dts/r8a7791.dtsi           | 54 +++++++++++++++++++++-----------
 arch/arm/boot/dts/r8a7793.dtsi           | 54 +++++++++++++++++++++-----------
 arch/arm/boot/dts/r8a7794.dtsi           | 54 +++++++++++++++++++++-----------
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 38 +++++++++++++++-------
 7 files changed, 179 insertions(+), 87 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
