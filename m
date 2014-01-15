From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v3 0/2] serial: fsl_lpuart: add DMA support
Date: Wed, 15 Jan 2014 13:24:46 +0800
Message-ID: <1389763488-27361-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:43990
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751199AbaAOGWS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jan 2014 01:22:18 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org
Cc: linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Changed in v3:
- Use the streaming DMA API for receive.
- Add the macro(SERIAL_FSL_LPUART_DMA) and dts node propertie for whether using the dma.
- Adjust some coding style.

Changed in v2:
- Add eDMA support for lpuart receive.
- Use dma_mapping_error test dma_map_single.
- Change some names of variable.
- Fix some bugs.
 
 Added in v1:
 - Add device tree bindings for lupart eDMA support.
 - Add eDMA support for lpuart send.


