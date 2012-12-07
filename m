From: matts_old@commtech-fastcom.com
Subject: [PATCHv2 1/2] tty/8250: pbn_b0_8_1152000_200 is supposed to be an 8 port definition
Date: Thu,  6 Dec 2012 22:19:58 -0600
Message-ID: <1354853999-6789-1-git-send-email-matts@commtech-fastcom.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ye0-f174.google.com ([209.85.213.174]:33414 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab2LGEWj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 23:22:39 -0500
Received: by mail-ye0-f174.google.com with SMTP id m6so16016yen.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Dec 2012 20:22:38 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, Matt Schulte <matts@commtech-fastcom.com>

From: Matt Schulte <matts@commtech-fastcom.com>

tty/8250: pbn_b0_8_1152000_200 is supposed to be an 8 port definition

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: b0ab02361167faa82198b783a8d555eb6f58901c

v2: Reorder define in patch 2 as requested by Alan

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

