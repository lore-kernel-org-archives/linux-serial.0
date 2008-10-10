From: Alan Cox <alan@redhat.com>
Subject: [PATCH 22/27] serial: Make uart_port's ioport "unsigned long".
Date: Fri, 10 Oct 2008 11:50:56 +0100
Message-ID: <20081010105052.31597.41476.stgit@localhost.localdomain>
References: <20081010103447.31597.42992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47605 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759624AbYJJKu7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2008 06:50:59 -0400
In-Reply-To: <20081010103447.31597.42992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

From: David Miller <davem@davemloft.net>

Otherwise the top 32-bits of the resource value get chopped
off on 64-bit systems, and the resulting I/O accesses go to
random places.

Thanks to testing and debugging by Josip Rodin, which helped
track this down.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 include/linux/serial_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3b2f6c0..e27f216 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -241,7 +241,7 @@ typedef unsigned int __bitwise__ upf_t;
 
 struct uart_port {
 	spinlock_t		lock;			/* port lock */
-	unsigned int		iobase;			/* in/out[bwl] */
+	unsigned long		iobase;			/* in/out[bwl] */
 	unsigned char __iomem	*membase;		/* read/write[bwl] */
 	unsigned int		irq;			/* irq number */
 	unsigned int		uartclk;		/* base uart clock */

