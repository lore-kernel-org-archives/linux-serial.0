Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05BB342C9A
	for <linux-serial@vger.kernel.org>; Thu, 26 Feb 2026 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109270; cv=none; b=Tze/D14wBKJ/4UhrMak+FJVYTqhEkc0TCaTvKpH8vwtP7dk+3mIsDwWBMmef4CRUDIqlEVu5pejf0NSrv/cZEQ/uHKlfgMOt4Xku6Nn93TEHOv5M095rwYPpGYMg6qHyN4D6XW+8csaSkzKOLL8H903CpZgGiFarXA/REZVtsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109270; c=relaxed/simple;
	bh=9vIYzS11mqIcuwkKjbfhwc0/aVTNfCHNpziZPqgHUY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AhWX4WIlhbeLkXYBa/bCje3yamSJa1EWgLZpe9COgD3ZMOvZfaGgm+zJqQcrNsiJVSuLpTC7xIq+iIp2NMukwO14qhr2NOya8A1RvfnjyEQe9JsHso7EZA9Z0cAQGda/e4iaGAAW2H0RrBx5t8M4PCQJwCO/mlsyHKnyaXDvWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCRz++mI; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vCRz++mI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772109266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M9v2hup5Z8gTFtASdF19MngX3ZYM5GQ8wWyVvYXft2k=;
	b=vCRz++mIwaZPv24iQJt/oTzbTb7gfX73NzGfYRLeW2X66zheM/nUtFlwFeyMAIXsXvqvtE
	2AehFgJM8DweFy5sbZ+l9iJIgt3pK0rihSJGwzT0cPuDen+GOMieC9QyzX3ryDOLi5HbY3
	AQhNFmHInlqtDHwTAwIYOSjCNLZuo5o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexey Gladkov <legion@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: vt/keyboard: Hoist and reuse variable in vt_do_kdgkb_ioctl
Date: Thu, 26 Feb 2026 13:34:13 +0100
Message-ID: <20260226123419.737669-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hoist 'len' and use it in both cases.

The last 'kbs' assignment is useless and a leftover from commit
bfb24564b5fd ("tty: vt/keyboard: use __free()"). Remove it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/tty/vt/keyboard.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index d65fc60dd7be..6a1044f87216 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1991,17 +1991,18 @@ static char *vt_kdskbsent(char *kbs, unsigned char cur)
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
 	unsigned char kb_func;
+	ssize_t len;
 
 	if (get_user(kb_func, &user_kdgkb->kb_func))
 		return -EFAULT;
 
 	kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);
 
+	/* size should have been a struct member */
+	len = sizeof(user_kdgkb->kb_string);
+
 	switch (cmd) {
 	case KDGKBSENT: {
-		/* size should have been a struct member */
-		ssize_t len = sizeof(user_kdgkb->kb_string);
-
 		char __free(kfree) *kbs = kmalloc(len, GFP_KERNEL);
 		if (!kbs)
 			return -ENOMEM;
@@ -2022,12 +2023,12 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 			return -EPERM;
 
 		char __free(kfree) *kbs = strndup_user(user_kdgkb->kb_string,
-						       sizeof(user_kdgkb->kb_string));
+						       len);
 		if (IS_ERR(kbs))
 			return PTR_ERR(kbs);
 
 		guard(spinlock_irqsave)(&func_buf_lock);
-		kbs = vt_kdskbsent(kbs, kb_func);
+		vt_kdskbsent(kbs, kb_func);
 
 		return 0;
 	}
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

