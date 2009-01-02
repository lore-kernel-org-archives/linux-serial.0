From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 11/75] Extract option parsing to new function
Date: Fri, 02 Jan 2009 13:41:47 +0000
Message-ID: <20090102134139.13472.70794.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60296 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754930AbZABNlc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:41:32 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Move code to parse mount options into a separate function so it can
(later) be shared between mount and remount operations.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 fs/devpts/inode.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index b793e6e..00530e8 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -72,11 +72,9 @@ static inline struct super_block *pts_sb_from_inode(struct inode *inode)
 	return devpts_mnt->mnt_sb;
 }
 
-static int devpts_remount(struct super_block *sb, int *flags, char *data)
+static int parse_mount_options(char *data, struct pts_mount_opts *opts)
 {
 	char *p;
-	struct pts_fs_info *fsi = DEVPTS_SB(sb);
-	struct pts_mount_opts *opts = &fsi->mount_opts;
 
 	opts->setuid  = 0;
 	opts->setgid  = 0;
@@ -120,6 +118,14 @@ static int devpts_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
+static int devpts_remount(struct super_block *sb, int *flags, char *data)
+{
+	struct pts_fs_info *fsi = DEVPTS_SB(sb);
+	struct pts_mount_opts *opts = &fsi->mount_opts;
+
+	return parse_mount_options(data, opts);
+}
+
 static int devpts_show_options(struct seq_file *seq, struct vfsmount *vfs)
 {
 	struct pts_fs_info *fsi = DEVPTS_SB(vfs->mnt_sb);

