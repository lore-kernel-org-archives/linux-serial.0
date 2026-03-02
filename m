Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B41DF261
	for <linux-serial@vger.kernel.org>; Mon,  2 Mar 2026 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465619; cv=none; b=dO1Mhmf2/TE+IkGefdDTlt+uA3F4XK89iCGSzb5Ke9LnZsuzJmxarwMQPRNbLYE+VZAzxw8ymVygBNIhI4NMS7iqqaMYFMCWDdbCfKpKjunRkfiitQ2lJXqtwHHSJWDG5tdTS2XXqMmywvG+P4cAt7mxXSaCRj1G2GRPpdlsAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465619; c=relaxed/simple;
	bh=MNNJW2hRro9P65HIlDA8urdHBCBxnBx2+T6R000SmPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzFkw+U8IJWQVmgfVG7kBbICHTEf5xtjZsvQ+h4asH3lYbemx5n5fhwpNTDld+E8UzrcotYfV8UFhPgZYPHl+XqUVQAb09iSRpiIWXt/e0inqy0G3H+QXhcMiX3cC699lcLWQmpPDs+0R89OOUlBpGbr+HcZLyOUCTA7YyYZ8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYbV9COL; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYbV9COL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772465606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VqZ/SnJ6Zhkv9bCWgs5o2lPKwZpFSb8Xw8sTXDIFygY=;
	b=nYbV9COLHWj0r73nw4qdAGbqG+R9eLgUEPYpjb4/rosTTfMbXjpwmWYomrEIwTawMQ5zFy
	w3wUAJuqap27Cvn944wxh19Hh75yRQeb1zeqF2gInHrxxhI+C/tbeYnfHO6Trkz8dakadX
	VFeArTgq2NF8S+n4U49m4Ye94ItEkx4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexey Gladkov <legion@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2] tty: vt/keyboard: Hoist and reuse variable in vt_do_kdgkb_ioctl
Date: Mon,  2 Mar 2026 16:32:52 +0100
Message-ID: <20260302153255.6278-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hoist 'len' and use it in both cases.

Add a comment explaining why reassigning 'kbs' is intentional.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Keep 'kbs' reassignment and add a comment why it's required (Jiri)
- Link to v1: https://lore.kernel.org/lkml/20260226123419.737669-1-thorsten.blum@linux.dev/
---
 drivers/tty/vt/keyboard.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 13bc048f45e8..88fd4ef2634a 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2000,17 +2000,18 @@ static char *vt_kdskbsent(char *kbs, unsigned char cur)
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
@@ -2031,11 +2032,16 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 			return -EPERM;
 
 		char __free(kfree) *kbs = strndup_user(user_kdgkb->kb_string,
-						       sizeof(user_kdgkb->kb_string));
+						       len);
 		if (IS_ERR(kbs))
 			return PTR_ERR(kbs);
 
 		guard(spinlock_irqsave)(&func_buf_lock);
+
+		/*
+		 * Ownership transfer: vt_kdskbsent() returns a pointer
+		 * that must be freed (new buffer, old buffer, or NULL).
+		 */
 		kbs = vt_kdskbsent(kbs, kb_func);
 
 		return 0;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

