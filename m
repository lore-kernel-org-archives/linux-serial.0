From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/9] ARM: shmobile: dts: Enable SCIF_CLK frequency and pins
Date: Mon, 14 Dec 2015 19:58:15 +0100
Message-ID: <1450119504-1517-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Simon, Magnus,

This patch series adds support for the external crystal feeding SCIF_CLK
to (H)SCIF on the various R-Car Gen1, Gen2, and Gen3 development boards.
This increases the range and accuracy of supported baud rates.

This series is an updated version of a part of a series I sent before as
"[PATCH v2 00/16] serial: sh-sci: Clock Cleanups"
(http://www.spinics.net/lists/linux-serial/msg19762.html). To reduce
(cross) dependencies, I split off the core patches and some DT parts
into separate series.

Changes compared to previous submission:
  - Add support for r8a7778/bockw, r8a7779/marzen, r8a7790/lager,
    r8a7791/porter, r8a7793/gose, r8a7794/alt, and r8a7794/silk,
  - Add Reviewed-by.

Dependencies:
  - This series is against renesas-devel-20151214-v4.4-rc5, with the
    following applied on top:
      - "[PATCH 0/7] ARM: shmobile: dtsi: Add SCIF fallback
	 compatibility strings",
      - "[PATCH v3 00/12] ARM: shmobile: dtsi: Rename the serial port
	 clock to fck",
      - "[PATCH v2 0/7] ARM: shmobile: dtsi: Add BRG support for
	 (H)SCIF",
  - This has runtime dependencies on:
      - "[PATCH 0/2] pinctrl: sh-pfc: r8a7791/r8a7795: Add SCIF_CLK
	 support",
      - "[PATCH 0/3] pinctrl: sh-pfc: r8a7779/r8a7790/r8a7794: Add
	 SCIF_CLK support",
    unless you want to depend on pinctrl as configured by U-Boot (on
    most, but not all R-Car Gen2 boards).
    Note that I plan to get the pinctrl dependencies in v4.5, so this
    series should be OK to queue for v4.6.
    Note that the bockw pinctrl support is already upstream.

Testing:
  - This was tested locally on r8a7791/koelsch and r8a7795/salvator-x,
  - This was tested remotely on r8a7778/bockw and r8a7779/marzen,
  - Testing on other boards would be highly appreciated!
  - Hints for various levels of testing:
      - Change the "dev_dbg" after "done:" in
	drivers/tty/serial/sh-sci.c to "dev_info" to print clock and bit
	rate,
      - "yes U | tr -d '\n' > /dev/ttySCx" outputs a square wave with a
	frequency of half the bit rate on TXD,
      - Modifying the frequency of SCIF_CLK causes garbage on the serial
	console, unless you compensate by changing the bit rate in
	/chosen/stdout-path,
      - If you disable the SCIF_CLK, the brg_int clock will be used. If
	you change that clock, you'll get garbage again,
  - renesas-drivers-2015-12-14-v4.4-rc5 has all dependencies
    https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git

Thanks!

Geert Uytterhoeven (9):
  ARM: shmobile: alt dts: Enable SCIF_CLK frequency and pins
  ARM: shmobile: bockw dts: Enable SCIF_CLK frequency and pins
  ARM: shmobile: gose dts: Enable SCIF_CLK frequency and pins
  ARM: shmobile: koelsch dts: Enable SCIF_CLK frequency and pins
  ARM: shmobile: lager dts: Enable SCIF_CLK frequency and pins
  ARM: shmobile: marzen dts: Enable SCIF_CLK frequency and pins
  ARM: shmobile: porter dts: Enable SCIF_CLK frequency and pins
  ARM: shmobile: silk dts: Enable SCIF_CLK frequency and pins
  arm64: renesas: salvator-x dts: Enable SCIF_CLK frequency and pins

 arch/arm/boot/dts/r8a7778-bockw.dts                | 13 +++++++++++++
 arch/arm/boot/dts/r8a7779-marzen.dts               | 13 +++++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts                | 13 +++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 13 +++++++++++++
 arch/arm/boot/dts/r8a7791-porter.dts               | 13 +++++++++++++
 arch/arm/boot/dts/r8a7793-gose.dts                 | 13 +++++++++++++
 arch/arm/boot/dts/r8a7794-alt.dts                  | 13 +++++++++++++
 arch/arm/boot/dts/r8a7794-silk.dts                 | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 9 files changed, 116 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
