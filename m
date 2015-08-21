From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v3 0/4] serial: sh-sci: Add DT DMA support
Date: Fri, 21 Aug 2015 20:25:42 +0200
Message-ID: <1440181546-7334-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi,

This patch series adds DT DMA support to the Renesas "SCI" serial driver
on R-Car Gen2 SoCs.
It depends on "[PATCH v3 00/33] serial: sh-sci: Miscellaneous
and DMA Improvements", which contains preparatory patches that are
considered stable.

Some of these patches have been sent before, cfr.
  - [PATCH/RFC v2 00/29] serial: sh-sci: Miscellaneous and DMA
    Improvements (http://www.spinics.net/lists/linux-sh/msg43567.html)
  - [PATCH/RFC 0/8] serial: sh-sci: Add DT DMA support
    (http://www.spinics.net/lists/linux-sh/msg42258.html)

Major change is the replacement of the one-byte DMA transfer on (H)SCIF
by submitting receive DMA requests from the receive interrupt handler.

This was tested on r8a7791/koelsch, using SCIF, SCIFA, SCIFB, and HSCIF.
It should work with and without CONFIG_HIGHMEM (thanks to Shimoda-san).
There are still some known issues in case of overrun errors.

For your convenience, I've also pushed this to
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git#scif-dma-v3

While it doesn't seem to be a hard requirement, I included the fixed
version of "dmaengine: rcar-dmac: Fix residue reporting for pending
descriptors".

Note that SCI DMA support was originally written for SH-based systems,
and was never fully wired up in platform code in mainline, so the risk
for regressions is fairly small.

Thanks for your comments!

Geert Uytterhoeven (4):
  serial: sh-sci: Stop TX and RX on shutdown
  serial: sh-sci: Get rid of the workqueue to handle receive DMA
    requests
  serial: sh-sci: Submit RX DMA from RX interrupt on (H)SCIF
  serial: sh-sci: Add DT support to DMA setup

 drivers/tty/serial/sh-sci.c | 254 +++++++++++++++++++++++---------------------
 1 file changed, 133 insertions(+), 121 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
