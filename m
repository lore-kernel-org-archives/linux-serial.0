From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 25/75] devpts: fix unused function warning
Date: Fri, 02 Jan 2009 13:44:12 +0000
Message-ID: <20090102134409.13472.83966.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60338 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756102AbZABNn6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:43:58 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>

fs/devpts/inode.c:324: warning: 'compare_init_pts_sb' defined but not used

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 fs/devpts/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index b02c243..3f309f1 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -320,6 +320,7 @@ fail:
 	return -ENOMEM;
 }
 
+#ifdef CONFIG_DEVPTS_MULTIPLE_INSTANCES
 static int compare_init_pts_sb(struct super_block *s, void *p)
 {
 	if (devpts_mnt)
@@ -327,7 +328,6 @@ static int compare_init_pts_sb(struct super_block *s, void *p)
 	return 0;
 }
 
-#ifdef CONFIG_DEVPTS_MULTIPLE_INSTANCES
 /*
  * Safely parse the mount options in @data and update @opts.
  *

