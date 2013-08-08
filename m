From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 02/10] serial: 8250_early: fix comparison of different types
Date: Thu, 08 Aug 2013 17:32:04 +0900
Message-ID: <005d01ce9411$c32b6900$49823b00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:15668 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab3HHIcG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 04:32:06 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR7004W6EBTW3D0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 08 Aug 2013 17:32:05 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Henrik Nordstrom' <henrik@henriknordstrom.net>, Jingoo Han <jg1.han@samsung.com>

Fix the following sparse warning:

drivers/tty/serial/8250/8250_early.c:196:26: error: incompatible types in comparison expression (different type sizes)

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/8250/8250_early.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 946ddd2..c100d63 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -194,7 +194,7 @@ static int __init parse_options(struct early_serial8250_device *device,
 		options++;
 		device->baud = simple_strtoul(options, NULL, 0);
 		length = min(strcspn(options, " ") + 1,
-			     sizeof(device->options));
+			     (size_t)(sizeof(device->options)));
 		strlcpy(device->options, options, length);
 	} else {
 		device->baud = probe_baud(port);
-- 
1.7.10.4


