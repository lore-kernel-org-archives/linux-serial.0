From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] drivers/tty/serial: avoid double free after call ioc4_serial_remove_one
Date: Wed, 26 Dec 2012 18:06:39 +0800
Message-ID: <50DACC2F.5080302@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:48355 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab2LZKFt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Dec 2012 05:05:49 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org


  before goto out5,  soft, control, serial are all assigned to idd
  after finish call ioc4_serial_remove_one, all resources are released
  we need return instead of go on, or double free

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/tty/serial/ioc4_serial.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index 3e7da10..c4e30b8 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -2883,6 +2883,7 @@ ioc4_serial_attach_one(struct ioc4_driver_data *idd)
 	/* error exits that give back resources */
 out5:
 	ioc4_serial_remove_one(idd);
+	return ret;
 out4:
 	kfree(soft);
 out3:
-- 
1.7.10.4
