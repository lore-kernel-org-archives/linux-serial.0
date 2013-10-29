From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/5] Add OF support to the sh-sci serial port driver
Date: Tue, 29 Oct 2013 11:29:54 +0100
Message-ID: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:34716 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab3J2K3i (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Oct 2013 06:29:38 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, devicetree@vger.kernel.org

Hello,

This patch set adds device tree bindings for the sh sci serial port devices
and adds OF parsing to the sh-sci driver.

The bindings are based on Bastian Hecht's proposal (see
http://www.spinics.net/lists/arm-kernel/msg228129.html). The approach taken
here is more minimalistic: instead of describing all hardware characteristics
that vary between the SCI device revisions in DT (such as registers layout),
that information is stored in the driver and selected based on the compatible
property value. Only SCI revisions used on ARM devices are supported through
DT, as DT support for SuperH is nowhere down the line.

The first three patches clean up the sh-sci driver. They're not strictly
required for OF support but make sense nonetheless. The last two patches add
OF parsing to the sh-sci driver and create DT bindings documentation.

The patches have been test on a Lager board (r8a7790-based). Support for other
SoCs will be added as needed. Note that all current Renesas ARM SoCs seem to
be compatible with the generic (H)SCI(F)(AB) devices, but the plan is for
their DT bindings to list the SoC-specific version in case incompatibilities
are found later.

Cc: devicetree@vger.kernel.org

Bastian Hecht (1):
  serial: sh-sci: Add OF support

Laurent Pinchart (4):
  serial: sh-sci: Sort headers alphabetically
  serial: sh-sci: Remove baud rate calculation algorithm 5
  serial: sh-sci: Simplify baud rate calculation algorithms
  serial: sh-sci: Add device tree bindings documentation

 .../bindings/serial/renesas,sci-serial.txt         |  51 ++++++
 drivers/tty/serial/sh-sci.c                        | 192 +++++++++++++++++----
 include/linux/serial_sci.h                         |   9 +-
 3 files changed, 217 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt

-- 
Regards,

Laurent Pinchart

