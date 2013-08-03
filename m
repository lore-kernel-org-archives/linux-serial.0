From: Huang Shijie <shijie8@gmail.com>
Subject: [PATCH v3 0/3] serial: mxs-auart: add RTS/CTS check for DMA support
Date: Sat,  3 Aug 2013 10:09:13 -0400
Message-ID: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35305 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab3HCCFA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Aug 2013 22:05:00 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so1278291pab.15
        for <linux-serial@vger.kernel.org>; Fri, 02 Aug 2013 19:04:59 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Huang Shijie <shijie8@gmail.com>

The original DMA support works only when RTS/CTS is enabled.
(see the "e800163 serial: mxs-auart: add the DMA support for mx28")
But after several patches, DMA support has lost this limit.
(see the "bcc20f9 serial: mxs-auart: move to use generic DMA helper")

So a UART without the RTS/CTS lines may also enables the DMA support
for it, but it may does not work or works abnormally (since without the
RTS/CTS signals, the TX/RX may not works)		

This patch set remove the unnecessary macro MXS_AUART_DMA_CONFIG,
and adds an optional property "fsl,uart-has-rtscts" for the UART DT node
which indicates the UART has RTS and CTS lines.

This patch set also adds a macro MXS_AUART_RTSCTS, and uses it to check
RTS/CTS before we enable the DMA for the UART.

At last, enable the DMA support for auart0 in the imx28-evk boards.

v2 --> v3:
	[0] make the patch 2 as the first patch.
	[1] add more comments.

v1 --> v2:
	[0] changed the comments.
	[1] fix the typos.

Huang Shijie (3):
  serial: mxs: enable the DMA only when the RTS/CTS is valid
  serial: mxs: remove the MXS_AUART_DMA_CONFIG
  ARM: dts: imx28-evk: add the RTS/CTS property for auart0

 .../bindings/tty/serial/fsl-mxs-auart.txt          |    4 ++++
 arch/arm/boot/dts/imx28-evk.dts                    |    1 +
 drivers/tty/serial/mxs-auart.c                     |    8 +++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
1.7.4.4

