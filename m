From: Alan Cox <alan@redhat.com>
Subject: [PATCH 09/27] Blackfin Serial Driver: Remove useless stop
Date: Fri, 10 Oct 2008 11:48:57 +0100
Message-ID: <20081010104853.31597.37963.stgit@localhost.localdomain>
References: <20081010103447.31597.42992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47553 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758713AbYJJKtB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2008 06:49:01 -0400
In-Reply-To: <20081010103447.31597.42992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/bfin_5xx.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 382fb8d..8d2d757 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -320,9 +320,6 @@ static void bfin_serial_tx_chars(struct bfin_serial_port *uart)
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&uart->port);
-
-	if (uart_circ_empty(xmit))
-		bfin_serial_stop_tx(&uart->port);
 }
 
 static irqreturn_t bfin_serial_rx_int(int irq, void *dev_id)

