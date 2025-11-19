Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D61349B05;
	Wed, 19 Nov 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546517; cv=none; b=TVH8OvlxnxIht66821GhkpZ7tGtVjed4C+SzuXqwvBnZj020nlmPbHNK7DxdovZ4nrWHpb6/6wUixn/UMvpwQ4YgbpMx8A2VtuNgI93TopQpbYxvTyl9/VcCb47jpb0+gZjJkLRCtl+DNo51M18vK1Fjfyc0OOpaq4WD2CnrFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546517; c=relaxed/simple;
	bh=/hB2Tk5p5xB7+eWRu0lZ/bqHN+XZ3Xw1NNg2bA4CdNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxC2QQbcMpZ8fTC3vtmx0xXQlM9eOjry6SRr0SRrcomjGqxJe7oAKgv9mNainrqyWDzApAhawfLLQkTikqNNgNzQwvX1Pq1sHmJP9RxikRoEqfuBaMDFenIUw5vfbRplkQkHGSQb4kzze4Al2XyXXdUedc2zx95s9wu6DKnWUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqYqe6qa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqYqe6qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F514C19421;
	Wed, 19 Nov 2025 10:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546517;
	bh=/hB2Tk5p5xB7+eWRu0lZ/bqHN+XZ3Xw1NNg2bA4CdNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqYqe6qawKmo0p8wMjFiMWCRHT8hfREQi4YQVyCwVsiC5LLpFGTbeY2YiVOGESHBN
	 TjmYLNcRbWg8DGtihdyx3vIBxTAkUI2duqvdLiSPH67zr2VvBvyJAKTmwWi04N1/+0
	 i+KbfK4wupDxYLT4r0Zg/nV6BEdoHQARX8YQRMfa011VemzB3OmbM/NmJ53SAoxKGB
	 cuw5vp6v4F7pkRnmZ+NfHitCWPmVI3QsbGwRi5oe9om0IVDDv9VO9IzfEhPAtWX24f
	 pTil/2shcYL8j8eKXSQEmR+3fTS7VpG4yRtKagLkXXOFfkLhdbasURfYeybhYP4qwS
	 4+eo4KEVC/FKg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/10] tty: vt/keyboard: simplify returns from vt_do_kbkeycode_ioctl()
Date: Wed, 19 Nov 2025 11:01:37 +0100
Message-ID: <20251119100140.830761-8-jirislaby@kernel.org>
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

Return immediately when something goes wrong in vt_do_kbkeycode_ioctl().
This makes the code flow more obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/keyboard.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 65913a137862..487518a696e6 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1879,27 +1879,27 @@ int vt_do_kdskbmeta(unsigned int console, unsigned int arg)
 	return ret;
 }
 
-int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc,
-								int perm)
+int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc, int perm)
 {
 	struct kbkeycode tmp;
-	int kc = 0;
+	int kc;
 
 	if (copy_from_user(&tmp, user_kbkc, sizeof(struct kbkeycode)))
 		return -EFAULT;
+
 	switch (cmd) {
 	case KDGETKEYCODE:
 		kc = getkeycode(tmp.scancode);
-		if (kc >= 0)
-			kc = put_user(kc, &user_kbkc->keycode);
-		break;
+		if (kc < 0)
+			return kc;
+		return put_user(kc, &user_kbkc->keycode);
 	case KDSETKEYCODE:
 		if (!perm)
 			return -EPERM;
-		kc = setkeycode(tmp.scancode, tmp.keycode);
-		break;
+		return setkeycode(tmp.scancode, tmp.keycode);
 	}
-	return kc;
+
+	return 0;
 }
 
 static unsigned short vt_kdgkbent(unsigned char kbdmode, unsigned char idx,
-- 
2.51.1

