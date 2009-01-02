From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 12/75] Add DEVPTS_MULTIPLE_INSTANCES config token
Date: Fri, 02 Jan 2009 13:41:54 +0000
Message-ID: <20090102134152.13472.85810.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60299 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755373AbZABNlj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:41:39 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/Kconfig |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)


diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c602b54..c52a167 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -443,6 +443,17 @@ config UNIX98_PTYS
 	  All modern Linux systems use the Unix98 ptys.  Say Y unless
 	  you're on an embedded system and want to conserve memory.
 
+config DEVPTS_MULTIPLE_INSTANCES
+	bool "Support multiple instances of devpts"
+	depends on UNIX98_PTYS
+	default n
+	---help---
+	  Enable support for multiple instances of devpts filesystem.
+	  If you want to have isolated PTY namespaces (eg: in containers),
+	  say Y here.  Otherwise, say N. If enabled, each mount of devpts
+	  filesystem with the '-o newinstance' option will create an
+	  independent PTY namespace.
+
 config LEGACY_PTYS
 	bool "Legacy (BSD) PTY support"
 	default y

