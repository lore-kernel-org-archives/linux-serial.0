From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/13] jsm: Change maintainership
Date: Mon, 21 Nov 2011 17:11:31 -0800
Message-ID: <1321924303-26475-1-git-send-email-gregkh@suse.de>
References: <20111122005917.GD25420@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42141 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757632Ab1KVBN3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 20:13:29 -0500
In-Reply-To: <20111122005917.GD25420@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>

Breno Leitao has passed the maintainership on to me.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Acked-by: Breno Leitao <brenohl@br.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 MAINTAINERS |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4808256..cc6a466 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3710,7 +3710,7 @@ F:	fs/jbd2/
 F:	include/linux/jbd2.h
 
 JSM Neo PCI based serial card
-M:	Breno Leitao <leitao@linux.vnet.ibm.com>
+M:	Lucas Tavares <lucaskt@linux.vnet.ibm.com>
 L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/serial/jsm/
-- 
1.7.7.3

