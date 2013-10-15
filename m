From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5] serial: sa1100: delete .set_wake callback
Date: Tue, 15 Oct 2013 09:20:26 +0200
Message-ID: <1381821626-19441-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:49027 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3JOHUc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 03:20:32 -0400
Received: by mail-we0-f179.google.com with SMTP id w61so7951033wes.38
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2013 00:20:31 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>

This callback is unused by the serial core since pre-git days
and is not coming back. Delete it. Enabling wakeup on the
SA1100 platforms should be done in the suspend() callback
so the platform hook is left in the serial port struct for
later enablement.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/sa1100.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index ba25722..753d452 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -647,7 +647,10 @@ void sa1100_register_uart_fns(struct sa1100_port_fns *fns)
 		sa1100_pops.set_mctrl = fns->set_mctrl;
 
 	sa1100_pops.pm       = fns->pm;
-	sa1100_pops.set_wake = fns->set_wake;
+	/*
+	 * FIXME: fns->set_wake is unused - this should be called from
+	 * the suspend() callback if device_may_wakeup(dev)) is set.
+	 */
 }
 
 void __init sa1100_register_uart(int idx, int port)
-- 
1.8.3.1

