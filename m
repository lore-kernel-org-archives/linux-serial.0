From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] MAINTAINERS: Add serial
Date: Fri, 18 Mar 2011 13:34:07 +0000
Message-ID: <20110318133346.9767.49089.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56431 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677Ab1CRNyf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 09:54:35 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, torvalds@linux-foundation.org, s.hauer@pengutronix.de

From: Alan Cox <alan@linux.intel.com>

Add an entry for serial maintainers. 

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


diff --git a/MAINTAINERS b/MAINTAINERS
index 2b9de57..e52a739 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5405,6 +5405,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/samsung
 
+SERIAL DRIVERS
+M:	Alan Cox <alan@linux.intel.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	tty/serial
+
 TIMEKEEPING, NTP
 M:	John Stultz <johnstul@us.ibm.com>
 M:	Thomas Gleixner <tglx@linutronix.de>

