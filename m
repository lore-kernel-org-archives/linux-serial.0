Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD521ABC1;
	Mon, 17 Mar 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194852; cv=none; b=iiJt0e1IbQwgAzA8Z/oBqapY5BZjtPAhH21dicysKweJnkEaWiUROOCzEGROH5o+4vC8fnhmbrJpbpcqETrm+e+2DP1SR0KHfm6Siow/AFhidDWWeTSboqF0evWDIJv3pFQz/wuWK8PF0n/ErcpzdIjeIMQE+0JfGLbyzhb8e8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194852; c=relaxed/simple;
	bh=H65w1BJPAbZCNhtchN+PJYXQMlXLUApLJleN6WyRzh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdwr8PPCdtSIvZgVRxpFvQfeeRCgcQHfm1A7kF15ZUn4dtOwm20lNB3g8AIQMNQlGcYYamO8a3zbTrR/G6TG6DSImyoJZ4bdYX64hb/z+T3RNCtvFT+87nupc3YisJTkY3BJjNN4H6hwVEQH2zcjFIM48qxvRxDGoi+P4v1v1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSac9s7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSac9s7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B16C4CEE3;
	Mon, 17 Mar 2025 07:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194852;
	bh=H65w1BJPAbZCNhtchN+PJYXQMlXLUApLJleN6WyRzh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSac9s7H+bVOm6e1kRMaRjnkfFcJfg4yyp8fSJstl8LZaEK2ScpcSX5r5/0LWJ3DV
	 HJlf/0brSNLeoAiWwypGQhg4PhX6eZAhPwYH7JLDBhW3eUm8efkEOFbsiO1mzSQDdN
	 L8wJNvYpnOl8C6EDMLAwBhUrtDXFPrOsP5tz8AsdtKo6Av+gvUwvIdftqs+e4nz2ux
	 H3QPe5+ddU7rBa7ZiKhzQkDB8wJeNmX+ffti8xmpcGzweIN9Xw2+2lEbGlyaNv45Nj
	 iqV9GlY2fVcvDtuLt4bdHQKa7CGqLZ7YxrA6iCPuAbliR50K4Xjxpj2Qth6Y1k1ybi
	 tbCDEF7Dj006g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 02/31] tty: audit: do not use N_TTY_BUF_SIZE
Date: Mon, 17 Mar 2025 08:00:17 +0100
Message-ID: <20250317070046.24386-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
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
2.49.0

