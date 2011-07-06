From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND v3 0/2] Add device tree probe support for tty/serial/imx
Date: Thu, 7 Jul 2011 01:20:18 +0800
Message-ID: <1309972820-18547-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:45877
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752897Ab1GFRWJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Jul 2011 13:22:09 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

The first patch removes the use of cpu_is_mx1().  The second patch
adds device tree probe with a dependency on the following patch.

  http://article.gmane.org/gmane.linux.drivers.devicetree/6128

Changes with resend:
 * Fix typo
 * Change a few macros to inline functions

Changes since v2:
 * Not use generic naming imx-uart, instead use specific soc name
   to show uart type compatibility (Sascha's suggestion)

Changes since v1:
 * Address review comments given by Grant and Uwe

Shawn Guo (2):
      serial/imx: get rid of the uses of cpu_is_mx1()
      serial/imx: add device tree probe support

 .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++
 arch/arm/mach-imx/clock-imx1.c                     |    6 +-
 arch/arm/mach-imx/clock-imx21.c                    |    8 +-
 arch/arm/mach-imx/clock-imx25.c                    |   11 +-
 arch/arm/mach-imx/clock-imx27.c                    |   13 +-
 arch/arm/mach-imx/clock-imx31.c                    |   11 +-
 arch/arm/mach-imx/clock-imx35.c                    |    7 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   18 ++-
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |    7 +-
 drivers/tty/serial/imx.c                           |  167 +++++++++++++++++---
 10 files changed, 205 insertions(+), 62 deletions(-)

