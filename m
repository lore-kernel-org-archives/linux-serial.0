Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F844AB92;
	Wed, 22 Jul 2026 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700121; cv=none; b=T4rq2t9beI333bsRPMXCGRzq13EfEoH4kn5s9Z9s8W4Z9PRurZja6EvAjl6JGerMNJzE4OHdfvsQy26++4L6wGVNx1j33pwCZA6NGeJB5WMgxzEeGwixje49diFge0SEFRPRiZ34l57n8H0TToNkBHXFcCnpcPFwr6J+diK/PJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700121; c=relaxed/simple;
	bh=FyBEUgvIq/x91xup4zlZzMj00wtsmCXCmN6f8ssx764=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnTq1GF7KS6EHEvtDjulCRp3fXJIBjnp/z7/gFMvX/Z7HvrRL3VIYYwhfWZD708+irXQfcG8OnDhRZI4UvgjysnSuOsDO7lkHnkNavTOrJQHKQz0yC/yV1eB6I8KGLke7aIUD85mrUx/TJGt8x16iVgQD5OJ5wQUKHRDJgYrSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjh6wimG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjh6wimG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762731F000E9;
	Wed, 22 Jul 2026 06:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784700120;
	bh=c9NHI8JRoVoQgLmkSRAE8PekdlmvFjRvXZuDMiKAChc=;
	h=From:To:Cc:Subject:Date;
	b=Zjh6wimGOsQ2uFprcHSBo+8Jt6voc0rfHqWMC9MQIKv++ccaCarqBCErAt/IkH4wv
	 lvhjwe5ZJb+Q8kBfRPRRvRw6xDcxD5jbaUcgHkuwmew9kEeOJZde4Ii+/F3oBFmSGM
	 Ev40V6Nb3v4sO8j0bSvdfzonOmiOA1WOudj325vERGhfsaLGk4ROgsKhdbR51fdoD3
	 6oX/tUzusA4Wb/zTCGvC7vbcGDKgxIYPMyA5X+xdech2Io37gT+AayYRnRxR5HFy5T
	 jNxYFElg17i+PQvBeTju8dNE7zrhyG8YNRPa+/fiGIanIl+xQ91b16qr1Axd/0J9Xw
	 nyOa8IqmJFd8w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kara <jack@suse.com>,
	Yangtao Li <frank.li@vivo.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] quota: remove CONFIG_PRINT_QUOTA_WARNING code
Date: Wed, 22 Jul 2026 08:01:55 +0200
Message-ID: <20260722060155.1111519-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_PRINT_QUOTA_WARNING was marked as BROKEN in 2023 by 36d532d713db
("quota: mark PRINT_QUOTA_WARNING as BROKEN").

The code is apparently unused and uninteresting, so remove it all, incl.
the abuse of TTY.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jan Kara <jack@suse.com>
Cc: Yangtao Li <frank.li@vivo.com>
---
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-serial@vger.kernel.org
---
 arch/loongarch/configs/loongson32_defconfig |  1 -
 arch/loongarch/configs/loongson64_defconfig |  1 -
 arch/mips/configs/bigsur_defconfig          |  1 -
 arch/mips/configs/ip22_defconfig            |  1 -
 arch/mips/configs/loongson2k_defconfig      |  1 -
 drivers/tty/tty_io.c                        | 27 -------
 fs/quota/Kconfig                            | 10 ---
 fs/quota/dquot.c                            | 81 +--------------------
 8 files changed, 2 insertions(+), 121 deletions(-)

diff --git a/arch/loongarch/configs/loongson32_defconfig b/arch/loongarch/configs/loongson32_defconfig
index 7c8f01513ed2..3d552eb526fe 100644
--- a/arch/loongarch/configs/loongson32_defconfig
+++ b/arch/loongarch/configs/loongson32_defconfig
@@ -974,7 +974,6 @@ CONFIG_FS_VERITY=y
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
 CONFIG_QUOTA=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V1=m
 CONFIG_QFMT_V2=m
 CONFIG_AUTOFS_FS=y
diff --git a/arch/loongarch/configs/loongson64_defconfig b/arch/loongarch/configs/loongson64_defconfig
index 8e3906d3bd70..195cf40cdbca 100644
--- a/arch/loongarch/configs/loongson64_defconfig
+++ b/arch/loongarch/configs/loongson64_defconfig
@@ -1005,7 +1005,6 @@ CONFIG_FS_VERITY=y
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
 CONFIG_QUOTA=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V1=m
 CONFIG_QFMT_V2=m
 CONFIG_AUTOFS_FS=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 611dc0dd392d..d2b18d5033be 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -140,7 +140,6 @@ CONFIG_EXT4_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=m
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 009e66299b69..09a77e5b249c 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -238,7 +238,6 @@ CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=m
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index ca534a6b66de..8fd863f4f7b0 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -303,7 +303,6 @@ CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_QUOTA=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_AUTOFS_FS=y
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=m
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6b283fd03ff8..a77bbccb274d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1032,33 +1032,6 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
 	return ret;
 }
 
-#ifdef CONFIG_PRINT_QUOTA_WARNING
-/**
- * tty_write_message - write a message to a certain tty, not just the console.
- * @tty: the destination tty_struct
- * @msg: the message to write
- *
- * This is used for messages that need to be redirected to a specific tty. We
- * don't put it into the syslog queue right now maybe in the future if really
- * needed.
- *
- * We must still hold the BTM and test the CLOSING flag for the moment.
- *
- * This function is DEPRECATED, do not use in new code.
- */
-void tty_write_message(struct tty_struct *tty, char *msg)
-{
-	if (tty) {
-		mutex_lock(&tty->atomic_write_lock);
-		tty_lock(tty);
-		if (tty->ops->write && tty->count > 0)
-			tty->ops->write(tty, msg, strlen(msg));
-		tty_unlock(tty);
-		tty_write_unlock(tty);
-	}
-}
-#endif
-
 static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_iter *from)
 {
 	struct tty_struct *tty = file_tty(file);
diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
index 818083a36bef..68eb441328ef 100644
--- a/fs/quota/Kconfig
+++ b/fs/quota/Kconfig
@@ -25,16 +25,6 @@ config QUOTA_NETLINK_INTERFACE
 	  hardlimit, etc.) will be reported through netlink interface. If unsure,
 	  say Y.
 
-config PRINT_QUOTA_WARNING
-	bool "Print quota warnings to console (OBSOLETE)"
-	depends on QUOTA && BROKEN
-	default y
-	help
-	  If you say Y here, quota warnings (about exceeding softlimit, reaching
-	  hardlimit, etc.) will be printed to the process' controlling terminal.
-	  Note that this behavior is currently deprecated and may go away in
-	  future. Please use notification via netlink socket instead.
-
 config QUOTA_DEBUG
 	bool "Additional quota sanity checks"
 	depends on QUOTA
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 9850de3955d3..204afc5e984b 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -153,7 +153,7 @@ void __quota_error(struct super_block *sb, const char *func,
 }
 EXPORT_SYMBOL(__quota_error);
 
-#if defined(CONFIG_QUOTA_DEBUG) || defined(CONFIG_PRINT_QUOTA_WARNING)
+#ifdef CONFIG_QUOTA_DEBUG
 static char *quotatypes[] = INITQFNAMES;
 #endif
 static struct quota_format_type *quota_formats;	/* List of registered formats */
@@ -1208,72 +1208,6 @@ static int warning_issued(struct dquot *dquot, const int warntype)
 	return test_and_set_bit(flag, &dquot->dq_flags);
 }
 
-#ifdef CONFIG_PRINT_QUOTA_WARNING
-static int flag_print_warnings = 1;
-
-static int need_print_warning(struct dquot_warn *warn)
-{
-	if (!flag_print_warnings)
-		return 0;
-
-	switch (warn->w_dq_id.type) {
-		case USRQUOTA:
-			return uid_eq(current_fsuid(), warn->w_dq_id.uid);
-		case GRPQUOTA:
-			return in_group_p(warn->w_dq_id.gid);
-		case PRJQUOTA:
-			return 1;
-	}
-	return 0;
-}
-
-/* Print warning to user which exceeded quota */
-static void print_warning(struct dquot_warn *warn)
-{
-	char *msg = NULL;
-	struct tty_struct *tty;
-	int warntype = warn->w_type;
-
-	if (warntype == QUOTA_NL_IHARDBELOW ||
-	    warntype == QUOTA_NL_ISOFTBELOW ||
-	    warntype == QUOTA_NL_BHARDBELOW ||
-	    warntype == QUOTA_NL_BSOFTBELOW || !need_print_warning(warn))
-		return;
-
-	tty = get_current_tty();
-	if (!tty)
-		return;
-	tty_write_message(tty, warn->w_sb->s_id);
-	if (warntype == QUOTA_NL_ISOFTWARN || warntype == QUOTA_NL_BSOFTWARN)
-		tty_write_message(tty, ": warning, ");
-	else
-		tty_write_message(tty, ": write failed, ");
-	tty_write_message(tty, quotatypes[warn->w_dq_id.type]);
-	switch (warntype) {
-		case QUOTA_NL_IHARDWARN:
-			msg = " file limit reached.\r\n";
-			break;
-		case QUOTA_NL_ISOFTLONGWARN:
-			msg = " file quota exceeded too long.\r\n";
-			break;
-		case QUOTA_NL_ISOFTWARN:
-			msg = " file quota exceeded.\r\n";
-			break;
-		case QUOTA_NL_BHARDWARN:
-			msg = " block limit reached.\r\n";
-			break;
-		case QUOTA_NL_BSOFTLONGWARN:
-			msg = " block quota exceeded too long.\r\n";
-			break;
-		case QUOTA_NL_BSOFTWARN:
-			msg = " block quota exceeded.\r\n";
-			break;
-	}
-	tty_write_message(tty, msg);
-	tty_kref_put(tty);
-}
-#endif
-
 static void prepare_warning(struct dquot_warn *warn, struct dquot *dquot,
 			    int warntype)
 {
@@ -1296,9 +1230,7 @@ static void flush_warnings(struct dquot_warn *warn)
 	for (i = 0; i < MAXQUOTAS; i++) {
 		if (warn[i].w_type == QUOTA_NL_NOWARN)
 			continue;
-#ifdef CONFIG_PRINT_QUOTA_WARNING
-		print_warning(&warn[i]);
-#endif
+
 		quota_send_warning(warn[i].w_dq_id,
 				   warn[i].w_sb->s_dev, warn[i].w_type);
 	}
@@ -3008,15 +2940,6 @@ static const struct ctl_table fs_dqstats_table[] = {
 		.mode		= 0444,
 		.proc_handler	= do_proc_dqstats,
 	},
-#ifdef CONFIG_PRINT_QUOTA_WARNING
-	{
-		.procname	= "warnings",
-		.data		= &flag_print_warnings,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 };
 
 static int __init dquot_init(void)
-- 
2.55.0

