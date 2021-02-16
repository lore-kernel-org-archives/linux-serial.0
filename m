Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A9C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 16 Feb 2021 15:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7ED564E07
	for <linux-serial@archiver.kernel.org>; Tue, 16 Feb 2021 15:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBPO7r (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhBPO7p (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Feb 2021 09:59:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D200464E04;
        Tue, 16 Feb 2021 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613487545;
        bh=FFjQkSWfLHAHFzmT+m4+bHCqYWL2XWupRvA3pBa4aq0=;
        h=From:To:Cc:Subject:Date:From;
        b=0iHhT+6e9Mau/XcUgxufFJYoVva8T/S8EXRQ7D6y5dbUudHFrC7hSH/oPEaHd5nhu
         +IHc5Do2jrc5PKTI2bn/x1p+9EkEz95LntrFZMRJVmifKbAYGOHrtAT7Nhn495BlqP
         6YaltMNilL4AseRp+LV6sP7BaRGOd9eYK+2o2rrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty: serial: pch_uart.c: remove debugfs dentry pointer
Date:   Tue, 16 Feb 2021 15:59:00 +0100
Message-Id: <20210216145900.3835160-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

No need to keep around the dentry pointer for the debugfs file if all it
is used for is to remove it when we are wanting to clean up, as the
pointer can be looked up directly from debugfs instead.

This also removes pointless #ifdef CONFIG_DEBUG_FS brackets as the
compiler is smart enough to handle this properly if debugfs is disabled
without us having to worry about it.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/pch_uart.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index a7363bc66c11..e9e79d181f0e 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -236,7 +236,6 @@ struct eg20t_port {
 	void				*rx_buf_virt;
 	dma_addr_t			rx_buf_dma;
 
-	struct dentry	*debugfs;
 #define IRQ_NAME_SIZE 17
 	char				irq_name[IRQ_NAME_SIZE];
 
@@ -1735,9 +1734,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	int fifosize;
 	int port_type;
 	struct pch_uart_driver_data *board;
-#ifdef CONFIG_DEBUG_FS
-	char name[32];	/* for debugfs file name */
-#endif
+	char name[32];
 
 	board = &drv_dat[id->driver_data];
 	port_type = board->port_type;
@@ -1813,11 +1810,9 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	if (ret < 0)
 		goto init_port_hal_free;
 
-#ifdef CONFIG_DEBUG_FS
-	snprintf(name, sizeof(name), "uart%d_regs", board->line_no);
-	priv->debugfs = debugfs_create_file(name, S_IFREG | S_IRUGO,
-				NULL, priv, &port_regs_ops);
-#endif
+	snprintf(name, sizeof(name), "uart%d_regs", priv->port.line);
+	debugfs_create_file(name, S_IFREG | S_IRUGO, NULL, priv,
+			    &port_regs_ops);
 
 	return priv;
 
@@ -1835,10 +1830,10 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 
 static void pch_uart_exit_port(struct eg20t_port *priv)
 {
+	char name[32];
 
-#ifdef CONFIG_DEBUG_FS
-	debugfs_remove(priv->debugfs);
-#endif
+	snprintf(name, sizeof(name), "uart%d_regs", priv->port.line);
+	debugfs_remove(debugfs_lookup(name, NULL));
 	uart_remove_one_port(&pch_uart_driver, &priv->port);
 	free_page((unsigned long)priv->rxbuf.buf);
 }
-- 
2.30.1

