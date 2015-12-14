From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 00/12] ARM: shmobile: dtsi: Rename the serial port clock to fck
Date: Mon, 14 Dec 2015 19:57:54 +0100
Message-ID: <1450119486-1285-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Simon, Magnus, Sato-san,

This patch series renames the serial port clock to fck, cfr. "[PATCH v3
01/27] serial: sh-sci: Drop the interface clock" or series "[PATCH v3
00/27] serial: sh-sci: External Clock Support".

This series is an updated version of the DT changes of a series I sent
before as "[PATCH v2 00/16] serial: sh-sci: Clock Cleanups"
(http://www.spinics.net/lists/linux-serial/msg19762.html). To reduce
(cross) dependencies, I split off the core patches and BRG DT patches
into separate series.

Changes compared to previous submission:
  - Add Acked-by,
  - Update for "[PATCH 0/2] ARM: shmobile: r8a7793: Increase scif
    support".

Dependencies:
  - This series is against renesas-devel-20151214-v4.4-rc5, with the
    following applied on top:
      - "[PATCH 0/7] ARM: shmobile: dtsi: Add SCIF fallback
	 compatibility strings",
  - It has a hard dependency on the aforementioned "[PATCH v3 01/27]
    serial: sh-sci: Drop the interface clock", so depending on the
    merge strategy chosen, it may have to be postponed to v4.6,
  - Later series depend on this:
      - "[PATCH v2 0/7] ARM: shmobile: dtsi: Add BRG support for
	 (H)SCIF"
      - "[PATCH v2 0/9] ARM: shmobile: dts: Enable SCIF_CLK frequency
	 and pins".

Sato-san: I took the liberty to include the h8300 DTS changes in this
series. Perhaps you may want to provide your ack, so Simon can take it
together with the ARM shmobile changes?

Thanks!

Geert Uytterhoeven (2):
  h8300: dts: Rename the serial port clock to fck
  arm64: renesas: r8a7795 dtsi: Rename the serial port clock to fck

Laurent Pinchart (10):
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

 arch/arm/boot/dts/r7s72100.dtsi          | 16 +++++++-------
 arch/arm/boot/dts/r8a73a4.dtsi           | 12 +++++------
 arch/arm/boot/dts/r8a7740.dtsi           | 18 ++++++++--------
 arch/arm/boot/dts/r8a7778.dtsi           | 12 +++++------
 arch/arm/boot/dts/r8a7779.dtsi           | 12 +++++------
 arch/arm/boot/dts/r8a7790.dtsi           | 20 +++++++++---------
 arch/arm/boot/dts/r8a7791.dtsi           | 36 ++++++++++++++++----------------
 arch/arm/boot/dts/r8a7793.dtsi           | 36 ++++++++++++++++----------------
 arch/arm/boot/dts/r8a7794.dtsi           | 36 ++++++++++++++++----------------
 arch/arm/boot/dts/sh73a0.dtsi            | 18 ++++++++--------
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 22 +++++++++----------
 arch/h8300/boot/dts/edosk2674.dts        |  6 +++---
 arch/h8300/boot/dts/h8300h_sim.dts       |  4 ++--
 arch/h8300/boot/dts/h8s_sim.dts          |  4 ++--
 14 files changed, 126 insertions(+), 126 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
