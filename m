From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Subject: [PATCH 13/18] driver: tty: serial: remove cast for kzalloc return
 value
Date: Tue, 12 Mar 2013 13:27:29 +0800
Message-ID: <513EBCC1.80906@cn.fujitsu.com>
References: <513EB23D.7020303@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:32301 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753933Ab3CLF3D (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Mar 2013 01:29:03 -0400
In-Reply-To: <513EB23D.7020303@cn.fujitsu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

remove cast for kzalloc return value.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/icom.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index bc9e6b0..18ed5ae 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1415,8 +1415,7 @@ static int icom_alloc_adapter(struct icom_adapter
 	struct icom_adapter *cur_adapter_entry;
 	struct list_head *tmp;
 
-	icom_adapter = (struct icom_adapter *)
-	    kzalloc(sizeof(struct icom_adapter), GFP_KERNEL);
+	icom_adapter = kzalloc(sizeof(struct icom_adapter), GFP_KERNEL);
 
 	if (!icom_adapter) {
 		return -ENOMEM;
-- 
1.7.1

