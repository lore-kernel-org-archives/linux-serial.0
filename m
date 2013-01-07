From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH 2/2] Fix incorrect num_ports on pbn_b0_8_1152000_200 boards structure.
Date: Mon,  7 Jan 2013 15:17:15 -0600
Message-ID: <1357593435-3566-2-git-send-email-matts@commtech-fastcom.com>
References: <1357593435-3566-1-git-send-email-matts@commtech-fastcom.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ye0-f172.google.com ([209.85.213.172]:45075 "EHLO
	mail-ye0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab3AGVvi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 16:51:38 -0500
Received: by mail-ye0-f172.google.com with SMTP id m10so3128371yen.17
        for <linux-serial@vger.kernel.org>; Mon, 07 Jan 2013 13:51:37 -0800 (PST)
In-Reply-To: <1357593435-3566-1-git-send-email-matts@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Matt Schulte <matts@commtech-fastcom.com>


Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
 drivers/tty/serial/8250/8250_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 18f1d79..c8ec5fc 100644
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

