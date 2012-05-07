From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND 0/9] Enable pinctrl support for mach-mxs
Date: Mon,  7 May 2012 09:16:05 +0800
Message-ID: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44353 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab2EGBQT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 May 2012 21:16:19 -0400
Received: by dady13 with SMTP id y13so606413dad.19
        for <linux-serial@vger.kernel.org>; Sun, 06 May 2012 18:16:19 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawn.guo@linaro.org>, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, linux-mtd@lists.infradead.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[Resend to have subsystem lists Cc-ed]

With pinctrl-mxs driver (DT only) applied on pinctrl tree, the mxs
device tree conversion can start basing on that support.  This series
adopts pinctrl support for mxs device drivers with a dummy pinctrl
state provided for non-DT boot, so that the pinctrl call in the device
drivers will be bypassed for non-DT probe while it starts working for
DT probe.

To ease the merge process, I would like to ask Arnd and Olof to pull
pinctrl tree as a dependency in arm-soc and have this series go through
arm-soc.

Regards,
Shawn

Shawn Guo (9):
  ARM: mxs: enable pinctrl dummy states
  serial: amba-pl011: adopt pinctrl support
  serial: mxs-auart: adopt pinctrl support
  mmc: mxs-mmc: adopt pinctrl support
  mtd: nand: gpmi: adopt pinctrl support
  i2c: mxs: adopt pinctrl support
  ASoC: mxs-saif: adopt pinctrl support
  video: mxsfb: adopt pinctrl support
  ARM: mxs: enable pinctrl support

 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-mxs/Kconfig               |    2 ++
 arch/arm/mach-mxs/include/mach/common.h |    2 ++
 arch/arm/mach-mxs/mach-apx4devkit.c     |    2 ++
 arch/arm/mach-mxs/mach-m28evk.c         |    2 ++
 arch/arm/mach-mxs/mach-mx23evk.c        |    2 ++
 arch/arm/mach-mxs/mach-mx28evk.c        |    2 ++
 arch/arm/mach-mxs/mach-stmp378x_devb.c  |    2 ++
 arch/arm/mach-mxs/mach-tx28.c           |    2 ++
 arch/arm/mach-mxs/mm.c                  |   11 +++++++++++
 drivers/i2c/busses/i2c-mxs.c            |    6 ++++++
 drivers/mmc/host/mxs-mmc.c              |    8 ++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c  |    9 +++++++++
 drivers/tty/serial/amba-pl011.c         |    8 ++++++++
 drivers/tty/serial/mxs-auart.c          |    8 ++++++++
 drivers/video/mxsfb.c                   |    9 +++++++++
 sound/soc/mxs/mxs-saif.c                |    8 ++++++++
 17 files changed, 84 insertions(+), 0 deletions(-)

-- 
1.7.5.4

