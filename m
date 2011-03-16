From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 55/76] pch_uart: add spin_lock_init
Date: Wed, 16 Mar 2011 14:12:25 -0700
Message-ID: <1300309966-5745-55-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32981 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936Ab1CPVOy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:54 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Currently, spin_lock is not initialized.
Thus, add spin_lock_init().

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/pch_uart.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index c1386eb..9e1b865 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1370,6 +1370,8 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	priv->port.line = num++;
 	priv->trigger = PCH_UART_HAL_TRIGGER_M;
 
+	spin_lock_init(&priv->port.lock);
+
 	pci_set_drvdata(pdev, priv);
 	pch_uart_hal_request(pdev, fifosize, base_baud);
 
-- 
1.7.4.1

