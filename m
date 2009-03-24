From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 06/30] devpts: must release s_umount on error
Date: Tue, 24 Mar 2009 14:02:40 +0000
Message-ID: <20090324140237.12735.87068.stgit@localhost.localdomain>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48935 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757628AbZCXOCQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 10:02:16 -0400
In-Reply-To: <20090324135930.12735.7827.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

We should drop the ->s_umount mutex if an error occurs after the
sget()/grab_super() call. This was introduced when adding support
for multiple instances of devpts and noticed during a code review/reorg.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alan Cox <alan@etchedpixels.co.uk>
---

 fs/devpts/inode.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index bff4052..140b431 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -385,6 +385,7 @@ static int new_pts_mount(struct file_system_type *fs_type, int flags,
 
 fail:
 	dput(mnt->mnt_sb->s_root);
+	up_write(&mnt->mnt_sb->s_umount);
 	deactivate_super(mnt->mnt_sb);
 	return err;
 }
@@ -473,6 +474,7 @@ static int init_pts_mount(struct file_system_type *fs_type, int flags,
 	err = mknod_ptmx(mnt->mnt_sb);
 	if (err) {
 		dput(mnt->mnt_sb->s_root);
+		up_write(&mnt->mnt_sb->s_umount);
 		deactivate_super(mnt->mnt_sb);
 	}
 

