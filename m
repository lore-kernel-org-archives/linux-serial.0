From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 00/29] Add OF support to the sh-sci serial port driver
Date: Thu, 28 Nov 2013 00:18:10 +0100
Message-ID: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:56623 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757602Ab3K0XSi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 18:18:38 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, devicetree@vger.kernel.org, Greg KH <greg@kroah.com>, Simon Horman <horms@verge.net.au>

Hello,

This is the fourth version of the patch set adds device tree bindings for the
sh sci serial port devices and adds OF parsing to the sh-sci driver.

The bindings are based on Bastian Hecht's proposal (see
http://www.spinics.net/lists/arm-kernel/msg228129.html). The approach taken
here is more minimalistic: instead of describing all hardware characteristics
that vary between the SCI device revisions in DT (such as registers layout),
that information is stored in the driver and selected based on the compatible
property value. Only SCI revisions used on ARM devices are supported through
DT, as DT support for SuperH is nowhere down the line.

Patches 01/29 to 06/29 clean up the sh-sci driver. Patches 07/29 to 27/29
replace memory and interrupt resources passed through platform data with
platform resources. Beside replacing a custom mechanism with a standard one,
it will also make the DT parsing code simpler as resource allocation will be
shared between DT and non-DT code paths. Finally, patches 28/29 to 29/29 add
OF parsing to the sh-sci driver and create DT bindings documentation.

The patches have been test on a Lager board (r8a7790-based) and a Koelsch board
(r8a7791-based). Support for other SoCs will be added as needed. Note that all
current Renesas ARM SoCs seem to be compatible with the generic (H)SCI(F)(AB)
devices, but the plan is for their DT bindings to list the SoC-specific version
in case incompatibilities are found later.

The series will need to be split in three parts to go to mainline. Patches
01/29 to 07/29 should go through Greg's tree, patches 08/29 to 26/29 through
Simon's tree, and patches 27/29 to 29/29 through Greg's tree again. Simon will
need a stable branch with the first seven patches, and should in turn provide
a stable branch to base the last three patches on.

Alternatively the whole series could go through Simon's tree. Greg, would that
be fine with you ? The patches that would go through your tree touch
drivers/tty/serial/sh-sci.c, include/linux/serial_sci.h and
Documentation/devicetree/bindings/serial/renesas,sci-serial.txt only. There
should be no risk of conflict if Simon takes all the sh-sci patches for the
next kernel version.

Changes compared to v3:

- Rebased on top of renesas-devel-v3.13-rc1-20131125

Changes compared to v2:

- Fix indentation in 12/29
- Remove interrupt-parent property from the DT bindings documentation
- Remove -generic suffix from DT compatible values
- Reword the DT bindings documentation based on comments received on v2
- Added r8a7791 support to the DT bindings

Changes compared to v1:

- Patches 04/29 to 27/29 have been added
- Multi-interrupt support has been removed from the DT bindings as they don't
  support any SoC requiring multi-interrupt yet

Cc: devicetree@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Cc: Simon Horman <horms@verge.net.au>

Bastian Hecht (1):
  serial: sh-sci: Add OF support

Laurent Pinchart (28):
  serial: sh-sci: Sort headers alphabetically
  serial: sh-sci: Remove baud rate calculation algorithm 5
  serial: sh-sci: Simplify baud rate calculation algorithms
  serial: sh-sci: Remove duplicate interrupt check in verify port op
  serial: sh-sci: Set the UPF_FIXED_PORT flag
  serial: sh-sci: Don't check IRQ in verify port operation
  serial: sh-sci: Support resources passed through platform resources
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
  sh: Declare SCIF register base and IRQ as resources
  serial: sh-sci: Remove platform data mapbase and irqs fields
  serial: sh-sci: Add device tree bindings documentation

 .../bindings/serial/renesas,sci-serial.txt         |  46 ++++
 arch/arm/mach-shmobile/setup-r7s72100.c            |  63 +++---
 arch/arm/mach-shmobile/setup-r8a73a4.c             |  65 +++---
 arch/arm/mach-shmobile/setup-r8a7740.c             | 196 +++--------------
 arch/arm/mach-shmobile/setup-r8a7778.c             |  45 ++--
 arch/arm/mach-shmobile/setup-r8a7779.c             | 129 +++--------
 arch/arm/mach-shmobile/setup-r8a7790.c             | 117 +++++-----
 arch/arm/mach-shmobile/setup-r8a7791.c             | 130 +++++------
 arch/arm/mach-shmobile/setup-sh7372.c              | 161 +++-----------
 arch/arm/mach-shmobile/setup-sh73a0.c              | 192 +++--------------
 arch/sh/kernel/cpu/sh2/setup-sh7619.c              |  27 ++-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c                |   9 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c             |  72 +++++--
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c             |  36 +++-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c             |  36 +++-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c             |  96 +++++++--
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c             |  96 +++++++--
 arch/sh/kernel/cpu/sh3/setup-sh7705.c              |  18 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c              |  27 ++-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c              |  18 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c              |  18 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c             |  15 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c              |  18 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c              |  58 +++--
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c             |  36 +++-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c             |   9 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c             |  27 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c             |  54 +++--
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c             |  54 +++--
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c             |  66 ++++--
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c             |  27 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c             |  27 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c             |  90 ++++++--
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c             |  18 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c             |  54 +++--
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c             |  82 +++++--
 arch/sh/kernel/cpu/sh4a/setup-shx3.c               |  45 ++--
 arch/sh/kernel/cpu/sh5/setup-sh5.c                 |  11 +-
 drivers/tty/serial/sh-sci.c                        | 238 ++++++++++++++++-----
 include/linux/serial_sci.h                         |  35 +--
 40 files changed, 1447 insertions(+), 1114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt

-- 
Regards,

Laurent Pinchart

