From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 00/10] serial: sh-sci: Add DT DMA support
Date: Fri, 18 Sep 2015 13:08:23 +0200
Message-ID: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Muhammad Hamza Farooq <mfarooq@visteon.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri,

This patch series adds DT DMA support to the Renesas "SCI" serial driver
on R-Car Gen2 SoCs.
It depends on "[PATCH v3 00/33] serial: sh-sci: Miscellaneous and DMA
Improvements" [1], which contains preparatory patches that were
considered stable and safe before.

Changes compared to "[PATCH/RFC v3 0/4] serial: sh-sci: Add DT DMA
support" [2]:
  - Dropped RFC status,
  - Dropped "serial: sh-sci: Stop TX and RX on shutdown", as it caused
    serial console output to stop suddenly during halt/reboot on e.g.
    armadillo and kzm9g,
  - Added sevaral new fixes, mostly from Muhammad Hamza Farooq and
    Aleksandar Mitev (thanks a lot!),
  - Added a first patch to shuffle functions around, to avoid churn in
    patches making functional changes.

This was tested on r8a7791/koelsch (using SCIF, SCIFA, SCIFB, and
HSCIF), and received some testing on r8a7795/salvator-x (using SCIF and
HSCIF).

While it doesn't matter much at low speeds, reliability at high speeds
(> 1 Mbps) is improved by applying the following improvements to the
rcar-dmac driver:
  - "[PATCH] dmaengine: rcar-dmac: Fix residue reporting for pending
    descriptors" [3],
  - Muhammad Hamza Farooq's series "[PATCH 0/6] rcar DMA engine patches"
    [4].

Note that SCI DMA support was originally written for SH-based systems,
and was never fully wired up in platform code in mainline, so the risk
for regressions is fairly small.

For testing convenience, I've pushed this and related series to topic
branches in
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git:
  - topic/scif-misc-v3 [1]
  - topic/scif-dma-v4
  - topic/rcar-dmac-residue-v1 [3]
  - topic/rcar-dmac-hamza-v1 [4]

Thanks!

References:
  [1] http://www.spinics.net/lists/linux-serial/msg18682.html
  [2] http://www.spinics.net/lists/linux-sh/msg44347.html
  [3] http://www.spinics.net/lists/dmaengine/msg05711.html
  [4] http://www.spinics.net/lists/dmaengine/msg06103.html

Aleksandar Mitev (1):
  serial: sh-sci: Remove timer on shutdown of port

Geert Uytterhoeven (5):
  serial: sh-sci: Shuffle functions around
  serial: sh-sci: Get rid of the workqueue to handle receive DMA
    requests
  serial: sh-sci: Submit RX DMA from RX interrupt on (H)SCIF
  serial: sh-sci: Stop calling sci_start_rx() from sci_request_dma()
  serial: sh-sci: Add DT support to DMA setup

Muhammad Hamza Farooq (4):
  serial: sh-sci: Redirect port interrupts to CPU _only_ when DMA stops
  serial: sh-sci: Call dma_async_issue_pending when transaction
    completes
  serial: sh-sci: Do not terminate DMA engine when race condition occurs
  serial: sh-sci: Pause DMA engine and get DMA status again

 drivers/tty/serial/sh-sci.c | 1364 ++++++++++++++++++++++---------------------
 1 file changed, 698 insertions(+), 666 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
