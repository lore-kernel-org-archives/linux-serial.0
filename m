From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 14/75] Define get_init_pts_sb()
Date: Fri, 02 Jan 2009 13:42:19 +0000
Message-ID: <20090102134217.13472.76826.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60305 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755618AbZABNmF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:42:05 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

See comments in the function header for details. The new interface will
be used in a follow-on patch.

Changelog [v2]:
	[Dave Hansen] Replace get_sb_ref() in fs/super.c with get_init_pts_sb()
	and make the new interface private to devpts

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 fs/devpts/inode.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 1 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 8ee9dc2..2d0eb2c 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -305,10 +305,63 @@ fail:
 	return -ENOMEM;
 }
 
+static int compare_init_pts_sb(struct super_block *s, void *p)
+{
+	if (devpts_mnt)
+		return devpts_mnt->mnt_sb == s;
+
+	return 0;
+}
+
+/*
+ * get_init_pts_sb()
+ *
+ *     This interface is needed to support multiple namespace semantics in
+ *     devpts while preserving backward compatibility of the current 'single-
+ *     namespace' semantics. i.e all mounts of devpts without the 'newinstance'
+ *     mount option should bind to the initial kernel mount, like
+ *     get_sb_single().
+ *
+ *     Mounts with 'newinstance' option create a new private namespace.
+ *
+ *     But for single-mount semantics, devpts cannot use get_sb_single(),
+ *     because get_sb_single()/sget() find and use the super-block from
+ *     the most recent mount of devpts. But that recent mount may be a
+ *     'newinstance' mount and get_sb_single() would pick the newinstance
+ *     super-block instead of the initial super-block.
+ *
+ *     This interface is identical to get_sb_single() except that it
+ *     consistently selects the 'single-namespace' superblock even in the
+ *     presence of the private namespace (i.e 'newinstance') super-blocks.
+ */
+static int get_init_pts_sb(struct file_system_type *fs_type, int flags,
+		void *data, struct vfsmount *mnt)
+{
+        struct super_block *s;
+        int error;
+
+        s = sget(fs_type, compare_init_pts_sb, set_anon_super, NULL);
+        if (IS_ERR(s))
+                return PTR_ERR(s);
+
+        if (!s->s_root) {
+                s->s_flags = flags;
+                error = devpts_fill_super(s, data, flags & MS_SILENT ? 1 : 0);
+                if (error) {
+                        up_write(&s->s_umount);
+                        deactivate_super(s);
+                        return error;
+                }
+                s->s_flags |= MS_ACTIVE;
+        }
+        do_remount_sb(s, flags, data, 0);
+        return simple_set_mnt(mnt, s);
+}
+
 static int devpts_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, devpts_fill_super, mnt);
+	return get_init_pts_sb(fs_type, flags, data, mnt);
 }
 
 static void devpts_kill_sb(struct super_block *sb)

