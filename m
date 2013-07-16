From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v2 0/3] serial: mxs-auart: add RTS/CTS check for DMA support
Date: Tue, 16 Jul 2013 14:55:29 +0800
Message-ID: <1373957732-16638-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:5775
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913Ab3GPHY7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Jul 2013 03:24:59 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Huang Shijie <b32955@freescale.com>

The original DMA support works only when RTS/CTS is enabled.
But after several patches, DMA support has lost this limit.
So a UART without the RTS/CTS lines may also enables the DMA support
for it, but it may does not work or works abnormally (since without the
RTS/CTS signals, the TX/RX may not works)		

This patch set remove the unnecessary macro MXS_AUART_DMA_CONFIG,
and adds an optional property "fsl,uart-has-rtscts" for the UART DT node
which indicates the UART has RTS and CTS lines.

This patch set also adds a macro MXS_AUART_RTSCTS, and uses it to check
RTS/CTS before we enable the DMA for the UART.

At last, enable the DMA support for auart0 in the imx28-evk boards.

v1 --> v2:
	[0] changed the comments.
	[1] fix the typos.

Huang Shijie (3):
  serial: mxs: remove the MXS_AUART_DMA_CONFIG
  serial: mxs: enable the DMA only when the RTS/CTS is valid
  ARM: dts: imx28-evk: add the RTS/CTS property for auart0

 .../bindings/tty/serial/fsl-mxs-auart.txt          |    4 ++++
 arch/arm/boot/dts/imx28-evk.dts                    |    1 +
 drivers/tty/serial/mxs-auart.c                     |    8 ++++----
 3 files changed, 9 insertions(+), 4 deletions(-)


