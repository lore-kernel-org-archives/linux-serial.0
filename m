From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 29/79] jsm: print byte we are dequeing
Date: Wed, 26 Oct 2011 14:12:34 +0200
Message-ID: <1319631204-23262-29-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60989 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932866Ab1JZMNk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:40 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

Instead of printing the head of the buffer, we should print the tail,
which is the byte we are sending to the device.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/jsm/jsm_neo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index bd6e846..81dfafa 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -522,7 +522,7 @@ static void neo_copy_data_from_queue_to_uart(struct jsm_channel *ch)
 
 			writeb(circ->buf[circ->tail], &ch->ch_neo_uart->txrx);
 			jsm_printk(WRITE, INFO, &ch->ch_bd->pci_dev,
-					"Tx data: %x\n", circ->buf[circ->head]);
+					"Tx data: %x\n", circ->buf[circ->tail]);
 			circ->tail = (circ->tail + 1) & (UART_XMIT_SIZE - 1);
 			ch->ch_txcount++;
 		}
-- 
1.7.7

