From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 09/75] Per-mount allocated_ptys
Date: Fri, 02 Jan 2009 13:41:21 +0000
Message-ID: <20090102134117.13472.80831.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60290 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754930AbZABNlG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:41:06 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

To enable multiple mounts of devpts, 'allocated_ptys' must be a per-mount
variable rather than a global variable.  Move 'allocated_ptys' into the
super_block's s_fs_info.

Changelog[v2]:
	Define and use DEVPTS_SB() wrapper.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 fs/devpts/inode.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 48 insertions(+), 7 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index f96e10a..49d879d 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -30,7 +30,6 @@
 #define PTMX_MINOR	2
 
 extern int pty_limit;			/* Config limit on Unix98 ptys */
-static DEFINE_IDA(allocated_ptys);
 static DEFINE_MUTEX(allocated_ptys_lock);
 
 static struct vfsmount *devpts_mnt;
@@ -55,6 +54,15 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
+struct pts_fs_info {
+	struct ida allocated_ptys;
+};
+
+static inline struct pts_fs_info *DEVPTS_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
 static inline struct super_block *pts_sb_from_inode(struct inode *inode)
 {
 	if (inode->i_sb->s_magic == DEVPTS_SUPER_MAGIC)
@@ -126,6 +134,19 @@ static const struct super_operations devpts_sops = {
 	.show_options	= devpts_show_options,
 };
 
+static void *new_pts_fs_info(void)
+{
+	struct pts_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(struct pts_fs_info), GFP_KERNEL);
+	if (!fsi)
+		return NULL;
+
+	ida_init(&fsi->allocated_ptys);
+
+	return fsi;
+}
+
 static int
 devpts_fill_super(struct super_block *s, void *data, int silent)
 {
@@ -137,9 +158,13 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_op = &devpts_sops;
 	s->s_time_gran = 1;
 
+	s->s_fs_info = new_pts_fs_info();
+	if (!s->s_fs_info)
+		goto fail;
+
 	inode = new_inode(s);
 	if (!inode)
-		goto fail;
+		goto free_fsi;
 	inode->i_ino = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = 0;
@@ -155,6 +180,9 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	
 	printk("devpts: get root dentry failed\n");
 	iput(inode);
+
+free_fsi:
+	kfree(s->s_fs_info);
 fail:
 	return -ENOMEM;
 }
@@ -165,11 +193,19 @@ static int devpts_get_sb(struct file_system_type *fs_type,
 	return get_sb_single(fs_type, flags, data, devpts_fill_super, mnt);
 }
 
+static void devpts_kill_sb(struct super_block *sb)
+{
+	struct pts_fs_info *fsi = DEVPTS_SB(sb);
+
+	kfree(fsi);
+	kill_anon_super(sb);
+}
+
 static struct file_system_type devpts_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "devpts",
 	.get_sb		= devpts_get_sb,
-	.kill_sb	= kill_anon_super,
+	.kill_sb	= devpts_kill_sb,
 };
 
 /*
@@ -179,16 +215,18 @@ static struct file_system_type devpts_fs_type = {
 
 int devpts_new_index(struct inode *ptmx_inode)
 {
+	struct super_block *sb = pts_sb_from_inode(ptmx_inode);
+	struct pts_fs_info *fsi = DEVPTS_SB(sb);
 	int index;
 	int ida_ret;
 
 retry:
-	if (!ida_pre_get(&allocated_ptys, GFP_KERNEL)) {
+	if (!ida_pre_get(&fsi->allocated_ptys, GFP_KERNEL)) {
 		return -ENOMEM;
 	}
 
 	mutex_lock(&allocated_ptys_lock);
-	ida_ret = ida_get_new(&allocated_ptys, &index);
+	ida_ret = ida_get_new(&fsi->allocated_ptys, &index);
 	if (ida_ret < 0) {
 		mutex_unlock(&allocated_ptys_lock);
 		if (ida_ret == -EAGAIN)
@@ -197,7 +235,7 @@ retry:
 	}
 
 	if (index >= pty_limit) {
-		ida_remove(&allocated_ptys, index);
+		ida_remove(&fsi->allocated_ptys, index);
 		mutex_unlock(&allocated_ptys_lock);
 		return -EIO;
 	}
@@ -207,8 +245,11 @@ retry:
 
 void devpts_kill_index(struct inode *ptmx_inode, int idx)
 {
+	struct super_block *sb = pts_sb_from_inode(ptmx_inode);
+	struct pts_fs_info *fsi = DEVPTS_SB(sb);
+
 	mutex_lock(&allocated_ptys_lock);
-	ida_remove(&allocated_ptys, idx);
+	ida_remove(&fsi->allocated_ptys, idx);
 	mutex_unlock(&allocated_ptys_lock);
 }
 

