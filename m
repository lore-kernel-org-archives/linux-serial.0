From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC] tty: serial: OMAP: Pass the uart device instead of NULL
Date: Wed, 11 Jul 2012 17:57:22 +0530
Message-ID: <1342009642-5060-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35833 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621Ab2GKM1h (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Jul 2012 08:27:37 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Currently the dma_alloc passes NULL instead of the uart device.
Fix the same by passing the device parameter.

Also fixes the below warn.

[ 8613.094604] omap_uart omap_uart.0: DMA-API: device driver tries to free DMA memory it has not allocated [device address=0x0000]
[ 8613.109374] Modules linked in:
[ 8613.112640] [<c001b79c>] (unwind_backtrace+0x0/0xf0) from [<c0040934>] (warn_slowpath_common+0x4c/0x64)
[ 8613.122497] [<c0040934>] (warn_slowpath_common+0x4c/0x64) from [<c00409e0>] (warn_slowpath_fmt+0x30/0x40)
[ 8613.132537] [<c00409e0>] (warn_slowpath_fmt+0x30/0x40) from [<c0281230>] (check_unmap+0x6c8/0x7a8)
[ 8613.141937] [<c0281230>] (check_unmap+0x6c8/0x7a8) from [<c0281368>] (debug_dma_free_coherent+0x58/0x64)
[ 8613.151916] [<c0281368>] (debug_dma_free_coherent+0x58/0x64) from [<c02cafb8>] (serial_omap_shutdown+0x1d0/0x28c)
[ 8613.162689] [<c02cafb8>] (serial_omap_shutdown+0x1d0/0x28c) from [<c02c314c>] (uart_suspend_port+0x294/0x2bc)
[ 8613.173095] [<c02c314c>] (uart_suspend_port+0x294/0x2bc) from [<c02c7fec>] (serial_omap_suspend+0x1c/0x30)
[ 8613.183227] [<c02c7fec>] (serial_omap_suspend+0x1c/0x30) from [<c02d391c>] (platform_pm_suspend+0x2c/0x5c)
[ 8613.193389] [<c02d391c>] (platform_pm_suspend+0x2c/0x5c) from [<c02d7744>] (dpm_run_callback.clone.7+0x30/0xb0)
[ 8613.203979] [<c02d7744>] (dpm_run_callback.clone.7+0x30/0xb0) from [<c02d8238>] (__device_suspend+0x124/0x260)
[ 8613.214477] [<c02d8238>] (__device_suspend+0x124/0x260) from [<c02d8c0c>] (dpm_suspend+0x5c/0x218)
[ 8613.223907] [<c02d8c0c>] (dpm_suspend+0x5c/0x218) from [<c0080638>] (suspend_devices_and_enter+0x78/0x2d0)
[ 8613.234039] [<c0080638>] (suspend_devices_and_enter+0x78/0x2d0) from [<c0080a1c>] (pm_suspend+0x18c/0x208)
[ 8613.244171] [<c0080a1c>] (pm_suspend+0x18c/0x208) from [<c007fcc0>] (state_store+0x120/0x134)
[ 8613.253143] [<c007fcc0>] (state_store+0x120/0x134) from [<c0263ecc>] (kobj_attr_store+0x14/0x20)
[ 8613.262359] [<c0263ecc>] (kobj_attr_store+0x14/0x20) from [<c016a77c>] (sysfs_write_file+0x100/0x184)
[ 8613.272064] [<c016a77c>] (sysfs_write_file+0x100/0x184) from [<c0109b84>] (vfs_write+0xb4/0x148)
[ 8613.281280] [<c0109b84>] (vfs_write+0xb4/0x148) from [<c0109e0c>] (sys_write+0x40/0x70)
[ 8613.289703] [<c0109e0c>] (sys_write+0x40/0x70) from [<c0013ee0>] (ret_fast_syscall+0x0/0x3c)
[ 8613.298553] ---[ end trace e9beb8b35111c507 ]---

While at it also set the coherent mask.
Otherwise we get warnings like.
omap_uart omap_uart.0: coherent DMA mask is unset

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Boot tested on omap4

 drivers/tty/serial/omap-serial.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d3cda0c..df1ab2f 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -574,18 +574,20 @@ static int serial_omap_startup(struct uart_port *port)
 
 	up->msr_saved_flags = 0;
 	if (up->use_dma) {
+		dma_set_coherent_mask(up->port.dev, DMA_BIT_MASK(32));
 		free_page((unsigned long)up->port.state->xmit.buf);
-		up->port.state->xmit.buf = dma_alloc_coherent(NULL,
+		up->port.state->xmit.buf = dma_alloc_coherent(up->port.dev,
 			UART_XMIT_SIZE,
 			(dma_addr_t *)&(up->uart_dma.tx_buf_dma_phys),
-			0);
+			GFP_KERNEL);
 		init_timer(&(up->uart_dma.rx_timer));
 		up->uart_dma.rx_timer.function = serial_omap_rxdma_poll;
 		up->uart_dma.rx_timer.data = up->port.line;
 		/* Currently the buffer size is 4KB. Can increase it */
-		up->uart_dma.rx_buf = dma_alloc_coherent(NULL,
+		up->uart_dma.rx_buf = dma_alloc_coherent(up->port.dev,
 			up->uart_dma.rx_buf_size,
-			(dma_addr_t *)&(up->uart_dma.rx_buf_dma_phys), 0);
+			(dma_addr_t *)&(up->uart_dma.rx_buf_dma_phys),
+			GFP_KERNEL);
 	}
 	/*
 	 * Finally, enable interrupts. Note: Modem status interrupts
-- 
1.7.5.4

