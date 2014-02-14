From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v5 0/3] serial: fsl_lpuart: add DMA support
Date: Fri, 14 Feb 2014 15:27:16 +0800
Message-ID: <1392362839-8004-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [207.46.163.25] ([207.46.163.25]:33903 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751788AbaBNIbc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Feb 2014 03:31:32 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org, mark.rutland@arm.com
Cc: linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org


Changed in v5:
- Revoke move dma properties from dtsi to dts.
- Change the explanations for dmas, dma-names in document.
- Change the description for [PATCH 3] serial: fsl_lpuart: documented the clock requirement.

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

