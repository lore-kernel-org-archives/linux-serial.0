Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33BB1FBE9E;
	Thu, 20 Feb 2025 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050190; cv=none; b=AXoIQB4UII3ADDobNGIdOwMs8oqP24QOxWfolT4+xrzMjeaBT0DQZpne0XlX+KchQfO+2B/j2BOWWP69swvzDL3P6AFKg6Kos8WVQBhmIXA83msr1mTuFsqblHQDhpnUzkRRmMFlCVlQpY/qhnxCAgh+COYbSc2iLAgpwkaFNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050190; c=relaxed/simple;
	bh=/yZtA/QNRQ/5GBa14iNHXusxbG4H8sUecszu/ehL+T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJKGBs2YXLVFhz1KP+CxqMfn3N3AgqEHb/OIp5k4YI5lLNQOaC2GdrRlFftGT289EXTnequiv9pNBQHcxYbHUEwUtbYM9Tt2TjzJApbFX88O1YMCXZje7sSgZQALrFHyZXhNUzYCz/vgoMn2ZB+vJfhO5LPdVwB/VkfAOHZK3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGukvWoi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGukvWoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6E3C4CEDD;
	Thu, 20 Feb 2025 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050189;
	bh=/yZtA/QNRQ/5GBa14iNHXusxbG4H8sUecszu/ehL+T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGukvWoiYugWuRsmcLH+mF1kGuceKy0hEkWzgif4kDKj9I8cwjVz5hPUF0kxTF61B
	 LK2cRPfrUMtFy26wL1z3lmsr494xq2RdhOeKXEySP7IUw28x9VhCtfIt5Y/SqYHQb+
	 fLzTeBzoyStJWLpGnp+iAlKMAzC+g67FAxwp9YK8SRRYjOXH7Ua5ixQCO7ML41GM1Y
	 g/AI2y9lTSnRW9XLWGoPLiuyMGk9aacsv3z4td2wybkT74ciu/QcZTwIomXmzMuVeM
	 Qjf9AaVXjDmnF8hp4M5K1Wek7xoRqDZKXTi8SvQGiNaaYjhmjqno+QV2Qco/Y5JL32
	 5nQSxgrbKe5jA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/29] tty: n_tty: extract n_tty_wait_for_input()
Date: Thu, 20 Feb 2025 12:15:47 +0100
Message-ID: <20250220111606.138045-11-jirislaby@kernel.org>
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
2.48.1

