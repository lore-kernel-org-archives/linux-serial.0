From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] serial8250: Sanity check nr_uarts on all paths.
Date: Fri, 11 Jul 2008 12:30:42 -0700
Message-ID: <m1wsjsdxr1.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:45599 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYGKTcG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jul 2008 15:32:06 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk+lkml@arm.linux.org.uk>, linux-serial@vger.kernel.org, Bryan Wu <cooloney@kernel.org>



I had 8250.nr_uarts=16 in the boot line of a test kernel and I had a
weird mysterious crash in sysfs.  After an taking in depth look I realized
that CONFIG_SERIAL_8250_NR_UARTS was set to 4 and I was walking off
the end of the serial8250_ports array.

Ouch!!!

Don't let this happen to someone else.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/serial/8250.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 1bc00b7..be95e55 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2623,6 +2623,9 @@ static struct console serial8250_console = {
 
 static int __init serial8250_console_init(void)
 {
+	if (nr_uarts > UART_NR)
+		nr_uarts = UART_NR;
+
 	serial8250_isa_init_ports();
 	register_console(&serial8250_console);
 	return 0;
-- 
1.5.3.rc6.17.g1911

