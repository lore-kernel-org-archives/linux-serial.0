From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 64/76] MAINTAINERS: Update HVC file patterns
Date: Wed, 16 Mar 2011 14:12:34 -0700
Message-ID: <1300309966-5745-64-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32953 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259Ab1CPVPI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:08 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Joe Perches <joe@perches.com>

Commit 728674a7e466628df2aeec6d11a2ae1ef968fb67
("tty: move hvc drivers to drivers/tty/hvc/")
moved the files, update the patterns as appropriate.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5099856..ab3a9ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2819,7 +2819,7 @@ F:	mm/hwpoison-inject.c
 HYPERVISOR VIRTUAL CONSOLE DRIVER
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd Fixes
-F:	drivers/char/hvc_*
+F:	drivers/tty/hvc/
 
 iSCSI BOOT FIRMWARE TABLE (iBFT) DRIVER
 M:	Peter Jones <pjones@redhat.com>
@@ -6090,7 +6090,7 @@ M:	Chris Metcalf <cmetcalf@tilera.com>
 W:	http://www.tilera.com/scm/
 S:	Supported
 F:	arch/tile/
-F:	drivers/char/hvc_tile.c
+F:	drivers/tty/hvc/hvc_tile.c
 F:	drivers/net/tile/
 
 TLAN NETWORK DRIVER
-- 
1.7.4.1

