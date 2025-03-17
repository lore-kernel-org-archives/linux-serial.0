Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DB21C9F3;
	Mon, 17 Mar 2025 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194864; cv=none; b=ZX1fLgQH2FZTHmmegm4zsEZWhx4ujPgnrIvBFXCfr54RAd17b7VQeXC+UXy+4B5QSaBi/HY2Rx02Jy+UUChmLnHQXN+LV2w6RX4H3MUu33m9WV53qPa51TVs6Ayh0pwqcwd5jkDIJGYH3qeMxWyNcixBgVHL6y+rZNu0ZmmJK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194864; c=relaxed/simple;
	bh=q78Y+Vzll7F5ggoZ4T8kmkLDhTPdIC9TLxncg6aCgSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMAmFp3ENn080vi5vVHVXn6MtchpQHDbuHL/fE4faTNokq+hQSFQ568h1bcxMw0wchHV8xM61oCJARGybZGvirphjoUixaDgo4M8cupGwUDx0Tu/M3RiCA5gLyMlqObHVYNz/AHPZOwOnC/y0yq5w0v/ZivIu+3LZxZNlYxmBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0mJwRJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0mJwRJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D13C4CEE3;
	Mon, 17 Mar 2025 07:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194864;
	bh=q78Y+Vzll7F5ggoZ4T8kmkLDhTPdIC9TLxncg6aCgSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0mJwRJ6tvV6RJDF7vozw2nFkv+JzyoXPbUnC0f3BiDVmhg570pXEXEHNC5ujvWqC
	 1h1v8nxYv9MAF7Ctjf4GrPBe9OC4WE2WAw2Ch2PnoIDWhx2d2wNPgXo7wiXeDJo8km
	 BlLkbZ1BYv5TDjVQI8LA5TQN1w9F2O8EibUrLVhDNQg8UzxQCLrPC/4UA9LDcHl7ZA
	 SokTVss6NVvo/DlyPb5hqx2dMThjClbkIpsOU3u/SAF+cxsf8eoThT5wJH2LBKD7+h
	 cCHggq8WWEtWZzDXx+JpxeualZkIi8H7vJRwf9wYX/xBUUAYySm/TItyiBF0CulPGd
	 WskuAtSysLWVw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 09/31] tty: n_tty: extract n_tty_continue_cookie() from n_tty_read()
Date: Mon, 17 Mar 2025 08:00:24 +0100
Message-ID: <20250317070046.24386-10-jirislaby@kernel.org>
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

n_tty_read() is a very long function doing too much of different stuff.
Extract the "cookie" (continuation read) handling to a separate
function: n_tty_continue_cookie().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 43ba740792d9..88aa5f9cbe5e 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2111,6 +2111,39 @@ static int job_control(struct tty_struct *tty, struct file *file)
 	return __tty_check_change(tty, SIGTTIN);
 }
 
+/*
+ * We still hold the atomic_read_lock and the termios_rwsem, and can just
+ * continue to copy data.
+ */
+static ssize_t n_tty_continue_cookie(struct tty_struct *tty, u8 *kbuf,
+				   size_t nr, void **cookie)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	u8 *kb = kbuf;
+
+	if (ldata->icanon && !L_EXTPROC(tty)) {
+		/*
+		 * If we have filled the user buffer, see if we should skip an
+		 * EOF character before releasing the lock and returning done.
+		 */
+		if (!nr)
+			canon_skip_eof(ldata);
+		else if (canon_copy_from_read_buf(tty, &kb, &nr))
+			return kb - kbuf;
+	} else {
+		if (copy_from_read_buf(tty, &kb, &nr))
+			return kb - kbuf;
+	}
+
+	/* No more data - release locks and stop retries */
+	n_tty_kick_worker(tty);
+	n_tty_check_unthrottle(tty);
+	up_read(&tty->termios_rwsem);
+	mutex_unlock(&ldata->atomic_read_lock);
+	*cookie = NULL;
+
+	return kb - kbuf;
+}
 
 /**
  * n_tty_read		-	read function for tty
@@ -2144,36 +2177,9 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 	bool packet;
 	size_t old_tail;
 
-	/*
-	 * Is this a continuation of a read started earler?
-	 *
-	 * If so, we still hold the atomic_read_lock and the
-	 * termios_rwsem, and can just continue to copy data.
-	 */
-	if (*cookie) {
-		if (ldata->icanon && !L_EXTPROC(tty)) {
-			/*
-			 * If we have filled the user buffer, see
-			 * if we should skip an EOF character before
-			 * releasing the lock and returning done.
-			 */
-			if (!nr)
-				canon_skip_eof(ldata);
-			else if (canon_copy_from_read_buf(tty, &kb, &nr))
-				return kb - kbuf;
-		} else {
-			if (copy_from_read_buf(tty, &kb, &nr))
-				return kb - kbuf;
-		}
-
-		/* No more data - release locks and stop retries */
-		n_tty_kick_worker(tty);
-		n_tty_check_unthrottle(tty);
-		up_read(&tty->termios_rwsem);
-		mutex_unlock(&ldata->atomic_read_lock);
-		*cookie = NULL;
-		return kb - kbuf;
-	}
+	/* Is this a continuation of a read started earlier? */
+	if (*cookie)
+		return n_tty_continue_cookie(tty, kbuf, nr, cookie);
 
 	retval = job_control(tty, file);
 	if (retval < 0)
-- 
2.49.0

