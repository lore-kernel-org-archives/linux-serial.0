Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="wzjDlURU"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB581B3;
	Wed, 22 Nov 2023 10:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=mogw1+ONtpkAQfXqFiiZf+Z9HRH49163oXyjFNr/5SM=; b=wzjDlURU69dbRv1uUWnq8LJdpP
	fUFWW3JseNpffxI/31xEbHCDGCMBv2WMsUX40JeS/t6QOhNHthjcAa6KIcK5X11kykR/ColpoaQFJ
	x08OjrJPT8ZWIJTBAZQ2cuzRetruPrce6HTCaar8NG5t80vLeIbGdkpEPg3ySpiX1+lQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50830 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r5rW2-00015P-MR; Wed, 22 Nov 2023 12:59:59 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Date: Wed, 22 Nov 2023 12:59:56 -0500
Message-Id: <20231122175957.3875102-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: [PATCH] serial: max310x: change confusing comment about Tx FIFO
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The comment wording can be confusing, as txlen will return the number of
bytes available in the FIFO, which can be less than the maximum theoretical
Tx FIFO size.

Change the comment so that it is unambiguous.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 97e4965b73d4..f3a99daebdaa 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -780,7 +780,7 @@ static void max310x_handle_tx(struct uart_port *port)
 	to_send = uart_circ_chars_pending(xmit);
 	until_end = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 	if (likely(to_send)) {
-		/* Limit to size of TX FIFO */
+		/* Limit to space available in TX FIFO */
 		txlen = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
 		txlen = port->fifosize - txlen;
 		to_send = (to_send > txlen) ? txlen : to_send;

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.39.2

