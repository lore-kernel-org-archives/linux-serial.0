From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 13/75] Define mknod_ptmx()
Date: Fri, 02 Jan 2009 13:42:02 +0000
Message-ID: <20090102134159.13472.73337.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60302 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755428AbZABNl5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:41:57 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

/dev/ptmx is closely tied to the devpts filesystem. An open of /dev/ptmx,
allocates the next pty index and the associated device shows up in the
devpts fs as /dev/pts/n.

Wih multiple instancs of devpts filesystem, during an open of /dev/ptmx
we would be unable to determine which instance of the devpts is being
accessed.

So we move the 'ptmx' node into /dev/pts and use the inode of the 'ptmx'
node to identify the superblock and hence the devpts instance.  This patch
adds ability for the kernel to internally create the [ptmx, c, 5:2] device
when mounting devpts filesystem.  Since the ptmx node in devpts is new and
may surprise some userspace scripts, the default permissions for the new
node is 0000.  These permissions can be changed either using chmod or by
remounting with the new '-o ptmxmode=0666' mount option.

Changelog[v5]:
	- [Serge Hallyn bugfix]: Letting new_inode() assign inode number to
	  ptmx can collide with hand-assigning inode numbers to ptys. So,
	  hand-assign specific inode number to ptmx node also.
	- [Serge Hallyn]: Maybe safer to grab root dentry mutex while creating
	  ptmx node
	- [Bugfix with Serge Hallyn] Replace lookup_one_len() in mknod_ptmx()
	  wih d_alloc_name() (lookup during ->get_sb() locks up system). To
	  simplify patchset, fold the ptmx_dentry patch into this.

Changelog[v4]:
	- Change default permissions of pts/ptmx node to 0000.
	- Move code for ptmxmode under #ifdef CONFIG_DEVPTS_MULTIPLE_INSTANCES.

Changelog[v3]:
	- Rename ptmx_mode to ptmxmode (for consistency with 'newinstance')

Changelog[v2]:
	- [H. Peter Anvin] Remove mknod() system call support and create the
	  ptmx node internally.

Changelog[v1]:
	- Earlier version of this patch enabled creating /dev/pts/tty as
	  well. As pointed out by Al Viro and H. Peter Anvin, that is not
	  really necessary.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 fs/devpts/inode.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 110 insertions(+), 5 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 00530e8..8ee9dc2 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -27,6 +27,13 @@
 #define DEVPTS_SUPER_MAGIC 0x1cd1
 
 #define DEVPTS_DEFAULT_MODE 0600
+/*
+ * ptmx is a new node in /dev/pts and will be unused in legacy (single-
+ * instance) mode. To prevent surprises in user space, set permissions of
+ * ptmx to 0. Use 'chmod' or remount with '-o ptmxmode' to set meaningful
+ * permissions.
+ */
+#define DEVPTS_DEFAULT_PTMX_MODE 0000
 #define PTMX_MINOR	2
 
 extern int pty_limit;			/* Config limit on Unix98 ptys */
@@ -40,10 +47,11 @@ struct pts_mount_opts {
 	uid_t   uid;
 	gid_t   gid;
 	umode_t mode;
+	umode_t ptmxmode;
 };
 
 enum {
-	Opt_uid, Opt_gid, Opt_mode,
+	Opt_uid, Opt_gid, Opt_mode, Opt_ptmxmode,
 	Opt_err
 };
 
@@ -51,12 +59,16 @@ static const match_table_t tokens = {
 	{Opt_uid, "uid=%u"},
 	{Opt_gid, "gid=%u"},
 	{Opt_mode, "mode=%o"},
+#ifdef CONFIG_DEVPTS_MULTIPLE_INSTANCES
+	{Opt_ptmxmode, "ptmxmode=%o"},
+#endif
 	{Opt_err, NULL}
 };
 
 struct pts_fs_info {
 	struct ida allocated_ptys;
 	struct pts_mount_opts mount_opts;
+	struct dentry *ptmx_dentry;
 };
 
 static inline struct pts_fs_info *DEVPTS_SB(struct super_block *sb)
@@ -81,6 +93,7 @@ static int parse_mount_options(char *data, struct pts_mount_opts *opts)
 	opts->uid     = 0;
 	opts->gid     = 0;
 	opts->mode    = DEVPTS_DEFAULT_MODE;
+	opts->ptmxmode = DEVPTS_DEFAULT_PTMX_MODE;
 
 	while ((p = strsep(&data, ",")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
@@ -109,6 +122,13 @@ static int parse_mount_options(char *data, struct pts_mount_opts *opts)
 				return -EINVAL;
 			opts->mode = option & S_IALLUGO;
 			break;
+#ifdef CONFIG_DEVPTS_MULTIPLE_INSTANCES
+		case Opt_ptmxmode:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->ptmxmode = option & S_IALLUGO;
+			break;
+#endif
 		default:
 			printk(KERN_ERR "devpts: called with bogus options\n");
 			return -EINVAL;
@@ -118,12 +138,93 @@ static int parse_mount_options(char *data, struct pts_mount_opts *opts)
 	return 0;
 }
 
+#ifdef CONFIG_DEVPTS_MULTIPLE_INSTANCES
+static int mknod_ptmx(struct super_block *sb)
+{
+	int mode;
+	int rc = -ENOMEM;
+	struct dentry *dentry;
+	struct inode *inode;
+	struct dentry *root = sb->s_root;
+	struct pts_fs_info *fsi = DEVPTS_SB(sb);
+	struct pts_mount_opts *opts = &fsi->mount_opts;
+
+	mutex_lock(&root->d_inode->i_mutex);
+
+	/* If we have already created ptmx node, return */
+	if (fsi->ptmx_dentry) {
+		rc = 0;
+		goto out;
+	}
+
+	dentry = d_alloc_name(root, "ptmx");
+	if (!dentry) {
+		printk(KERN_NOTICE "Unable to alloc dentry for ptmx node\n");
+		goto out;
+	}
+
+	/*
+	 * Create a new 'ptmx' node in this mount of devpts.
+	 */
+	inode = new_inode(sb);
+	if (!inode) {
+		printk(KERN_ERR "Unable to alloc inode for ptmx node\n");
+		dput(dentry);
+		goto out;
+	}
+
+	inode->i_ino = 2;
+	inode->i_uid = inode->i_gid = 0;
+	inode->i_blocks = 0;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+
+	mode = S_IFCHR|opts->ptmxmode;
+	init_special_inode(inode, mode, MKDEV(TTYAUX_MAJOR, 2));
+
+	d_add(dentry, inode);
+
+	fsi->ptmx_dentry = dentry;
+	rc = 0;
+
+	printk(KERN_DEBUG "Created ptmx node in devpts ino %lu\n",
+			inode->i_ino);
+out:
+	mutex_unlock(&root->d_inode->i_mutex);
+	return rc;
+}
+
+static void update_ptmx_mode(struct pts_fs_info *fsi)
+{
+	struct inode *inode;
+	if (fsi->ptmx_dentry) {
+		inode = fsi->ptmx_dentry->d_inode;
+		inode->i_mode = S_IFCHR|fsi->mount_opts.ptmxmode;
+	}
+}
+#else
+static inline void update_ptmx_mode(struct pts_fs_info *fsi)
+{
+       return;
+}
+#endif
+
 static int devpts_remount(struct super_block *sb, int *flags, char *data)
 {
+	int err;
 	struct pts_fs_info *fsi = DEVPTS_SB(sb);
 	struct pts_mount_opts *opts = &fsi->mount_opts;
 
-	return parse_mount_options(data, opts);
+	err = parse_mount_options(data, opts);
+
+	/*
+	 * parse_mount_options() restores options to default values
+	 * before parsing and may have changed ptmxmode. So, update the
+	 * mode in the inode too. Bogus options don't fail the remount,
+	 * so do this even on error return.
+	 */
+	update_ptmx_mode(fsi);
+
+	return err;
 }
 
 static int devpts_show_options(struct seq_file *seq, struct vfsmount *vfs)
@@ -136,6 +237,9 @@ static int devpts_show_options(struct seq_file *seq, struct vfsmount *vfs)
 	if (opts->setgid)
 		seq_printf(seq, ",gid=%u", opts->gid);
 	seq_printf(seq, ",mode=%03o", opts->mode);
+#ifdef CONFIG_DEVPTS_MULTIPLE_INSTANCES
+	seq_printf(seq, ",ptmxmode=%03o", opts->ptmxmode);
+#endif
 
 	return 0;
 }
@@ -156,6 +260,7 @@ static void *new_pts_fs_info(void)
 
 	ida_init(&fsi->allocated_ptys);
 	fsi->mount_opts.mode = DEVPTS_DEFAULT_MODE;
+	fsi->mount_opts.ptmxmode = DEVPTS_DEFAULT_PTMX_MODE;
 
 	return fsi;
 }
@@ -163,7 +268,7 @@ static void *new_pts_fs_info(void)
 static int
 devpts_fill_super(struct super_block *s, void *data, int silent)
 {
-	struct inode * inode;
+	struct inode *inode;
 
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
@@ -190,7 +295,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_root = d_alloc_root(inode);
 	if (s->s_root)
 		return 0;
-	
+
 	printk("devpts: get root dentry failed\n");
 	iput(inode);
 
@@ -211,7 +316,7 @@ static void devpts_kill_sb(struct super_block *sb)
 	struct pts_fs_info *fsi = DEVPTS_SB(sb);
 
 	kfree(fsi);
-	kill_anon_super(sb);
+	kill_litter_super(sb);
 }
 
 static struct file_system_type devpts_fs_type = {

