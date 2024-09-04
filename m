Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90389146D54;
	Wed,  4 Sep 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435537; cv=none; b=HzxecAMNlIZYf3H6CxnhJ8YBqgbvCWXgKsVZr3d3KqSFfA4OuX6eMVADq3ivxESJ5tNEuUby5Nniq6EmUXQ/5LRm0322tnKn8vcZVKo0PEd8l1zCb6exPhmVovL1I8o3+0bOW0Jyar97jUbC8OqW7VyAIBk8T2vI0oxKLy50nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435537; c=relaxed/simple;
	bh=z++EeMTUVFxeUBjT8sx1xnif4BDfuTsQgwzKkIHmxAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bssgS8fSn2NZ6EDjo9l/4Sm5FC/5FHDz4pKGcuYNrfgBofhW0hoaoiC/5wdO36sbwHO0TUHDiWyogdYYD/wE8+EvTlHs58AIZDX9DAcgiOnWKmIyV7VIeW5f/NC0gmyB3W7pnftSA3CQEa46O8/9p8xP3vvdXsGSb4qj4AoRrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566d80e8aa99-e3a9c;
	Wed, 04 Sep 2024 15:38:50 +0800 (CST)
X-RM-TRANSID:2ee566d80e8aa99-e3a9c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766d80e89503-19a46;
	Wed, 04 Sep 2024 15:38:50 +0800 (CST)
X-RM-TRANSID:2ee766d80e89503-19a46
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] serial: pic32_uart: Use devm for kasprintf and request_irq
Date: Wed,  4 Sep 2024 13:53:53 +0800
Message-Id: <20240904055353.102273-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Use devm_kasprintf and devm_request_irq to simplify code.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/tty/serial/pic32_uart.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 261c8115a700..0119a4d81521 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -484,7 +484,7 @@ static int pic32_uart_startup(struct uart_port *port)
 	 */
 	sport->enable_tx_irq = false;
 
-	sport->irq_fault_name = kasprintf(GFP_KERNEL, "%s%d-fault",
+	sport->irq_fault_name = devm_kasprintf(port->dev, GFP_KERNEL, "%s%d-fault",
 					  pic32_uart_type(port),
 					  sport->idx);
 	if (!sport->irq_fault_name) {
@@ -493,49 +493,49 @@ static int pic32_uart_startup(struct uart_port *port)
 		goto out_disable_clk;
 	}
 	irq_set_status_flags(sport->irq_fault, IRQ_NOAUTOEN);
-	ret = request_irq(sport->irq_fault, pic32_uart_fault_interrupt,
+	ret = devm_request_irq(port->dev, sport->irq_fault, pic32_uart_fault_interrupt,
 			  IRQF_NO_THREAD, sport->irq_fault_name, port);
 	if (ret) {
 		dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
 			__func__, sport->irq_fault, ret,
 			pic32_uart_type(port));
-		goto out_f;
+		goto out_disable_clk;
 	}
 
-	sport->irq_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
+	sport->irq_rx_name = devm_kasprintf(port->dev, GFP_KERNEL, "%s%d-rx",
 				       pic32_uart_type(port),
 				       sport->idx);
 	if (!sport->irq_rx_name) {
 		dev_err(port->dev, "%s: kasprintf err!", __func__);
 		ret = -ENOMEM;
-		goto out_f;
+		goto out_disable_clk;
 	}
 	irq_set_status_flags(sport->irq_rx, IRQ_NOAUTOEN);
-	ret = request_irq(sport->irq_rx, pic32_uart_rx_interrupt,
+	ret = devm_request_irq(port->dev, sport->irq_rx, pic32_uart_rx_interrupt,
 			  IRQF_NO_THREAD, sport->irq_rx_name, port);
 	if (ret) {
 		dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
 			__func__, sport->irq_rx, ret,
 			pic32_uart_type(port));
-		goto out_r;
+		goto out_disable_clk;
 	}
 
-	sport->irq_tx_name = kasprintf(GFP_KERNEL, "%s%d-tx",
+	sport->irq_tx_name = devm_kasprintf(port->dev, GFP_KERNEL, "%s%d-tx",
 				       pic32_uart_type(port),
 				       sport->idx);
 	if (!sport->irq_tx_name) {
 		dev_err(port->dev, "%s: kasprintf err!", __func__);
 		ret = -ENOMEM;
-		goto out_r;
+		goto out_disable_clk;
 	}
 	irq_set_status_flags(sport->irq_tx, IRQ_NOAUTOEN);
-	ret = request_irq(sport->irq_tx, pic32_uart_tx_interrupt,
+	ret = devm_request_irq(port->dev, sport->irq_tx, pic32_uart_tx_interrupt,
 			  IRQF_NO_THREAD, sport->irq_tx_name, port);
 	if (ret) {
 		dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
 			__func__, sport->irq_tx, ret,
 			pic32_uart_type(port));
-		goto out_t;
+		goto out_disable_clk;
 	}
 
 	local_irq_save(flags);
@@ -557,15 +557,6 @@ static int pic32_uart_startup(struct uart_port *port)
 
 	return 0;
 
-out_t:
-	free_irq(sport->irq_tx, port);
-	kfree(sport->irq_tx_name);
-out_r:
-	free_irq(sport->irq_rx, port);
-	kfree(sport->irq_rx_name);
-out_f:
-	free_irq(sport->irq_fault, port);
-	kfree(sport->irq_fault_name);
 out_disable_clk:
 	clk_disable_unprepare(sport->clk);
 out_done:
-- 
2.33.0



