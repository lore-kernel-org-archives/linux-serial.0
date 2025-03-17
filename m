Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6821CA13;
	Mon, 17 Mar 2025 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194866; cv=none; b=L5Eux1PrCFrB2DcYoRVM2QkFqbWT+dyS+667Ozq0T7rSOnWfzcQACCE0/oiIKlAPVErI518Ax9/NZejYSYYl2krpYj6tW9nyLJjSwwpSwQnMI3KIi//5WaToSTpdps/VO8NprM27zE6NSgTehbHrUT/EEQDKCNoOIqtXw6gWLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194866; c=relaxed/simple;
	bh=KtXCMXaczl+E79GCAttWES8YpJxjKFSJ1NhubZhJFVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQIzdwuEasWPyYfiQisvKvTPB+KyNaPsCsMWl42qby6hSSZPSPCzlmEGQPL0t+hgZf+9o4xG1UvEIbNqJzfXycshclXrcXZLhFSsOouNlefGxbDg3WM+RGK8HxB3cGmNvGf39x4uRvi3zrSgLcGsWdx5ui634cqiEEPgwmZLqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNIdubXG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNIdubXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0AAC4CEF0;
	Mon, 17 Mar 2025 07:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194865;
	bh=KtXCMXaczl+E79GCAttWES8YpJxjKFSJ1NhubZhJFVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNIdubXGnt2oPQVpmUU6XwMKsOKaPBLqU7f9asvtV1B1/Gq3MVzsQWSzRTdJ7+cTS
	 OhXbyGh9gkMD2w2FcSwrIBdb4ukY9D0a3hr+xzdA/H7A6XZkboZhxSqfSuBNoYxAMp
	 8EJgMSz/dQbv8ScimjWgRGiWXQo1fPuBlg0b8/U06m5oTCFgcsiwPtofucMfeSS6tk
	 oSL73g2ZWeUOfIGHjmAb62GKw5Ug2tLyHHoHFIvod1VSJP8y2I9VvtAq5rXdkagJwG
	 i0MpgkZwGKGIAPH5xxijFfhYWcGCH0PDK60zQSmUdXHCiyJb47ltP5AtMe+1fvG2TA
	 W1LH5AcWvvapA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 10/31] tty: n_tty: extract n_tty_wait_for_input()
Date: Mon, 17 Mar 2025 08:00:25 +0100
Message-ID: <20250317070046.24386-11-jirislaby@kernel.org>
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
Extract the "wait for input" to a separate function:
n_tty_wait_for_input(). It returns an error (< 0), no input (0), or has
potential input (1).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 57 ++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 88aa5f9cbe5e..0e3eb18490f0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2145,6 +2145,33 @@ static ssize_t n_tty_continue_cookie(struct tty_struct *tty, u8 *kbuf,
 	return kb - kbuf;
 }
 
+static int n_tty_wait_for_input(struct tty_struct *tty, struct file *file,
+				struct wait_queue_entry *wait, long *timeout)
+{
+	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
+		return -EIO;
+	if (tty_hung_up_p(file))
+		return 0;
+	/*
+	 * Abort readers for ttys which never actually get hung up.
+	 * See __tty_hangup().
+	 */
+	if (test_bit(TTY_HUPPING, &tty->flags))
+		return 0;
+	if (!*timeout)
+		return 0;
+	if (tty_io_nonblock(tty, file))
+		return -EAGAIN;
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	up_read(&tty->termios_rwsem);
+	*timeout = wait_woken(wait, TASK_INTERRUPTIBLE, *timeout);
+	down_read(&tty->termios_rwsem);
+
+	return 1;
+}
+
 /**
  * n_tty_read		-	read function for tty
  * @tty: tty device
@@ -2234,34 +2261,12 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 			tty_buffer_flush_work(tty->port);
 			down_read(&tty->termios_rwsem);
 			if (!input_available_p(tty, 0)) {
-				if (test_bit(TTY_OTHER_CLOSED, &tty->flags)) {
-					retval = -EIO;
+				int ret = n_tty_wait_for_input(tty, file, &wait,
+							       &timeout);
+				if (ret <= 0) {
+					retval = ret;
 					break;
 				}
-				if (tty_hung_up_p(file))
-					break;
-				/*
-				 * Abort readers for ttys which never actually
-				 * get hung up.  See __tty_hangup().
-				 */
-				if (test_bit(TTY_HUPPING, &tty->flags))
-					break;
-				if (!timeout)
-					break;
-				if (tty_io_nonblock(tty, file)) {
-					retval = -EAGAIN;
-					break;
-				}
-				if (signal_pending(current)) {
-					retval = -ERESTARTSYS;
-					break;
-				}
-				up_read(&tty->termios_rwsem);
-
-				timeout = wait_woken(&wait, TASK_INTERRUPTIBLE,
-						timeout);
-
-				down_read(&tty->termios_rwsem);
 				continue;
 			}
 		}
-- 
2.49.0

