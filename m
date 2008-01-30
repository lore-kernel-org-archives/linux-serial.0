From: Bryan Wu <bryan.wu@analog.com>
Subject: [PATCH 04/12] [Blackfin] serial driver: Fix bug Free rx dma buffer in shutdown.
Date: Wed, 30 Jan 2008 17:30:04 +0800
Message-ID: <1201685412-29095-5-git-send-email-bryan.wu@analog.com>
References: <1201685412-29095-1-git-send-email-bryan.wu@analog.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:40738 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbYA3JaR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2008 04:30:17 -0500
In-Reply-To: <1201685412-29095-1-git-send-email-bryan.wu@analog.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Bryan Wu <bryan.wu@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Kernel crash for the serial driver in DMA mode:
http://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_item_id=3679

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <bryan.wu@analog.com>
---
 drivers/serial/bfin_5xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 3a2aa7e..838f491 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -704,6 +704,7 @@ static void bfin_serial_shutdown(struct uart_port *port)
 	disable_dma(uart->rx_dma_channel);
 	free_dma(uart->rx_dma_channel);
 	del_timer(&(uart->rx_dma_timer));
+	dma_free_coherent(NULL, PAGE_SIZE, uart->rx_dma_buf.buf, 0);
 #else
 #ifdef	CONFIG_KGDB_UART
 	if (uart->port.line != CONFIG_KGDB_UART_PORT)
-- 
1.5.3.4
