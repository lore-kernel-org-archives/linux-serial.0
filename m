Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186F3CB548
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856999; cv=none; b=SDKa1o5yLUZt1B1j0/U8sgpLmFRMpHghgC+aYPqCIjwff8UDv5uU2IYcN2NuC/1fNNK/H9cM9mxzcxR7CDvYquj5JSYAtexJacSsmjN/BbckogwPCjq9nqgN8ZBO8ktwqc7mA6TdiA2PlZfiTyF455+6RxdX5zyyTG5Zzy+jcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856999; c=relaxed/simple;
	bh=Ix7DghB6muBQigIXdXbebwT/3eu8lLlJpGnoq35FY+M=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=BX79MIiAW/qWxlqfRQDatxToTi1X8EUKZauC7kbEDJ5Wb7JDqsvDnL1qB0uQrNQWM75A4hRe3wbQrUpoxXpOOVPPFytS7sgW0issW96oOKLH0jJ82BmVQI9xhlaugr6ih5TOS2+5c07MkyzjeYLVKCi5AYyRjlgU8CqnbFJfJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 24245 invoked by uid 3782); 27 Aug 2026 20:56:32 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 20:56:31 +0200
Received: (qmail 31193 invoked by uid 1000); 27 Aug 2026 18:56:31 -0000
Date: Thu, 27 Aug 2026 18:56:30 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: acm@muc.de
Subject: [Patch 8/9]: vt: Enhancements to the VT ioctl interface
Message-ID: <apCIXtwoPY_a3QOi@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCEDM2sWv_M354-@MAC.fritz.box>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

vt: 32b glyph: 10. Enhancements to the VT ioctl interface

Handle the current 16-bit P/GIO_UNIMAP ioctls by converting
to/from 32-bit code-points/glyph numbers.  Add handling for new
32-bit ioctls P/GIO_UNIMAP21.  Convert to and from __user in
vt_ioctl.c rather than in vt.c or consolemap.c.

Signed-off-by: Alan Mackenzie <acm@muc.de>

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 28993a3d0acb..05986430e1bb 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/console.h>
-#include <linux/consolemap.h>
 #include <linux/signal.h>
 #include <linux/suspend.h>
 #include <linux/timex.h>
@@ -36,6 +35,7 @@
 
 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
+#include <linux/consolemap.h>
 #include <linux/kbd_diacr.h>
 #include <linux/selection.h>
 
@@ -484,10 +484,155 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 	return 0;
 }
 
+#ifdef CONFIG_FB_GLYPH_21BIT
+static int vt__user_unipair_8_to_21(unsigned int ct,
+				    struct unipair __user *entries,
+				    struct unipair21 **tmp21_entries)
+{
+	struct unipair *tmp_entries;
+	int i, ret = 0;
+
+	tmp_entries = kmalloc_array(ct, sizeof(struct unipair), GFP_KERNEL);
+	if (!tmp_entries)
+		return -ENOMEM;
+	if (copy_from_user(tmp_entries, entries, ct * sizeof(struct unipair))) {
+		ret = -EFAULT;
+		goto free_tmp;
+	}
+	*tmp21_entries = kmalloc_array(ct, sizeof(struct unipair21), GFP_KERNEL);
+	if (!*tmp21_entries) {
+		ret = -ENOMEM;
+		goto free_tmp;
+	}
+	for (i = 0; i < ct; i++) {
+		(*tmp21_entries)[i].unicode = tmp_entries[i].unicode;
+		(*tmp21_entries)[i].fontpos = tmp_entries[i].fontpos;
+	}
+free_tmp: kfree(tmp_entries);
+	return ret;
+}
+
+static int vt_unipair_21_to__user_8(unsigned int ct,
+				    struct unipair21 *entries21,
+				    struct unipair __user *entries)
+{
+	struct unipair *tmp_entries;
+	int i, ret = 0;
+
+	tmp_entries = kmalloc_array(ct, sizeof(struct unipair), GFP_KERNEL);
+	if (!tmp_entries)
+		return -ENOMEM;
+	for (i = 0; i < ct; i++) {
+		if ((entries21[i].unicode > 0xffff) ||
+		    (entries21[i].fontpos > 0xffff)) {
+			ret = -EINVAL;
+			goto free_tmp;
+		}
+		tmp_entries[i].unicode = entries21[i].unicode;
+		tmp_entries[i].fontpos = entries21[i].fontpos;
+	}
+	if (copy_to_user(entries, tmp_entries, ct * sizeof(struct unipair)))
+		ret = -EFAULT;
+free_tmp: kfree(tmp_entries);
+	return ret;
+}
+
 static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud,
 		bool perm, struct vc_data *vc)
 {
 	struct unimapdesc tmp;
+	struct unipair21 *tmp21_entries = NULL;
+	int ret = 0, ret1 = 0;
+	unsigned int ct;
+
+	if (copy_from_user(&tmp, user_ud, sizeof(tmp)))
+		return -EFAULT;
+	switch (cmd) {
+	case PIO_UNIMAP:
+		if (!perm)
+			return -EPERM;
+		ret = vt__user_unipair_8_to_21(tmp.entry_ct, tmp.entries,
+					       &tmp21_entries);
+		if (ret)
+			return ret;
+		ret = con_set_unimap(vc, tmp.entry_ct, tmp21_entries);
+		kfree(tmp21_entries);
+		return ret;
+
+	case GIO_UNIMAP:
+		if (!perm && fg_console != vc->vc_num)
+			return -EPERM;
+		tmp21_entries = kmalloc_array(tmp.entry_ct,
+					      sizeof(struct unipair21),
+					      GFP_KERNEL);
+		if (!tmp21_entries)
+			return -ENOMEM;
+		ret = con_get_unimap(vc, tmp.entry_ct, &ct, tmp21_entries);
+		if (ret)
+			goto free_tmp21;
+		ret = vt_unipair_21_to__user_8(ct, tmp21_entries, tmp.entries);
+free_tmp21:	ret1 = put_user(ct, &user_ud->entry_ct);
+		kfree(tmp21_entries);
+		return ret ? ret : ret1;
+	}
+	return 0;
+}
+
+static inline int do_unimap_ioctl21(int cmd, struct unimapdesc21 __user *user_ud,
+		bool perm, struct vc_data *vc)
+{
+	struct unimapdesc21 tmp;
+	struct unipair21 *k_entries;
+	int ret = 0, ret1 = 0;
+
+	if (copy_from_user(&tmp, user_ud, sizeof(tmp)))
+		return -EFAULT;
+	switch (cmd) {
+	case PIO_UNIMAP21:
+		if (!perm)
+			return -EPERM;
+		k_entries = kmalloc_array(tmp.entry_ct,
+					  sizeof(struct unipair21),
+					  GFP_KERNEL);
+		if (!k_entries)
+			return -ENOMEM;
+		if (copy_from_user(k_entries, tmp.entries,
+				   tmp.entry_ct * sizeof(struct unipair21))) {
+			ret = -EFAULT;
+			goto free_k_entries;
+		}
+		ret = con_set_unimap(vc, tmp.entry_ct, k_entries);
+free_k_entries: kfree(k_entries);
+		return ret;
+	case GIO_UNIMAP21:
+		if (!perm && fg_console != vc->vc_num)
+			return -EPERM;
+		k_entries = kmalloc_array(tmp.entry_ct,
+					  sizeof(struct unipair21),
+					  GFP_KERNEL);
+		if (!k_entries)
+			return -ENOMEM;
+		ret = con_get_unimap(vc, tmp.entry_ct, &tmp.entry_ct,
+				     k_entries);
+		if (ret)
+			goto free_k_entries1;
+		if (copy_to_user(tmp.entries, k_entries,
+				 tmp.entry_ct * sizeof(struct unipair21)))
+			ret = -EFAULT;
+free_k_entries1: ret1 = put_user(tmp.entry_ct, &user_ud->entry_ct);
+		kfree(k_entries);
+		return ret ? ret : ret1;
+	}
+	return 0;
+}
+
+#else
+static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud,
+		bool perm, struct vc_data *vc)
+{
+	struct unimapdesc tmp;
+	struct unipair *k_entries;
+	int ret = 0, ret1 = 0;
 
 	if (copy_from_user(&tmp, user_ud, sizeof tmp))
 		return -EFAULT;
@@ -495,15 +640,41 @@ static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud,
 	case PIO_UNIMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_unimap(vc, tmp.entry_ct, tmp.entries);
+		k_entries = kmalloc_array(tmp.entry_ct,
+					  sizeof(struct unipair),
+					  GFP_KERNEL);
+		if (!k_entries)
+			return -ENOMEM;
+		if (copy_from_user(k_entries, tmp.entries,
+				   tmp.entry_ct * sizeof(struct unipair))) {
+			ret = -EFAULT;
+			goto free_k_entries;
+		}
+		ret = con_set_unimap(vc, tmp.entry_ct, k_entries);
+free_k_entries: kfree(k_entries);
+		return ret;
 	case GIO_UNIMAP:
 		if (!perm && fg_console != vc->vc_num)
 			return -EPERM;
-		return con_get_unimap(vc, tmp.entry_ct, &(user_ud->entry_ct),
-				tmp.entries);
+		k_entries = kmalloc_array(tmp.entry_ct,
+					  sizeof(struct unipair),
+					  GFP_KERNEL);
+		if (!k_entries)
+			return -ENOMEM;
+		ret = con_get_unimap(vc, tmp.entry_ct, &tmp.entry_ct,
+				     k_entries);
+		if (ret)
+			goto free_k_entries1;
+		if (copy_to_user(tmp.entries, k_entries,
+				 tmp.entry_ct * sizeof(struct unipair)))
+			ret = -EFAULT;
+free_k_entries1: ret1 = put_user(tmp.entry_ct, &user_ud->entry_ct);
+		kfree(k_entries);
+		return ret ? ret : ret1;
 	}
 	return 0;
 }
+#endif /* CONFIG_FB_GLYPH_21BIT */
 
 static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
 		bool perm)
@@ -543,6 +714,12 @@ static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
 	case GIO_UNIMAP:
 		return do_unimap_ioctl(cmd, up, perm, vc);
 
+#ifdef CONFIG_FB_GLYPH_21BIT
+	case PIO_UNIMAP21:
+	case GIO_UNIMAP21:
+		return do_unimap_ioctl21(cmd, up, perm, vc);
+#endif
+
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -1026,16 +1203,20 @@ compat_kdfontop_ioctl(struct compat_console_font_op __user *fontop,
 }
 
 struct compat_unimapdesc {
-	unsigned short entry_ct;
+	u16 entry_ct;
 	compat_caddr_t entries;
 };
 
+#ifdef CONFIG_FB_GLYPH_21BIT
 static inline int
 compat_unimap_ioctl(unsigned int cmd, struct compat_unimapdesc __user *user_ud,
 			 int perm, struct vc_data *vc)
 {
 	struct compat_unimapdesc tmp;
 	struct unipair __user *tmp_entries;
+	struct unipair21 *tmp21_entries = NULL;
+	int ret = 0, ret1 = 0;
+	unsigned int ct;
 
 	if (copy_from_user(&tmp, user_ud, sizeof tmp))
 		return -EFAULT;
@@ -1044,14 +1225,83 @@ compat_unimap_ioctl(unsigned int cmd, struct compat_unimapdesc __user *user_ud,
 	case PIO_UNIMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_unimap(vc, tmp.entry_ct, tmp_entries);
+		ret = vt__user_unipair_8_to_21(tmp.entry_ct, tmp_entries,
+					       &tmp21_entries);
+		if (ret)
+			return ret;
+		ret = con_set_unimap(vc, tmp.entry_ct, tmp21_entries);
+		kfree(tmp21_entries);
+		return ret;
+
 	case GIO_UNIMAP:
 		if (!perm && fg_console != vc->vc_num)
 			return -EPERM;
-		return con_get_unimap(vc, tmp.entry_ct, &(user_ud->entry_ct), tmp_entries);
+		tmp21_entries = kmalloc_array(tmp.entry_ct,
+					      sizeof(struct unipair21),
+					      GFP_KERNEL);
+		if (!tmp21_entries)
+			return -ENOMEM;
+		ret = con_get_unimap(vc, tmp.entry_ct, &ct, tmp21_entries);
+		if (ret)
+			goto free_tmp21;
+		ret = vt_unipair_21_to__user_8(ct, tmp21_entries, tmp_entries);
+free_tmp21:	ret1 = put_user(ct, &user_ud->entry_ct);
+		kfree(tmp21_entries);
+		return ret ? ret : ret1;
+	}
+	return 0;
+}
+#else
+static inline int
+compat_unimap_ioctl(unsigned int cmd, struct compat_unimapdesc __user *user_ud,
+			 int perm, struct vc_data *vc)
+{
+	struct compat_unimapdesc tmp;
+	struct unipair __user *tmp_entries;
+	struct unipair *k_entries;
+	int ret = 0, ret1 = 0;
+
+	if (copy_from_user(&tmp, user_ud, sizeof(tmp)))
+		return -EFAULT;
+	tmp_entries = compat_ptr(tmp.entries);
+	switch (cmd) {
+	case PIO_UNIMAP:
+		if (!perm)
+			return -EPERM;
+		k_entries = kmalloc_array(tmp.entry_ct,
+					  sizeof(struct unipair),
+					  GFP_KERNEL);
+		if (!k_entries)
+			return -ENOMEM;
+		if (copy_from_user(k_entries, tmp_entries,
+				   tmp.entry_ct * sizeof(struct unipair))) {
+			ret = -EFAULT;
+			goto free_k_entries;
+		}
+		ret = con_set_unimap(vc, tmp.entry_ct, k_entries);
+free_k_entries: kfree(k_entries);
+		return ret;
+	case GIO_UNIMAP:
+		if (!perm && fg_console != vc->vc_num)
+			return -EPERM;
+		k_entries = kmalloc_array(tmp.entry_ct, sizeof(struct unipair),
+					  GFP_KERNEL);
+		if (!k_entries)
+			return -ENOMEM;
+		ret = con_get_unimap(vc, tmp.entry_ct, &tmp.entry_ct,
+				     k_entries);
+		if (ret)
+			goto free_k_entries1;
+		if (copy_to_user(tmp_entries, k_entries,
+				 tmp.entry_ct * sizeof(struct unipair)))
+			ret = -EFAULT;
+free_k_entries1: ret1 = put_user(tmp.entry_ct, &user_ud->entry_ct);
+		kfree(k_entries);
+		return ret ? ret : ret1;
 	}
 	return 0;
 }
+#endif /* CONFIG_FB_GLYPH_21BIT */
 
 long vt_compat_ioctl(struct tty_struct *tty,
 	     unsigned int cmd, unsigned long arg)
diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index 6b384065c013..342654dfbc16 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -56,7 +56,7 @@ typedef char scrnmap_t;
 #define GIO_SCRNMAP	0x4B40	/* get screen mapping from kernel */
 #define PIO_SCRNMAP	0x4B41	/* put screen mapping table in kernel */
 #define GIO_UNISCRNMAP  0x4B69	/* get full Unicode screen mapping */
-#define PIO_UNISCRNMAP  0x4B6A  /* set full Unicode screen mapping */
+#define PIO_UNISCRNMAP  0x4B6A	/* set full Unicode screen mapping */
 
 #define GIO_UNIMAP	0x4B66	/* get unicode-to-font mapping from kernel */
 struct unipair {
@@ -67,8 +67,19 @@ struct unimapdesc {
 	unsigned short entry_ct;
 	struct unipair __user *entries;
 };
+struct unipair21 {
+	unsigned int unicode;
+	unsigned int fontpos;
+};
+struct unimapdesc21 {
+	unsigned int entry_ct;
+	struct unipair21 __user *entries;
+};
 #define PIO_UNIMAP	0x4B67	/* put unicode-to-font mapping in kernel */
 #define PIO_UNIMAPCLR	0x4B68	/* clear table, possibly advise hash algorithm */
+#define GIO_UNIMAP21	0x4B6E	/* get 21-bit unicode-to-font mapping from kernel */
+#define PIO_UNIMAP21	0x4B6F	/* put 21-bit unicode-to-font mapping to kernel */
+
 struct unimapinit {
 	unsigned short advised_hashsize;  /* 0 if no opinion */
 	unsigned short advised_hashstep;  /* 0 if no opinion */
@@ -185,6 +196,6 @@ struct console_font {
 
 /* note: 0x4B00-0x4B4E all have had a value at some time;
    don't reuse for the time being */
-/* note: 0x4B60-0x4B6D, 0x4B70-0x4B72 used above */
+/* note: 0x4B60-0x4B6F, 0x4B70-0x4B72 used above */
 
 #endif /* _UAPI_LINUX_KD_H */
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index d008c3d0a9bb..af99aeefe177 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -90,13 +96,13 @@ static inline int con_clear_unimap(struct vc_data *vc)
 	return 0;
 }
 static inline
-int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
+int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair *list)
 {
 	return 0;
 }
 static inline
-int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
-		   struct unipair __user *list)
+int con_get_unimap(struct vc_data *vc, ushort ct, ushort *uct,
+		   struct unipair *list)
 {
 	return -EINVAL;
 }


-- 
Alan Mackenzie (Nuremberg, Germany).
