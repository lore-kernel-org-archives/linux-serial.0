From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 00/33] serial: sh-sci: Miscellaneous and DMA Improvements
Date: Fri, 21 Aug 2015 20:02:24 +0200
Message-ID: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi,

This patch series contains several miscellaneous and DMA improvements
for the Renesas "SCI" serial driver. The goal is to prepare for enabling
DMA on DT-based R-Car Gen2 SoCs.

This series contains preparatory patches that have been sent before
(change logs in the individual patches), or are fairly simple, and thus
considered safe for applying.

The "RFC" patches actually enabling DMA will be sent in a separate
series ("[PATCH/RFC v3 0/4] serial: sh-sci: Add DT DMA support").

Note that SCI DMA support was originally written for SH-based systems,
and was never fully wired up in platform code in mainline, so the risk
for regressions is fairly small.

Thanks!

References:
  - [PATCH/RFC v2 00/29] serial: sh-sci: Miscellaneous and DMA
    Improvements (http://www.spinics.net/lists/linux-sh/msg43567.html)
  - [PATCH/RFC 0/8] serial: sh-sci: Add DT DMA support
    (http://www.spinics.net/lists/linux-sh/msg42258.html)
  - [PATCH/RFC 00/13] serial: sh-sci: Cleanups and bug fixes
    (http://www.spinics.net/lists/linux-serial/msg17122.html)

Geert Uytterhoeven (29):
  serial: sh-sci: Replace buggy big #ifdef by runtime logic
  serial: sh-sci: Prevent compiler warnings on 64-bit
  serial: sh-sci: Correct SCIF_ERROR_CLEAR for plain SCIF
  serial: sh-sci: Use SCIF_DR instead of hardcoded literal 1
  serial: sh-sci: Use SCSMR_CKS instead of hardcoded literal 3
  serial: sh-sci: Drop path in reference to serial_core.c
  serial: sh-sci: Improve readability of sampling rate configuration
  serial: sh-sci: Make sci_irq_desc[] const
  serial: sh-sci: Make sci_regmap[] const
  serial: sh-sci: Remove useless memory allocation failure printks
  serial: sh-sci: Remove bogus sci_handle_fifo_overrun() call on (H)SCIF
  serial: sh-sci: Improve DMA error messages
  serial: sh-sci: Improve comments for DMA timeout calculation
  serial: sh-sci: Handle DMA init failures inside sci_request_dma()
  serial: sh-sci: Use correct device for DMA mapping with IOMMU
  serial: sh-sci: Use min_t()/max_t() instead of casts
  serial: sh-sci: Switch to dma_map_single() for DMA transmission
  serial: sh-sci: Fix TX buffer mapping leak
  serial: sh-sci: Use DMA submission helpers instead of open-coding
  serial: sh-sci: Switch to generic DMA residue handling
  serial: sh-sci: Stop acknowledging DMA transmit completions
  serial: sh-sci: Simplify sci_submit_rx() error handling
  serial: sh-sci: Do not resubmit DMA descriptors
  serial: sh-sci: Fix race condition between RX worker and cleanup
  serial: sh-sci: Pass scatterlist to sci_dma_rx_push()
  serial: sh-sci: Use tty_insert_flip_string() for DMA receive
  serial: sh-sci: Use incrementing pointers instead of stack array
  serial: sh-sci: Don't call sci_rx_interrupt() on error when using DMA
  serial: sh-sci: Don't call sci_dma_rx_push() if no data has arrived

Kazuya Mizuguchi (1):
  serial: sh-sci: Fix exclusion of work_fn_rx and sci_dma_rx_complete

Yoshihiro Shimoda (3):
  serial: sh-sci: Return IRQ_HANDLED when overrun if detected
  serial: sh-sci: Fix NULL pointer dereference if HIGHMEM is enabled
  serial: sh-sci: Don't kick tx in sci_er_interrupt() when using DMA

 drivers/tty/serial/Kconfig  |   2 +-
 drivers/tty/serial/sh-sci.c | 416 ++++++++++++++++++++++++--------------------
 drivers/tty/serial/sh-sci.h |  49 ++----
 3 files changed, 241 insertions(+), 226 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
