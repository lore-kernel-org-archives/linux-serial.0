From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 29/75] CRED: Wrap task credential accesses in the devpts
	filesystem
Date: Fri, 02 Jan 2009 13:44:49 +0000
Message-ID: <20090102134440.13472.54949.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37594 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756961AbZABNqU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:20 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Wrap access to task credentials so that they can be separated more easily from
the task_struct during the introduction of COW creds.

Change most current->(|e|s|fs)[ug]id to current_(|e|s|fs)[ug]id().

Change some task->e?[ug]id to task_e?[ug]id().  In some places it makes more
sense to use RCU directly rather than a convenient wrapper; these will be
addressed by later patches.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 fs/devpts/inode.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 3f309f1..fff96e1 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -594,9 +594,9 @@ int devpts_pty_new(struct inode *ptmx_inode, struct tty_struct *tty)
 	if (!inode)
 		return -ENOMEM;
 
-	inode->i_ino = number+2;
-	inode->i_uid = config.setuid ? config.uid : current_fsuid();
-	inode->i_gid = config.setgid ? config.gid : current_fsgid();
+	inode->i_ino = number + 3;
+	inode->i_uid = opts->setuid ? opts->uid : current_fsuid();
+	inode->i_gid = opts->setgid ? opts->gid : current_fsgid();
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|opts->mode, device);
 	inode->i_private = tty;

