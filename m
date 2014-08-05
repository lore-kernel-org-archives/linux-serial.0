From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: [PATCH 5/5] tty: serial: msm: Fix 'void function return statements are not generally useful' warning
Date: Tue,  5 Aug 2014 13:22:03 +0530
Message-ID: <1407225124-25074-6-git-send-email-kiran.padwal@smartplayin.com>
References: <1407225124-25074-1-git-send-email-kiran.padwal@smartplayin.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp96.ord1c.emailsrvr.com ([108.166.43.96]:52746 "EHLO
	smtp96.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932401AbaHEH4d (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Aug 2014 03:56:33 -0400
In-Reply-To: <1407225124-25074-1-git-send-email-kiran.padwal@smartplayin.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: davidb@codeaurora.org
Cc: dwalker@fifo99.com, bryanh@codeaurora.org, sboyd@codeaurora.org, gregkh@linuxfoundation.org, jslaby@suse.cz, kiran.padwal@smartplayin.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

fixed below checkpatch.pl warning:

WARNING: void function return statements are not generally useful

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
 drivers/tty/serial/msm_serial.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index dfebbaf..26df038 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -787,8 +787,6 @@ static void msm_poll_put_char(struct uart_port *port, unsigned char c)
 
 	/* Enable interrupts */
 	msm_write(port, imr, UART_IMR);
-
-	return;
 }
 #endif
 
-- 
1.7.9.5

