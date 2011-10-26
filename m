From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 62/79] TTY: snyclinkmp: forever loop in tx_load_dma_buffer()
Date: Wed, 26 Oct 2011 14:13:07 +0200
Message-ID: <1319631204-23262-62-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32841 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932948Ab1JZMN5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:57 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Dan Carpenter <dan.carpenter@oracle.com>

My main concern here was the line that said:
	copy_count = min_t(unsigned short,count,SCABUFSIZE);
"count" is an unsigned int here so the cast to unsigned short
truncates the upper bits.  So if count is 0x10000 then copy_count is
0 and the loop never exits.

"count" comes from skb->len in hdlcdev_xmit().

The other min_t() changes are just cleanups.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/synclinkmp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index c77831c..0f6b796 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -4950,7 +4950,7 @@ CheckAgain:
 
 	if ( debug_level >= DEBUG_LEVEL_DATA )
 		trace_block(info,info->rx_buf_list_ex[StartIndex].virt_addr,
-			min_t(int, framesize,SCABUFSIZE),0);
+			min_t(unsigned int, framesize, SCABUFSIZE), 0);
 
 	if (framesize) {
 		if (framesize > info->max_frame_size)
@@ -5015,14 +5015,14 @@ static void tx_load_dma_buffer(SLMP_INFO *info, const char *buf, unsigned int co
 	SCADESC_EX *desc_ex;
 
 	if ( debug_level >= DEBUG_LEVEL_DATA )
-		trace_block(info,buf, min_t(int, count,SCABUFSIZE), 1);
+		trace_block(info, buf, min_t(unsigned int, count, SCABUFSIZE), 1);
 
 	/* Copy source buffer to one or more DMA buffers, starting with
 	 * the first transmit dma buffer.
 	 */
 	for(i=0;;)
 	{
-		copy_count = min_t(unsigned short,count,SCABUFSIZE);
+		copy_count = min_t(unsigned int, count, SCABUFSIZE);
 
 		desc = &info->tx_buf_list[i];
 		desc_ex = &info->tx_buf_list_ex[i];
-- 
1.7.7

