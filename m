From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 16/30] cyclades: Auto-load cyclades module when device opened.
Date: Tue, 24 Mar 2009 14:04:34 +0000
Message-ID: <20090324140431.12735.50231.stgit@localhost.localdomain>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48968 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758793AbZCXOEM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 10:04:12 -0400
In-Reply-To: <20090324135930.12735.7827.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

From: Scott James Remnant <scott@canonical.com>

The cyclades module is missing the char-major-19-* alias that would
cause it to be auto-loaded when a device of that type is opened.  This
patch adds the alias.

Signed-off-by: Scott James Remnant <scott@canonical.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

 drivers/char/cyclades.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/drivers/char/cyclades.c b/drivers/char/cyclades.c
index 6a59f72..4e89d49 100644
--- a/drivers/char/cyclades.c
+++ b/drivers/char/cyclades.c
@@ -646,6 +646,7 @@
 #include <linux/spinlock.h>
 #include <linux/bitops.h>
 #include <linux/firmware.h>
+#include <linux/device.h>
 
 #include <asm/system.h>
 #include <linux/io.h>
@@ -5422,3 +5423,4 @@ module_exit(cy_cleanup_module);
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION(CY_VERSION);
+MODULE_ALIAS_CHARDEV_MAJOR(CYCLADES_MAJOR);

