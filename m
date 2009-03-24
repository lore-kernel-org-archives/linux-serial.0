From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 09/30] blackfin: Explain why we cannot cpu_relax() in early
	serial code
Date: Tue, 24 Mar 2009 14:03:16 +0000
Message-ID: <20090324140313.12735.24344.stgit@localhost.localdomain>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48946 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758075AbZCXOCy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 10:02:54 -0400
In-Reply-To: <20090324135930.12735.7827.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

From: Mike Frysinger <vapier.adi@gmail.com>

Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

 drivers/serial/bfin_5xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index d46d764..c7c0c1b 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -1127,6 +1127,10 @@ static __init void early_serial_putc(struct uart_port *port, int ch)
 	unsigned timeout = 0xffff;
 	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
 
+	/* We cannot cpu_relax() here as doing so on the BF561 relies
+	 * on the per-cpu region being setup, and since this is early
+	 * serial code, it may not yet be usable ...
+	 */
 	while ((!(UART_GET_LSR(uart) & THRE)) && --timeout)
 		barrier();
 

