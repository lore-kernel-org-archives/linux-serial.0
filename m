From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] serial/8250_gsc.c: add MODULE_LICENSE
Date: Mon, 5 May 2008 21:29:22 +0300
Message-ID: <20080505182922.GW17139@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:44994 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756483AbYEESa3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 May 2008 14:30:29 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

This patch adds the missing MODULE_LICENSE("GPL").

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Acked-by: Alan Cox <alan@redhat.com>

---

This patch has been sent on:
- 23 Apr 2008
- 14 Apr 2008

c0d845566182db3fc650dcfa35700f84e82bbae7 diff --git a/drivers/serial/8250_gsc.c b/drivers/serial/8250_gsc.c
index 4eb7437..0416ad3 100644
--- a/drivers/serial/8250_gsc.c
+++ b/drivers/serial/8250_gsc.c
@@ -119,3 +119,5 @@ int __init probe_serial_gsc(void)
 }
 
 module_init(probe_serial_gsc);
+
+MODULE_LICENSE("GPL");

