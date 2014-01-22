From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
Date: Wed, 22 Jan 2014 12:09:30 +0800
Message-ID: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:55466
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795AbaAVFIR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Jan 2014 00:08:17 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org
Cc: linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Changed in v4:
- Move dma properties from dtsi to dts.
- Cancle the macro(SERIAL_FSL_LPUART_DMA)  .
- Separate the document for clocks which undocumented before into a single patch.
- Change some explanations in document(clocks, clock-names, dmas, dma-names).
- Change "lpuart-tx" and "lpuart-rx" to "tx" and "rx".

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


