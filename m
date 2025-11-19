Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E366349B0F;
	Wed, 19 Nov 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546516; cv=none; b=qI97iclX5qlLT9pHSDDJi59D7HuAeqf/90Nx9UFqbfa36mQKzrAe42z+wlZ582XGmB21MU4L9nKn91/25OSa1L1Iw0pVZAlHdJMR0kmoSJWllRsuFv2J3vaYpNPhd7sx9QIT5kG984daL1IKtz5v+RBkh2pUEPi+45K+Xz4ASHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546516; c=relaxed/simple;
	bh=dKYd4f9bTvh4dq4HOKmCrwwkBgqb3laCunGX/2ECfEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0Zh/ESyOlTSHJkw2/DkFlq/I5v8sQ7od2kBIHlNYKN0rPCHc1OErelFXe6B0mDppkORyQaelt88HhVAyLnRidtXNPVgRFEi/DT/RyUtnRxju2FcfThvoB+XMK+1fkgROxrfzOTceJS3JP6hydTIPFBcLtO7qMuHbLMai21oiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBQhxQo1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBQhxQo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467C4C4AF11;
	Wed, 19 Nov 2025 10:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546515;
	bh=dKYd4f9bTvh4dq4HOKmCrwwkBgqb3laCunGX/2ECfEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBQhxQo1TcBmIol8jiqeioVEa4oqEvySrqWplf6lo40CYSl+Vn/Mch0TYQViCRb9V
	 71vNbGpOjW4kHqTEYLaFKXk6K+2be/5MhG3vgQsTdzaxR62Gj9As2Rl7wICcqT5uek
	 PJexCe1U5BATqVFv9OAJL4dfReT+k3saRWa0B693xAJg9VXr9CUdeZ+FUyqBdni/zW
	 bJa8Ut3e6AkCqFJU9NSXduk3odNmd1o5y9SSc0ecHKuTXXncZxhDEabiXxgoPfsIqE
	 AuxOj1vlBpGeGQEN/eFmt9tH4KvuhK1PiYRcd2/6WtxVUUd+30RYO5apDY/A5W/uv4
	 gMVuwNSX6BaGw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/10] tty: vt/keyboard: use __free()
Date: Wed, 19 Nov 2025 11:01:36 +0100
Message-ID: <20251119100140.830761-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119100140.830761-1-jirislaby@kernel.org>
References: <20251119100140.830761-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vt/keyboard code can use __free to ensure the temporary buffers are
freed. Perform the switch.

And even one non-temporary in kbd_connect(). There are fail paths, so
ensure the buffer is freed in them and not when returning 0 -- by
retain_and_null_ptr().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/keyboard.c | 90 ++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 53 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index ee1d9c448c7e..65913a137862 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1566,10 +1566,9 @@ static bool kbd_match(struct input_handler *handler, struct input_dev *dev)
 static int kbd_connect(struct input_handler *handler, struct input_dev *dev,
 			const struct input_device_id *id)
 {
-	struct input_handle *handle;
 	int error;
 
-	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	struct input_handle __free(kfree) *handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
 
@@ -1579,18 +1578,18 @@ static int kbd_connect(struct input_handler *handler, struct input_dev *dev,
 
 	error = input_register_handle(handle);
 	if (error)
-		goto err_free_handle;
+		return error;
 
 	error = input_open_device(handle);
 	if (error)
 		goto err_unregister_handle;
 
+	retain_and_null_ptr(handle);
+
 	return 0;
 
  err_unregister_handle:
 	input_unregister_handle(handle);
- err_free_handle:
-	kfree(handle);
 	return error;
 }
 
@@ -1683,17 +1682,15 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 {
 	unsigned long flags;
 	int asize;
-	int ret = 0;
 
 	switch (cmd) {
 	case KDGKBDIACR:
 	{
 		struct kbdiacrs __user *a = udp;
-		struct kbdiacr *dia;
 		int i;
 
-		dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
-								GFP_KERNEL);
+		struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
+								  GFP_KERNEL);
 		if (!dia)
 			return -ENOMEM;
 
@@ -1713,20 +1710,17 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 		spin_unlock_irqrestore(&kbd_event_lock, flags);
 
 		if (put_user(asize, &a->kb_cnt))
-			ret = -EFAULT;
-		else  if (copy_to_user(a->kbdiacr, dia,
-				asize * sizeof(struct kbdiacr)))
-			ret = -EFAULT;
-		kfree(dia);
-		return ret;
+			return -EFAULT;
+		if (copy_to_user(a->kbdiacr, dia, asize * sizeof(struct kbdiacr)))
+			return -EFAULT;
+		return 0;
 	}
 	case KDGKBDIACRUC:
 	{
 		struct kbdiacrsuc __user *a = udp;
-		void *buf;
 
-		buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
-								GFP_KERNEL);
+		void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
+							GFP_KERNEL);
 		if (buf == NULL)
 			return -ENOMEM;
 
@@ -1740,18 +1734,17 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 		spin_unlock_irqrestore(&kbd_event_lock, flags);
 
 		if (put_user(asize, &a->kb_cnt))
-			ret = -EFAULT;
-		else if (copy_to_user(a->kbdiacruc, buf,
-				asize*sizeof(struct kbdiacruc)))
-			ret = -EFAULT;
-		kfree(buf);
-		return ret;
+			return -EFAULT;
+		if (copy_to_user(a->kbdiacruc, buf, asize * sizeof(struct kbdiacruc)))
+			return -EFAULT;
+
+		return 0;
 	}
 
 	case KDSKBDIACR:
 	{
 		struct kbdiacrs __user *a = udp;
-		struct kbdiacr *dia = NULL;
+		struct kbdiacr __free(kfree) *dia = NULL;
 		unsigned int ct;
 		int i;
 
@@ -1780,7 +1773,7 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 					conv_8bit_to_uni(dia[i].result);
 		}
 		spin_unlock_irqrestore(&kbd_event_lock, flags);
-		kfree(dia);
+
 		return 0;
 	}
 
@@ -1788,7 +1781,7 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 	{
 		struct kbdiacrsuc __user *a = udp;
 		unsigned int ct;
-		void *buf = NULL;
+		void __free(kfree) *buf = NULL;
 
 		if (!perm)
 			return -EPERM;
@@ -1811,11 +1804,10 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 					ct * sizeof(struct kbdiacruc));
 		accent_table_size = ct;
 		spin_unlock_irqrestore(&kbd_event_lock, flags);
-		kfree(buf);
 		return 0;
 	}
 	}
-	return ret;
+	return 0;
 }
 
 /**
@@ -1934,7 +1926,7 @@ static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 		unsigned char map, unsigned short val)
 {
 	unsigned long flags;
-	unsigned short *key_map, *new_map, oldval;
+	unsigned short *key_map, oldval;
 
 	if (!idx && val == K_NOSUCHMAP) {
 		spin_lock_irqsave(&kbd_event_lock, flags);
@@ -1965,7 +1957,7 @@ static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 		return 0;
 #endif
 
-	new_map = kmalloc(sizeof(plain_map), GFP_KERNEL);
+	unsigned short __free(kfree) *new_map = kmalloc(sizeof(plain_map), GFP_KERNEL);
 	if (!new_map)
 		return -ENOMEM;
 
@@ -1977,17 +1969,14 @@ static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 		if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
 		    !capable(CAP_SYS_RESOURCE)) {
 			spin_unlock_irqrestore(&kbd_event_lock, flags);
-			kfree(new_map);
 			return -EPERM;
 		}
-		key_maps[map] = new_map;
-		key_map = new_map;
+		key_map = key_maps[map] = no_free_ptr(new_map);
 		key_map[0] = U(K_ALLOCATED);
 		for (j = 1; j < NR_KEYS; j++)
 			key_map[j] = U(K_HOLE);
 		keymap_count++;
-	} else
-		kfree(new_map);
+	}
 
 	oldval = U(key_map[idx]);
 	if (val == oldval)
@@ -2050,8 +2039,6 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
 	unsigned char kb_func;
 	unsigned long flags;
-	char *kbs;
-	int ret;
 
 	if (get_user(kb_func, &user_kdgkb->kb_func))
 		return -EFAULT;
@@ -2063,7 +2050,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		/* size should have been a struct member */
 		ssize_t len = sizeof(user_kdgkb->kb_string);
 
-		kbs = kmalloc(len, GFP_KERNEL);
+		char __free(kfree) *kbs = kmalloc(len, GFP_KERNEL);
 		if (!kbs)
 			return -ENOMEM;
 
@@ -2071,20 +2058,20 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		len = strscpy(kbs, func_table[kb_func] ? : "", len);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 
-		if (len < 0) {
-			ret = -ENOSPC;
-			break;
-		}
-		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
-			-EFAULT : 0;
-		break;
+		if (len < 0)
+			return -ENOSPC;
+
+		if (copy_to_user(user_kdgkb->kb_string, kbs, len + 1))
+			return -EFAULT;
+
+		return 0;
 	}
 	case KDSKBSENT:
 		if (!perm || !capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 
-		kbs = strndup_user(user_kdgkb->kb_string,
-				sizeof(user_kdgkb->kb_string));
+		char __free(kfree) *kbs = strndup_user(user_kdgkb->kb_string,
+						       sizeof(user_kdgkb->kb_string));
 		if (IS_ERR(kbs))
 			return PTR_ERR(kbs);
 
@@ -2092,13 +2079,10 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		kbs = vt_kdskbsent(kbs, kb_func);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 
-		ret = 0;
-		break;
+		return 0;
 	}
 
-	kfree(kbs);
-
-	return ret;
+	return 0;
 }
 
 int vt_do_kdskled(unsigned int console, int cmd, unsigned long arg, int perm)
-- 
2.51.1

