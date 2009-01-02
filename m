From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 08/75] Remove devpts_root global
Date: Fri, 02 Jan 2009 13:41:11 +0000
Message-ID: <20090102134109.13472.82618.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60287 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754760AbZABNk5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:40:57 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Remove the 'devpts_root' global variable and find the root dentry using
the super_block. The super-block can be found from the device inode, using
the new wrapper, pts_sb_from_inode().

Changelog: This patch is based on an earlier patchset from Serge Hallyn
	   and Matt Helsley.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 fs/devpts/inode.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 5d61b7c..f96e10a 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -34,7 +34,6 @@ static DEFINE_IDA(allocated_ptys);
 static DEFINE_MUTEX(allocated_ptys_lock);
 
 static struct vfsmount *devpts_mnt;
-static struct dentry *devpts_root;
 
 static struct {
 	int setuid;
@@ -56,6 +55,14 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
+static inline struct super_block *pts_sb_from_inode(struct inode *inode)
+{
+	if (inode->i_sb->s_magic == DEVPTS_SUPER_MAGIC)
+		return inode->i_sb;
+
+	return devpts_mnt->mnt_sb;
+}
+
 static int devpts_remount(struct super_block *sb, int *flags, char *data)
 {
 	char *p;
@@ -142,7 +149,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	inode->i_fop = &simple_dir_operations;
 	inode->i_nlink = 2;
 
-	devpts_root = s->s_root = d_alloc_root(inode);
+	s->s_root = d_alloc_root(inode);
 	if (s->s_root)
 		return 0;
 	
@@ -211,7 +218,9 @@ int devpts_pty_new(struct inode *ptmx_inode, struct tty_struct *tty)
 	struct tty_driver *driver = tty->driver;
 	dev_t device = MKDEV(driver->major, driver->minor_start+number);
 	struct dentry *dentry;
-	struct inode *inode = new_inode(devpts_mnt->mnt_sb);
+	struct super_block *sb = pts_sb_from_inode(ptmx_inode);
+	struct inode *inode = new_inode(sb);
+	struct dentry *root = sb->s_root;
 	char s[12];
 
 	/* We're supposed to be given the slave end of a pty */
@@ -231,15 +240,15 @@ int devpts_pty_new(struct inode *ptmx_inode, struct tty_struct *tty)
 
 	sprintf(s, "%d", number);
 
-	mutex_lock(&devpts_root->d_inode->i_mutex);
+	mutex_lock(&root->d_inode->i_mutex);
 
-	dentry = d_alloc_name(devpts_root, s);
+	dentry = d_alloc_name(root, s);
 	if (!IS_ERR(dentry)) {
 		d_add(dentry, inode);
-		fsnotify_create(devpts_root->d_inode, dentry);
+		fsnotify_create(root->d_inode, dentry);
 	}
 
-	mutex_unlock(&devpts_root->d_inode->i_mutex);
+	mutex_unlock(&root->d_inode->i_mutex);
 
 	return 0;
 }
@@ -256,11 +265,13 @@ struct tty_struct *devpts_get_tty(struct inode *pts_inode, int number)
 void devpts_pty_kill(struct tty_struct *tty)
 {
 	struct inode *inode = tty->driver_data;
+	struct super_block *sb = pts_sb_from_inode(inode);
+	struct dentry *root = sb->s_root;
 	struct dentry *dentry;
 
 	BUG_ON(inode->i_rdev == MKDEV(TTYAUX_MAJOR, PTMX_MINOR));
 
-	mutex_lock(&devpts_root->d_inode->i_mutex);
+	mutex_lock(&root->d_inode->i_mutex);
 
 	dentry = d_find_alias(inode);
 	if (dentry && !IS_ERR(dentry)) {
@@ -269,7 +280,7 @@ void devpts_pty_kill(struct tty_struct *tty)
 		dput(dentry);
 	}
 
-	mutex_unlock(&devpts_root->d_inode->i_mutex);
+	mutex_unlock(&root->d_inode->i_mutex);
 }
 
 static int __init init_devpts_fs(void)

