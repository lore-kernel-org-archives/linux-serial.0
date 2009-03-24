From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 17/30] specialix: Auto-load specialix module when device
	opened.
Date: Tue, 24 Mar 2009 14:04:43 +0000
Message-ID: <20090324140439.12735.41725.stgit@localhost.localdomain>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48970 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758820AbZCXOEV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 10:04:21 -0400
In-Reply-To: <20090324135930.12735.7827.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

From: Scott James Remnant <scott@canonical.com>

The specialix module is missing the char-major-75-* alias that would
cause it to be auto-loaded when a device of that type is opened.  This
patch adds the alias.

Signed-off-by: Scott James Remnant <scott@canonical.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

 drivers/char/specialix.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
index 3c67c3d..e72be41 100644
--- a/drivers/char/specialix.c
+++ b/drivers/char/specialix.c
@@ -2365,3 +2365,4 @@ module_init(specialix_init_module);
 module_exit(specialix_exit_module);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(SPECIALIX_NORMAL_MAJOR);

