From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: [PATCH 3/3] jsm: print byte we are dequeing
Date: Wed, 24 Aug 2011 13:14:23 -0300
Message-ID: <1314202463-12297-3-git-send-email-cascardo@linux.vnet.ibm.com>
References: <1314202463-12297-1-git-send-email-cascardo@linux.vnet.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:33146 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab1HXQOw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Aug 2011 12:14:52 -0400
Received: from /spool/local
	by br.ibm.com with XMail ESMTP
	for <linux-serial@vger.kernel.org> from <cascardo@linux.vnet.ibm.com>;
	Wed, 24 Aug 2011 13:14:50 -0300
In-Reply-To: <1314202463-12297-1-git-send-email-cascardo@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Breno Leitao <leitao@linux.vnet.ibm.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

Instead of printing the head of the buffer, we should print the tail,
which is the byte we are sending to the device.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
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
1.7.4.4

