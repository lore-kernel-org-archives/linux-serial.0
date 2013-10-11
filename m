From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 0/4] serail: imx: patches for DMA
Date: Fri, 11 Oct 2013 18:30:57 +0800
Message-ID: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:43908
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932469Ab3JKKpt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Oct 2013 06:45:49 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, Huang Shijie <b32955@freescale.com>

After i tested the DMA for uart with the Bluetooth. I found several small
places need to be fixed.

The patch set contains several fixes for the DMA support.

Huang Shijie (4):
  serial: imx: implement the flush_buffer hook
  serial: imx: check the DMA for imx_tx_empty
  serial: imx: fix the wrong number of scatterlist entries when
    xmit->head is 0
  serial: imx: use the dmaengine_tx_status

 drivers/tty/serial/imx.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

-- 
1.7.2.rc3


