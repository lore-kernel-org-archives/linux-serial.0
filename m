From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v3 0/6] serial: imx: add DMA support for imx6
Date: Fri, 5 Jul 2013 14:12:26 +0800
Message-ID: <1373004752-21302-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:48011
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753718Ab3GEGjY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Jul 2013 02:39:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

(1) This patch set adds the DMA support for the imx serial driver.
    The uart with the dma support is usually used by the Bluetooth.

    For the firmware's limit, i only enable the DMA for imx6 serials.
    If we have proper firmware for imx53 (or other chips), we can also
    enable the DMA for it.

(2) We only enable the DMA support when the following are meet:

    [1] The uart port supports the hardware flow control(CTS/RTS).
      (Some uart port does not support the CTS/RTS.)

    [2] The application enables the CTS/RTS.

    [3] The Soc is imx6 serials.
      For the sdma's firmware limit, we do not support the DMA except
      the imx6 platform.

    [4] The uart is not used as a console.


(3) Tested this patch set by:
	connecting a imx6q-arm2 board(DTE) with a imx53 board(DCE).

v2 --> v3:
	[0] add a new patch to fix the RTS/CTS pad name issue.
	[1] rename the uart DTE pinctrl, remove the "dte" from the pinctrl.
	[2] add a similar UART DTE pinctrl for IMX6DL.
	[3] move the "fsl,imx6q-uart" to the first of the compatible table.

v1 --> v2:
	[0] use the "fsl,imx6q-uart" as the new compatible value.
	[1] move dma_is_inited to imx_uart_dma_init();
	    move dma_is_enabled to imx_enable_dma();
	[2] move imx_disable_dma() to the front place of the imx_shutdown(),
	    just before calls the imx_uart_dma_exit().
	[3] misc    
	

Huang Shijie (6):
  serial: imx: distinguish the imx6q uart from the others
  serial: imx: add DMA support for imx6q
  ARM: dts: imx6sl: add "fsl,imx6q-uart" for uart compatible
  ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad name
  ARM: dts: imx6q{dl}: add a DTE uart pinctrl for uart2
  ARM: dts: enable the uart2 for imx6q-arm2

 arch/arm/boot/dts/imx6dl-pinfunc.h |   88 ++++----
 arch/arm/boot/dts/imx6dl.dtsi      |    9 +
 arch/arm/boot/dts/imx6q-arm2.dts   |   10 +
 arch/arm/boot/dts/imx6q-pinfunc.h  |   88 ++++----
 arch/arm/boot/dts/imx6q.dtsi       |    9 +
 arch/arm/boot/dts/imx6sl.dtsi      |   15 +-
 drivers/tty/serial/imx.c           |  422 +++++++++++++++++++++++++++++++++++-
 7 files changed, 541 insertions(+), 100 deletions(-)


