Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9901F4265;
	Thu, 20 Feb 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050176; cv=none; b=MFCOvOaBi/sYaMGh2KkKrOeH2SMFJ4Oaa0jBD2wybLkFbEPk061B32wyQE84E0ODwq9HFdONt/aRnN8YHuFqWUxfGfezmWlqFew+B+M57HA2PW233sMURGp4jc4D3aipxIc8b6J3MJbhnGGu4h37xacQhEBlB23XQYt5QIjK1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050176; c=relaxed/simple;
	bh=O19YTMIm9L4XBACdObvLfyV9RoqxzulC5kKd2UrlfCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt/uUxpvZQncw0pJ5D9SQcTFzucoVkHubcxvVEd/iyWjgUdq0G8qJf/xMCALSnOshUnF+6q8drU8A0etwsLBjM8cEumagomlL5jPk+PHZlf7Fpso+iJgYRbGHUNjZCjFpBf5gH832/3a2mGFU6EJLWHd7pnO8l6CBwQFpSw4E9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP+I+EtN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP+I+EtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2CFC4CEE4;
	Thu, 20 Feb 2025 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050176;
	bh=O19YTMIm9L4XBACdObvLfyV9RoqxzulC5kKd2UrlfCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pP+I+EtN56CYByyi2xlyXsXtrPWqCKSlJBrDPx2Jk2yux2mfEKYSto0eNSicz5a+E
	 QGiAKx9JnkJDJjjTIzGCdmoizlnU45W1f1+AN5qOQ5y1WBPRpDeiKXQSYGXlOIlfFr
	 anTRet/b8AG4Lv4/JcUsFnk8Ks0WzgLcJI5tea2yFHNT6aMCI9PR5vJnBTYaLDgTz+
	 927tkxxgjuzbKuse4Rf8D32nC3HgBbw98mCiNsaAvRvVL1VDYw4oD3Ho6CHMHAV7l3
	 r77r4qCYnrq53oH31dLXXQjDfM0zajGGqlWs91jTL4ttRrMvuhvvxbTyp5bkOqYbrb
	 hU+mRqxcrPLIA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/29] tty: audit: do not use N_TTY_BUF_SIZE
Date: Thu, 20 Feb 2025 12:15:39 +0100
Message-ID: <20250220111606.138045-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

N_TTY_BUF_SIZE -- as the name suggests -- is the N_TTY's buffer size.
There is no reason to couple that to audit's buffer size, so define an
own TTY_AUDIT_BUF_SIZE macro (with the same size).

N_TTY_BUF_SIZE is private and will be moved to n_tty.c later.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_audit.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 1d81eeefb068..75542333c54a 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -12,12 +12,14 @@
 #include <linux/tty.h>
 #include "tty.h"
 
+#define TTY_AUDIT_BUF_SIZE	4096
+
 struct tty_audit_buf {
 	struct mutex mutex;	/* Protects all data below */
 	dev_t dev;		/* The TTY which the data is from */
 	bool icanon;
 	size_t valid;
-	u8 *data;		/* Allocated size N_TTY_BUF_SIZE */
+	u8 *data;		/* Allocated size TTY_AUDIT_BUF_SIZE */
 };
 
 static struct tty_audit_buf *tty_audit_buf_ref(void)
@@ -37,7 +39,7 @@ static struct tty_audit_buf *tty_audit_buf_alloc(void)
 	if (!buf)
 		goto err;
 
-	buf->data = kmalloc(N_TTY_BUF_SIZE, GFP_KERNEL);
+	buf->data = kmalloc(TTY_AUDIT_BUF_SIZE, GFP_KERNEL);
 	if (!buf->data)
 		goto err_buf;
 
@@ -235,14 +237,14 @@ void tty_audit_add_data(const struct tty_struct *tty, const void *data,
 	do {
 		size_t run;
 
-		run = N_TTY_BUF_SIZE - buf->valid;
+		run = TTY_AUDIT_BUF_SIZE - buf->valid;
 		if (run > size)
 			run = size;
 		memcpy(buf->data + buf->valid, data, run);
 		buf->valid += run;
 		data += run;
 		size -= run;
-		if (buf->valid == N_TTY_BUF_SIZE)
+		if (buf->valid == TTY_AUDIT_BUF_SIZE)
 			tty_audit_buf_push(buf);
 	} while (size != 0);
 	mutex_unlock(&buf->mutex);
-- 
2.48.1

