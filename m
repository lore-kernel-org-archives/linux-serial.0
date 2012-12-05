From: Matt Schulte <matts_old@commtech-fastcom.com>
Subject: [PATCH 1/2] pbn_b0_8_1152000_200 is supposed to be an 8 port definition
Date: Wed,  5 Dec 2012 14:56:21 -0600
Message-ID: <1354740983-4352-1-git-send-email-matts@commtech-fastcom.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48996 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab2LEU7e (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Dec 2012 15:59:34 -0500
Received: by mail-gg0-f174.google.com with SMTP id k2so897874ggd.19
        for <linux-serial@vger.kernel.org>; Wed, 05 Dec 2012 12:59:33 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, Matt Schulte <matts@commtech-fastcom.com>

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: b0ab02361167faa82198b783a8d555eb6f58901c

 drivers/tty/serial/8250/8250_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 26b9dc0..bf2f1a0 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2246,7 +2246,7 @@ static struct pciserial_board pci_boards[] = {
 
 	[pbn_b0_8_1152000_200] = {
 		.flags		= FL_BASE0,
-		.num_ports	= 2,
+		.num_ports	= 8,
 		.base_baud	= 1152000,
 		.uart_offset	= 0x200,
 	},
-- 
1.7.2.5

