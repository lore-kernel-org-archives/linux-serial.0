From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 00/47] sh-sci updates for v3.14
Date: Fri,  6 Dec 2013 10:59:07 +0100
Message-ID: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

Hello,

This patch series combines the sh-sci and related arch/ changes from the
following previously posted series.

[PATCH 0/2] serial: sh-sci: Prepare for CCF migration
[PATCH v3 00/29] Add OF support to the sh-sci serial port driver
[PATCH 00/16] sh-sci: Remove unnecessary fields from platform data

The patches have been rebased on top of renesas-devel-v3.13-rc2-20131205 and
reordered to have a single arch/ set between two sh-sci sets. Nothing else has
been changed.

Simon, I believe this set to be ready for v3.14. Greg has acked all the sh-sci
patches, and no comment has been received for some time now.

Bastian Hecht (1):
  serial: sh-sci: Add OF support

Laurent Pinchart (46):
  serial: sh-sci: Don't enable/disable port from within break timer
  serial: sh-sci: Convert to clk_prepare/unprepare
  serial: sh-sci: Sort headers alphabetically
  serial: sh-sci: Remove baud rate calculation algorithm 5
  serial: sh-sci: Simplify baud rate calculation algorithms
  serial: sh-sci: Remove duplicate interrupt check in verify port op
  serial: sh-sci: Set the UPF_FIXED_PORT flag
  serial: sh-sci: Don't check IRQ in verify port operation
  serial: sh-sci: Support resources passed through platform resources
  serial: sh-sci: Move overrun_bit and error_mask fields out of pdata
  serial: sh-sci: Remove unused GPIO request code
  serial: sh-sci: Compute overrun_bit without using baud rate algo
  serial: sh-sci: Rework baud rate calculation
  ARM: shmobile: sh7372: Use macros to declare SCIF devices
  ARM: shmobile: sh73a0: Use macros to declare SCIF devices
  ARM: shmobile: r8a7740: Use macros to declare SCIF devices
  ARM: shmobile: r8a7779: Use macros to declare SCIF devices
  ARM: shmobile: r7s72100: Don't define SCIF platform data in an array
  ARM: shmobile: r8a73a4: Don't define SCIF platform data in an array
  ARM: shmobile: r8a7778: Don't define SCIF platform data in an array
  ARM: shmobile: r8a7790: Don't define SCIF platform data in an array
  ARM: shmobile: r8a7791: Don't define SCIF platform data in an array
  ARM: shmobile: sh7372: Declare SCIF register base and IRQ as resources
  ARM: shmobile: sh73a0: Declare SCIF register base and IRQ as resources
  ARM: shmobile: r7s72100: Declare SCIF register base and IRQ as
    resources
  ARM: shmobile: r8a73a4: Declare SCIF register base and IRQ as
    resources
  ARM: shmobile: r8a7740: Declare SCIF register base and IRQ as
    resources
  ARM: shmobile: r8a7778: Declare SCIF register base and IRQ as
    resources
  ARM: shmobile: r8a7779: Declare SCIF register base and IRQ as
    resources
  ARM: shmobile: r8a7790: Declare SCIF register base and IRQ as
    resources
  ARM: shmobile: r8a7791: Declare SCIF register base and IRQ as
    resources
  ARM: shmobile: sh7372: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: sh73a0: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r7s72100: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a73a4: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7740: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7778: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7779: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7790: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7791: Don't set plat_sci_port scbrr_algo_id field
  sh: Declare SCIF register base and IRQ as resources
  sh: sh772[34]: Set serial port sampling rate to 8 for SCIFA ports
  sh: Don't set plat_sci_port scbrr_algo_id field
  serial: sh-sci: Remove platform data scbrr_algo_id field
  serial: sh-sci: Remove platform data mapbase and irqs fields
  serial: sh-sci: Add device tree bindings documentation

 .../bindings/serial/renesas,sci-serial.txt         |  46 +++
 arch/arm/mach-shmobile/setup-r7s72100.c            |  64 ++--
 arch/arm/mach-shmobile/setup-r8a73a4.c             |  66 ++--
 arch/arm/mach-shmobile/setup-r8a7740.c             | 195 ++--------
 arch/arm/mach-shmobile/setup-r8a7778.c             |  46 ++-
 arch/arm/mach-shmobile/setup-r8a7779.c             | 128 ++-----
 arch/arm/mach-shmobile/setup-r8a7790.c             | 116 +++---
 arch/arm/mach-shmobile/setup-r8a7791.c             | 129 +++----
 arch/arm/mach-shmobile/setup-sh7372.c              | 160 ++------
 arch/arm/mach-shmobile/setup-sh73a0.c              | 191 ++--------
 arch/sh/kernel/cpu/sh2/setup-sh7619.c              |  30 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c                |  10 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c             |  80 ++--
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c             |  40 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c             |  40 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c             | 104 ++++--
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c             | 104 ++++--
 arch/sh/kernel/cpu/sh3/setup-sh7705.c              |  20 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c              |  30 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c              |  20 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c              |  20 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c             |  16 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c              |  20 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c              |  62 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c             |  40 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c             |  10 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c             |  30 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c             |  63 +++-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c             |  63 +++-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c             |  72 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c             |  30 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c             |  30 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c             | 100 +++--
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c             |  22 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c             |  60 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c             |  88 +++--
 arch/sh/kernel/cpu/sh4a/setup-shx3.c               |  48 ++-
 arch/sh/kernel/cpu/sh5/setup-sh5.c                 |  12 +-
 drivers/tty/serial/sh-sci.c                        | 406 ++++++++++++---------
 drivers/tty/serial/sh-sci.h                        |   2 +-
 include/linux/serial_sci.h                         |  52 +--
 41 files changed, 1497 insertions(+), 1368 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt

-- 
Regards,

Laurent Pinchart

