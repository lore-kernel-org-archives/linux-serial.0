From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 17/75] devpts: Coding style clean up
Date: Fri, 02 Jan 2009 13:42:48 +0000
Message-ID: <20090102134239.13472.3197.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60314 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755847AbZABNme (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:42:34 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Just nail the oddments now while this code is being touched

Signed-off-by: Alan Cox <alan@redhat.com>
---

 fs/devpts/inode.c |   53 ++++++++++++++++++++++++++---------------------------
 1 files changed, 26 insertions(+), 27 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index b4a89fa..b02c243 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -311,7 +311,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	if (s->s_root)
 		return 0;
 
-	printk("devpts: get root dentry failed\n");
+	printk(KERN_ERR "devpts: get root dentry failed\n");
 	iput(inode);
 
 free_fsi:
@@ -444,25 +444,25 @@ static int is_new_instance_mount(void *data)
 static int get_init_pts_sb(struct file_system_type *fs_type, int flags,
 		void *data, struct vfsmount *mnt)
 {
-        struct super_block *s;
-        int error;
-
-        s = sget(fs_type, compare_init_pts_sb, set_anon_super, NULL);
-        if (IS_ERR(s))
-                return PTR_ERR(s);
-
-        if (!s->s_root) {
-                s->s_flags = flags;
-                error = devpts_fill_super(s, data, flags & MS_SILENT ? 1 : 0);
-                if (error) {
-                        up_write(&s->s_umount);
-                        deactivate_super(s);
-                        return error;
-                }
-                s->s_flags |= MS_ACTIVE;
-        }
-        do_remount_sb(s, flags, data, 0);
-        return simple_set_mnt(mnt, s);
+	struct super_block *s;
+	int error;
+
+	s = sget(fs_type, compare_init_pts_sb, set_anon_super, NULL);
+	if (IS_ERR(s))
+		return PTR_ERR(s);
+
+	if (!s->s_root) {
+		s->s_flags = flags;
+		error = devpts_fill_super(s, data, flags & MS_SILENT ? 1 : 0);
+		if (error) {
+			up_write(&s->s_umount);
+			deactivate_super(s);
+			return error;
+		}
+		s->s_flags |= MS_ACTIVE;
+	}
+	do_remount_sb(s, flags, data, 0);
+	return simple_set_mnt(mnt, s);
 }
 
 /*
@@ -477,7 +477,7 @@ static int init_pts_mount(struct file_system_type *fs_type, int flags,
 
 	err = get_init_pts_sb(fs_type, flags, data, mnt);
 	if (err)
-		 return err;
+		return err;
 
 	err = mknod_ptmx(mnt->mnt_sb);
 	if (err) {
@@ -542,9 +542,8 @@ int devpts_new_index(struct inode *ptmx_inode)
 	int ida_ret;
 
 retry:
-	if (!ida_pre_get(&fsi->allocated_ptys, GFP_KERNEL)) {
+	if (!ida_pre_get(&fsi->allocated_ptys, GFP_KERNEL))
 		return -ENOMEM;
-	}
 
 	mutex_lock(&allocated_ptys_lock);
 	ida_ret = ida_get_new(&fsi->allocated_ptys, &index);
@@ -576,7 +575,8 @@ void devpts_kill_index(struct inode *ptmx_inode, int idx)
 
 int devpts_pty_new(struct inode *ptmx_inode, struct tty_struct *tty)
 {
-	int number = tty->index; /* tty layer puts index from devpts_new_index() in here */
+	/* tty layer puts index from devpts_new_index() in here */
+	int number = tty->index;
 	struct tty_driver *driver = tty->driver;
 	dev_t device = MKDEV(driver->major, driver->minor_start+number);
 	struct dentry *dentry;
@@ -644,11 +644,10 @@ void devpts_pty_kill(struct tty_struct *tty)
 	if (dentry) {
 		inode->i_nlink--;
 		d_delete(dentry);
-		dput(dentry);	// d_alloc_name() in devpts_pty_new()
+		dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
 	}
 
-	dput(dentry);		// d_find_alias above
-
+	dput(dentry);		/* d_find_alias above */
 out:
 	mutex_unlock(&root->d_inode->i_mutex);
 }

