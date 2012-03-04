From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: [PATCH 3/9] tty: make hci_uart_tty_receive return bytes received
Date: Sun,  4 Mar 2012 18:59:14 +0100
Message-ID: <1330883960-8563-4-git-send-email-castet.matthieu@free.fr>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44684 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab2CDR77 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 12:59:59 -0500
Received: by wibhm2 with SMTP id hm2so1507636wib.19
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 09:59:58 -0800 (PST)
In-Reply-To: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
---
 drivers/bluetooth/hci_ldisc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 47b97a8..588656e 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -369,7 +369,7 @@ static int hci_uart_tty_receive(struct tty_struct *tty,
 		return count;
 
 	spin_lock(&hu->rx_lock);
-	hu->proto->recv(hu, (void *) data, count);
+	count = hu->proto->recv(hu, (void *) data, count);
 	hu->hdev->stat.byte_rx += count;
 	spin_unlock(&hu->rx_lock);
 
-- 
1.7.9.1

