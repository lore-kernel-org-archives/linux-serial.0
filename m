Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342AB34C127;
	Wed, 19 Nov 2025 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546523; cv=none; b=XKltUe7ou8DyCCbbeTKQ+CpGcm9LYx0oKh8Rj9HAIP0U52pCAb04zMn3X2Qi4j42IHSCAqmcTnNxd+s/5NV92B7lafp4aPvtv9lclCgW10deN1gbVJMSybqqg9RNAgA+UxAL0zrEofmUC77LaW9JLqhs9/TD4Yjs/G+P0Dl2OSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546523; c=relaxed/simple;
	bh=1yOaezHkmKuZikyGo8CM9x2MBgXFH8Uawo4IcDrCkGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvU+3x2yWTvp541Yh69Ai2HuVd4mwr4MLpmmTh6x4d3AnuvZ+dfl5mfwz5a6u23sEWkG5gdB8e4l1Ww4ymQOW/2tjaGv+J1vhfU0Iz50K3K/NFs7NsXW3IAbhXMIgCagcR9RloNh8CiMVleLYSz73r06iQ6gCzCXG0lEeDY1IO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHk7K5Md; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHk7K5Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F61C2BCB1;
	Wed, 19 Nov 2025 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546522;
	bh=1yOaezHkmKuZikyGo8CM9x2MBgXFH8Uawo4IcDrCkGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHk7K5MdJfvBkEmMtde2rdgx6YVRkiN8iiynlKyfOwVbJzfnZjRdSOLdo6qDpIe0D
	 F2g4SVgXKWYmNLjZ5cxHW8JgCq0/ap9c3zMZKMPtYgKfRVqPVGQskFt2zDGOr8zXuA
	 0BAvH1ON3j9HoKkmG8TOTwo9Mkhu9CZb7DCzqOR4TOHDoymGfEL4dQzRDEip5GM5R1
	 vGCOsrb0CcLAhjM0+ZZsrVVCPhSGsuaXHctKektzGN00vqnteXSZGjZ45RqWze+GKw
	 ZuVdYdtGdCnlcNmWkAVJAHIfWPi5b7Jmbl9r+5x18AVV4aAEwHwbZPF8Z8G5liaXk2
	 aSOU0eaROAo9Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/10] serial: serial_core: simplify uart_ioctl() returns
Date: Wed, 19 Nov 2025 11:01:39 +0100
Message-ID: <20251119100140.830761-10-jirislaby@kernel.org>
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

Neither uart_do_autoconfig(), nor uart_wait_modem_status() can return
-ENOIOCTLCMD. The ENOIOCTLCMD checks are there to check if 'cmd' matched
against TIOCSERCONFIG, and TIOCMIWAIT respectively. (With 0 or error in
'ret', it does not matter.)

Therefore, the code can simply return from the TIOCSERCONFIG and
TIOCMIWAIT spots immediately.

To be more explicit, use 'if' instead of switch-case for those single
values.

And return without jumping to the 'out' label -- it can be removed too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 35 ++++++++------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4757293ece8c..74018fb8a4e7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1560,37 +1560,20 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	void __user *uarg = (void __user *)arg;
 	int ret = -ENOIOCTLCMD;
 
-
-	/*
-	 * These ioctls don't rely on the hardware to be present.
-	 */
-	switch (cmd) {
-	case TIOCSERCONFIG:
+	/* This ioctl doesn't rely on the hardware to be present. */
+	if (cmd == TIOCSERCONFIG) {
 		down_write(&tty->termios_rwsem);
 		ret = uart_do_autoconfig(tty, state);
 		up_write(&tty->termios_rwsem);
-		break;
-	}
-
-	if (ret != -ENOIOCTLCMD)
-		goto out;
-
-	if (tty_io_error(tty)) {
-		ret = -EIO;
-		goto out;
+		return ret;
 	}
 
-	/*
-	 * The following should only be used when hardware is present.
-	 */
-	switch (cmd) {
-	case TIOCMIWAIT:
-		ret = uart_wait_modem_status(state, arg);
-		break;
-	}
+	if (tty_io_error(tty))
+		return -EIO;
 
-	if (ret != -ENOIOCTLCMD)
-		goto out;
+	/* This should only be used when the hardware is present. */
+	if (cmd == TIOCMIWAIT)
+		return uart_wait_modem_status(state, arg);
 
 	/* rs485_config requires more locking than others */
 	if (cmd == TIOCSRS485)
@@ -1638,7 +1621,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	mutex_unlock(&port->mutex);
 	if (cmd == TIOCSRS485)
 		up_write(&tty->termios_rwsem);
-out:
+
 	return ret;
 }
 
-- 
2.51.1

