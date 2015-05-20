From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] serial: sh-sci: Add DMA support to the DT binding
Date: Wed, 20 May 2015 19:46:23 +0200
Message-ID: <1432143987-10308-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Simon, Magnus,

This patch series adds DMA support to the DT binding documentation for
the various Renesas (H)SCI(F{,A,B}) serial ports, and adds the
corresponding properties to the Renesas R-Car Gen2 DT source files.

  - Patch 1 updates the DT binding documentation.
  - Patches 2-4 update the dtsi files.

Although the sh-sci driver itself doesn't support DT DMA properties
yet, it's safe to apply patches 2-4, as DT describes the hardware, not
the (current) features of the Linux driver implementation.

Thanks!

Geert Uytterhoeven (4):
  serial: sh-sci: Add DMA support to the DT binding documentation
  ARM: shmobile: r8a7790 dtsi: Describe DMA for the serial ports
  ARM: shmobile: r8a7791 dtsi: Describe DMA for the serial ports
  ARM: shmobile: r8a7794 dtsi: Describe DMA for the serial ports

 .../bindings/serial/renesas,sci-serial.txt         |  7 +++++
 arch/arm/boot/dts/r8a7790.dtsi                     | 20 ++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi                     | 36 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7794.dtsi                     | 36 ++++++++++++++++++++++
 4 files changed, 99 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
