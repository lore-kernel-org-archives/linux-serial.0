From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 10/75] Per-mount 'config' object
Date: Fri, 02 Jan 2009 13:41:33 +0000
Message-ID: <20090102134126.13472.47524.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60293 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754760AbZABNlT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:41:19 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

With support for multiple mounts of devpts, the 'config' structure really
represents per-mount options rather than config parameters. Rename 'config'
structure to 'pts_mount_opts' and store it in the super-block.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 fs/devpts/inode.c |   45 +++++++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 18 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 49d879d..b793e6e 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -34,13 +34,13 @@ static DEFINE_MUTEX(allocated_ptys_lock);
 
 static struct vfsmount *devpts_mnt;
 
-static struct {
+struct pts_mount_opts {
 	int setuid;
 	int setgid;
 	uid_t   uid;
 	gid_t   gid;
 	umode_t mode;
-} config = {.mode = DEVPTS_DEFAULT_MODE};
+};
 
 enum {
 	Opt_uid, Opt_gid, Opt_mode,
@@ -56,6 +56,7 @@ static const match_table_t tokens = {
 
 struct pts_fs_info {
 	struct ida allocated_ptys;
+	struct pts_mount_opts mount_opts;
 };
 
 static inline struct pts_fs_info *DEVPTS_SB(struct super_block *sb)
@@ -74,12 +75,14 @@ static inline struct super_block *pts_sb_from_inode(struct inode *inode)
 static int devpts_remount(struct super_block *sb, int *flags, char *data)
 {
 	char *p;
+	struct pts_fs_info *fsi = DEVPTS_SB(sb);
+	struct pts_mount_opts *opts = &fsi->mount_opts;
 
-	config.setuid  = 0;
-	config.setgid  = 0;
-	config.uid     = 0;
-	config.gid     = 0;
-	config.mode    = DEVPTS_DEFAULT_MODE;
+	opts->setuid  = 0;
+	opts->setgid  = 0;
+	opts->uid     = 0;
+	opts->gid     = 0;
+	opts->mode    = DEVPTS_DEFAULT_MODE;
 
 	while ((p = strsep(&data, ",")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
@@ -94,19 +97,19 @@ static int devpts_remount(struct super_block *sb, int *flags, char *data)
 		case Opt_uid:
 			if (match_int(&args[0], &option))
 				return -EINVAL;
-			config.uid = option;
-			config.setuid = 1;
+			opts->uid = option;
+			opts->setuid = 1;
 			break;
 		case Opt_gid:
 			if (match_int(&args[0], &option))
 				return -EINVAL;
-			config.gid = option;
-			config.setgid = 1;
+			opts->gid = option;
+			opts->setgid = 1;
 			break;
 		case Opt_mode:
 			if (match_octal(&args[0], &option))
 				return -EINVAL;
-			config.mode = option & S_IALLUGO;
+			opts->mode = option & S_IALLUGO;
 			break;
 		default:
 			printk(KERN_ERR "devpts: called with bogus options\n");
@@ -119,11 +122,14 @@ static int devpts_remount(struct super_block *sb, int *flags, char *data)
 
 static int devpts_show_options(struct seq_file *seq, struct vfsmount *vfs)
 {
-	if (config.setuid)
-		seq_printf(seq, ",uid=%u", config.uid);
-	if (config.setgid)
-		seq_printf(seq, ",gid=%u", config.gid);
-	seq_printf(seq, ",mode=%03o", config.mode);
+	struct pts_fs_info *fsi = DEVPTS_SB(vfs->mnt_sb);
+	struct pts_mount_opts *opts = &fsi->mount_opts;
+
+	if (opts->setuid)
+		seq_printf(seq, ",uid=%u", opts->uid);
+	if (opts->setgid)
+		seq_printf(seq, ",gid=%u", opts->gid);
+	seq_printf(seq, ",mode=%03o", opts->mode);
 
 	return 0;
 }
@@ -143,6 +149,7 @@ static void *new_pts_fs_info(void)
 		return NULL;
 
 	ida_init(&fsi->allocated_ptys);
+	fsi->mount_opts.mode = DEVPTS_DEFAULT_MODE;
 
 	return fsi;
 }
@@ -262,6 +269,8 @@ int devpts_pty_new(struct inode *ptmx_inode, struct tty_struct *tty)
 	struct super_block *sb = pts_sb_from_inode(ptmx_inode);
 	struct inode *inode = new_inode(sb);
 	struct dentry *root = sb->s_root;
+	struct pts_fs_info *fsi = DEVPTS_SB(sb);
+	struct pts_mount_opts *opts = &fsi->mount_opts;
 	char s[12];
 
 	/* We're supposed to be given the slave end of a pty */
@@ -275,7 +284,7 @@ int devpts_pty_new(struct inode *ptmx_inode, struct tty_struct *tty)
 	inode->i_uid = config.setuid ? config.uid : current_fsuid();
 	inode->i_gid = config.setgid ? config.gid : current_fsgid();
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	init_special_inode(inode, S_IFCHR|config.mode, device);
+	init_special_inode(inode, S_IFCHR|opts->mode, device);
 	inode->i_private = tty;
 	tty->driver_data = inode;
 

