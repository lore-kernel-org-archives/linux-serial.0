From: Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] serial: 8250: Remove trailing space in 8250 driver
Date: Tue, 17 Jan 2012 10:56:01 -0800
Message-ID: <1326826563-32215-1-git-send-email-sjg@chromium.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f202.google.com ([209.85.160.202]:36817 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab2AQS4N (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jan 2012 13:56:13 -0500
Received: by ghbg20 with SMTP id g20so332826ghb.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2012 10:56:13 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Simon Glass <sjg@chromium.org>

Trivial change to remove a trailing space.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
 drivers/tty/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 9f50c4e..54f8920 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -865,7 +865,7 @@ static int broken_efr(struct uart_8250_port *up)
 	/*
 	 * Exar ST16C2550 "A2" devices incorrectly detect as
 	 * having an EFR, and report an ID of 0x0201.  See
-	 * http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-11/4812.html 
+	 * http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-11/4812.html
 	 */
 	if (autoconfig_read_divisor_id(up) == 0x0201 && size_fifo(up) == 16)
 		return 1;
-- 
1.7.7.3

