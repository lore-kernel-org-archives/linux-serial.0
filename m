From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 0/3] serial: mxs-auart: add DMA support for auart in mx28
Date: Tue, 16 Oct 2012 14:03:03 +0800
Message-ID: <1350367386-7742-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:32640
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753958Ab2JPGff (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Oct 2012 02:35:35 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, lauri.hintsala@bluegiga.com, vinod.koul@intel.com, Huang Shijie <b32955@freescale.com>

This patch set adds the DMA support for auart in mx28.
patch 1:
	But in mx23, the DMA has a bug(see errata:2836). We can not add the
	DMA support in mx23, but we can add DMA support to auart in mx28.
	So in order to add the DMA support for the auart in mx28, we should add
	the platform_device_id to distinguish the distinguish SOCs.

patch 2: add the DMA support for mx28
	Only we meet the following conditions, we can enable the DMA support
	for auart:
        (1) We enable the DMA support in the dts file, such as
            arch/arm/boot/dts/imx28.dtsi.
        (2) We enable the hardware flow control.
        (3) We use the mx28, not the mx23. Due to hardware bug(see errata: 2836),
            we can not add the DMA support to mx23.

patch 3: enable the DMA support in dts for mx28 
	You can use the /ttyAPP0 to test this patch set. 
	I tested this patch in mx28-evk board.


Huang Shijie (3):
  serial: mxs-auart: distinguish the different SOCs
  serial: mxs-auart: add the DMA support for mx28
  ARM: dts: enable dma support for auart0 in mx28

 .../bindings/tty/serial/fsl-mxs-auart.txt          |    9 +-
 arch/arm/boot/dts/imx28.dtsi                       |   12 +-
 drivers/tty/serial/mxs-auart.c                     |  335 +++++++++++++++++++-
 3 files changed, 341 insertions(+), 15 deletions(-)


