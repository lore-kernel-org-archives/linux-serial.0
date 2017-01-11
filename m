From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 00/18] sh-sci: Platform data simplification
Date: Wed, 11 Jan 2017 16:43:22 +0200
Message-ID: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Hello,

This is the second version of the sh-sci platform data simplification patch
series, now with all acks collected and ready to be merged. Greg, could you
take the whole series through your tree ? The arch/sh/ patches should not
cause any conflict as they only touch legacy platforms that have got very
little attention recently (no patch in 2016, a single patch in 2015, five
patches in 2014).

Most of the patches in this series have been sitting in my development tree
for three years now. While rebasing all my development branches I decided it
was time to send them out in case they're considered useful. I've then thrown
a few additional patches in to move the driver further in the right direction
(or at least the direction I consider right).

The idea behind this series is to move towards removal of the sh-sci platform
data. This won't be possible until SH platforms move to DT (and I won't hold
my breath), but we can get rid of most of the platform data fields already and
cleanup the sh-sci driver at the same time.

The series already removes the capabilities, port_reg, regshift, dma_slave_tx
and dma_slave_rx fields. We should be able to go further:

- The flags field is only used by sh5 to set UPF_IOREMAP. It should be
  possible to find another way to determine in the driver whether to ioremap
  the registers.

- The sampling_rate field is only used by sh7723 and sh7724 to override the
  value hardcoded in the driver, even though the datasheets of those SoCs
  don't mention any restriction. This might not be needed and should be
  investigated.

- The scscr REIE bit should be possible to compute in the driver, as it's set
  for all SCIF ports except SCIx_SH3_SCIF_REGTYPE, SCIx_SH7705_SCIF_REGTYPE,
  and the sh7343 SCIx_SH4_SCIF_REGTYPE. The latter will be trickier to handle.

- Now that we have support for baud rate generators and externel clocks, the
  scscr CKE1 bit should be computed in the driver in all cases.

- The scscr TOIE bit doesn't seem to follow a clear rule, but given that it's
  the last scscr bit to handle I'm sure we'll find something 

- It might make sense to merge the type and regtype fields in a single type.

Finally, it might be time to drop support for the SH platforms that would get
in the way of sh-sci cleanup.

Laurent Pinchart (18):
  serial: sh-sci: Set the SCSCR TE and RE bits in the driver
  serial: sh-sci: Don't rely on platform data flags when not needed
  sh: Don't set sh-sci pdata scscr TE and RE bits
  sh: Don't set sh-sci pdata scscr TIE and RIE bits
  sh: sh726[49]: Don't set sh-sci pdata scscr TOIE bit
  sh: Don't set the sh-sci pdata UPF_BOOT_AUTOCONF flags
  sh: Don't set sh-sci port_reg
  sh: Don't set the sh-sci platform data scscr CKE0 bit
  sh: Don't set the sh-sci platform data REIE bit when not implemented
  serial: sh-sci: Fix register offsets for the IRDA serial port
  serial: sh-sci: Remove initialization of zero fields in
    sci_port_params
  serial: sh-sci: Replace regmap array with port parameters
  serial: sh-sci: Constify platform data
  serial: sh-sci: Extend sci_port_params with more port parameters
  serial: sh-sci: Remove the platform data dma slave rx/tx channel IDs
  serial: sh-sci: Remove manual break debouncing
  serial: sh-sci: Remove unused platform data capabilities field
  serial: sh-sci: Compute the regshift value for SCI ports

 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   9 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |  24 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |  16 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |  12 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |  32 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |  32 +-
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   6 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |  10 -
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   8 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   4 -
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   9 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |  21 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |  12 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   4 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   9 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  21 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  21 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |  18 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   9 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   9 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |  30 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   6 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  18 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  18 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   9 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |   4 +-
 drivers/tty/serial/sh-sci.c            | 831 ++++++++++++++-------------------
 drivers/tty/serial/sh-sci.h            |   4 +-
 include/linux/serial_sci.h             |  15 -
 31 files changed, 448 insertions(+), 779 deletions(-)

-- 
Regards,

Laurent Pinchart

