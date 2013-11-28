From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 00/16] sh-sci: Remove unnecessary fields from platform data
Date: Thu, 28 Nov 2013 22:43:14 +0100
Message-ID: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

This patch set removes or replaces unneeded fields from the sh-sci platform
data structure. Fields are simply removed when unused (gpios), moved to the
sci_port structure when used by the driver but not by board code (overrun_bit
and error_mask), or replaced by a more explicit field with a default value
computed in the driver for most cases (scbrr_algo_id).

The patches are based on top of the sh-sci DT patch series previously posted
to the mailing lists.

Laurent Pinchart (16):
  serial: sh-sci: Move overrun_bit and error_mask fields out of pdata
  serial: sh-sci: Remove unused GPIO request code
  serial: sh-sci: Compute overrun_bit without using baud rate algo
  serial: sh-sci: Rework baud rate calculation
  ARM: shmobile: sh7372: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: sh73a0: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r7s72100: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a73a4: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7740: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7778: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7779: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7790: Don't set plat_sci_port scbrr_algo_id field
  ARM: shmobile: r8a7791: Don't set plat_sci_port scbrr_algo_id field
  sh: sh772[34]: Set serial port sampling rate to 8 for SCIFA ports
  sh: Don't set plat_sci_port scbrr_algo_id field
  serial: sh-sci: Remove platform data scbrr_algo_id field

 arch/arm/mach-shmobile/setup-r7s72100.c |   1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c  |   1 -
 arch/arm/mach-shmobile/setup-r8a7740.c  |   1 -
 arch/arm/mach-shmobile/setup-r8a7778.c  |   1 -
 arch/arm/mach-shmobile/setup-r8a7779.c  |   1 -
 arch/arm/mach-shmobile/setup-r8a7790.c  |  11 +--
 arch/arm/mach-shmobile/setup-r8a7791.c  |   9 +-
 arch/arm/mach-shmobile/setup-sh7372.c   |   1 -
 arch/arm/mach-shmobile/setup-sh73a0.c   |   1 -
 arch/sh/kernel/cpu/sh2/setup-sh7619.c   |   3 -
 arch/sh/kernel/cpu/sh2a/setup-mxg.c     |   1 -
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c  |   8 --
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c  |   4 -
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c  |   4 -
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c  |   8 --
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c  |   8 --
 arch/sh/kernel/cpu/sh3/setup-sh7705.c   |   2 -
 arch/sh/kernel/cpu/sh3/setup-sh770x.c   |   3 -
 arch/sh/kernel/cpu/sh3/setup-sh7710.c   |   2 -
 arch/sh/kernel/cpu/sh3/setup-sh7720.c   |   2 -
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c  |   1 -
 arch/sh/kernel/cpu/sh4/setup-sh7750.c   |   2 -
 arch/sh/kernel/cpu/sh4/setup-sh7760.c   |   4 -
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c  |   4 -
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c  |   1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c  |   3 -
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c  |   9 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c  |   9 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c  |   6 --
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c  |   3 -
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c  |   3 -
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c  |  10 --
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c  |   4 -
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c  |   6 --
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c  |   6 --
 arch/sh/kernel/cpu/sh4a/setup-shx3.c    |   3 -
 arch/sh/kernel/cpu/sh5/setup-sh5.c      |   1 -
 drivers/tty/serial/sh-sci.c             | 170 ++++++++++----------------------
 drivers/tty/serial/sh-sci.h             |   2 +-
 include/linux/serial_sci.h              |  25 +----
 40 files changed, 68 insertions(+), 276 deletions(-)

-- 
Regards,

Laurent Pinchart

