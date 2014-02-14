From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 0/3] serial: fsl_lpuart: add DMA support
Date: Fri, 14 Feb 2014 10:11:11 +0100
Message-ID: <2297536.ERjsbpLrzg@wuerfel>
References: <1392362839-8004-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62792 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaBNJMA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Feb 2014 04:12:00 -0500
In-Reply-To: <1392362839-8004-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, mark.rutland@arm.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Friday 14 February 2014 15:27:16 Yuan Yao wrote:
> Changed in v5:
> - Revoke move dma properties from dtsi to dts.
> - Change the explanations for dmas, dma-names in document.
> - Change the description for [PATCH 3] serial: fsl_lpuart: documented the clock requirement.

Whole series

Acked-by: Arnd Bergmann <arnd@arndb.de>

> Changed in v4:
> - Move dma properties from dtsi to dts.
> - Cancle the macro(SERIAL_FSL_LPUART_DMA)  .
> - Separate the document for clocks which undocumented before into a single patch.
> - Change some explanations in document(clocks, clock-names, dmas, dma-names).
> - Change "lpuart-tx" and "lpuart-rx" to "tx" and "rx".
> 
> Changed in v3:
> - Use the streaming DMA API for receive.
> - Add the macro(SERIAL_FSL_LPUART_DMA) and dts node propertie for whether using the dma.
> - Adjust some coding style.
> 
> Changed in v2:
> - Add eDMA support for lpuart receive.
> - Use dma_mapping_error test dma_map_single.
> - Change some names of variable.
> - Fix some bugs.
> 
> Added in v1:
> - Add device tree bindings for lupart eDMA support.
> - Add eDMA support for lpuart send.
> 

