From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH 0/2] serial: fsl_lpuart: add eDMA support
Date: Thu, 9 Jan 2014 11:04:39 +0800
Message-ID: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:5462
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585AbaAIEAu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Jan 2014 23:00:50 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org
Cc: linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org


Changed in v2:
- Add eDMA support for lpuart receive.
- Use dma_map_single in a right way.
- Use dma_mapping_error test dma_map_single.
- Change some names of variable.
- Fix some bugs.

Added in v1:
- Add device tree bindings for lupart eDMA support.
- Add eDMA support for lpuart send.


