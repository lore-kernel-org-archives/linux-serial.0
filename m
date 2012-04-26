From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 0/2] add DMA support to uart
Date: Thu, 26 Apr 2012 18:37:10 +0800
Message-ID: <1335436632-29499-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:46188
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755487Ab2DZKdc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2012 06:33:32 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, B20223@freescale.com, r58066@freescale.com, B20596@freescale.com, s.hauer@pengutronix.de, Huang Shijie <b32955@freescale.com>

Add DMA support to UART driver.

Tested this patch on imx6q(arm2) board with a new SDMA firmware.


Huang Shijie (2):
  serial/imx: add DMA support
  ARM: MX6q: enable DMA support for UART2

 .../bindings/tty/serial/fsl-imx-uart.txt           |    7 +
 arch/arm/boot/dts/imx6q-arm2.dts                   |    8 +
 drivers/tty/serial/imx.c                           |  386 +++++++++++++++++++-
 3 files changed, 397 insertions(+), 4 deletions(-)


