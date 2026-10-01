Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0825941F5C4
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873757; cv=none; b=uzla12SJXw83y8gMgkhKPhOGEvAofRKcq6neZvKKrZVMggbVC8tb9qSDZE7eb7tDQlP6veIVOG7vfU7XsWW0L8z3t1juCx4M8oJ6ht9vxnu1z69fuO5xKwW0XIC79wzaNi83CqsHAx+Fg1bjm85TNrsc+VY/GRCja4fFopHRNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873757; c=relaxed/simple;
	bh=L51AOdJa7D5n6jR5j8AolWvI3Mu+aQ/fvgqMfOpwZbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqxRjgsYDqW5zUCLmiZAhxDzFPrNQBAZt6WjGNXDl/0IrtxnU+ca6SNncMQ6pkaJFdUUX3cbdZYV6J1v3Yd5WufehrziKZLJBPwOWp1/Qk3ZWHCYJpDWCZJMGbsdKP6nyy/2YsCN8+zIsBQFelKuRUEcgL7/7QWHLafmNxPatHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/wobIqT; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/wobIqT"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9142e83204aso28490496d6.1
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790873755; x=1791478555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTHYWKz08F9IFT21q78Znvc/ay+y5kvWeCV4R01cPMI=;
        b=I/wobIqTMlGY12JjvlklPRHQBIY0eln+EZ+u1GZVagFUMzqgLRmyLJLYChkmBaf+jg
         sRrTaCceVanO73ZfbhFeRSqFLYSX2Z/8RVr4wJvHU9LLjMjuvA/WiGGgAzKXruavqnO/
         B08yyVqnQUz1TG8lrIigh8rCofKPhRGNVrRBTpn8+TDF78pSYmRRuiLXlDNJIpcJ1u50
         Yiys535RjP4bJUw0rg832geARsBhH4IwrCah7de2K5P2usIlqr99GRFBBAszEBG5Qhvo
         CRS8U7xTXRyA1UiNB8Z+nyld12RcJs9XYPx8SgcQ7sDQ2UHUYmxGpflqOqCER1LxdOMZ
         KZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873755; x=1791478555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTHYWKz08F9IFT21q78Znvc/ay+y5kvWeCV4R01cPMI=;
        b=cWXDp1+cBIlMireqLsckVg6HrDnON33Ri6+jh6r50auYUSRwidFYaZQLaai9DXfhnu
         iQLZWNDC/ADg/oeRFdFGQ5yvsoH1x+0nLKLgInZpZ4zz2awrg9WaftO5SPXmIcWQZqDi
         y223FTrkMitIuVXyAlS0in+AIo1A3PKf1mug8Z3kjAgpPlW2mjBYLLol21279v4a0vxA
         jVvUreyVmApyLLm8xnbGYu3tX7JVYQ+UTvWe2lISK57OO5QXQcS0oh+QvBbWIV8K1mvy
         9/tVR6c4gy2vt1zFPPvlIJGsbjes0h5HOAhGz/WWjjFFBSkkdZp0aaDaP8bnXEBS9KRY
         OV+w==
X-Gm-Message-State: AFuF++n5ntNI4Wycr7ZIEjpT2gky2ZuUkBqX+qZPHWkJMzrzn+VM44aW
	JCJmOvsqtgikOHaJmzXi6kplX7N9gBvn2nRfb0+bKjb+n2yXjSt9e1YA
X-Gm-Gg: AYBFou2TupuPZQxyUFa0WvLofNRfG05/4iXydTu5ssnz4+jwdpzkTSNTKsd+ZPVSNUA
	FXnX1GB9TIqKYpws6uR8qZIkdvUlQtQHPcjnu70yodXoUdLBNov4Z0ZJBhh5omYn94I6ZWdfJRS
	JUnybrixOyaEm/skGDh4Ws2gwsiglu1TcT0fI53XtWbkhTurwPD+cDKnf+qn7no5XymJ2ukU5RT
	dSmCz7rg91iZ5vmOYfamVnAydzQHtEbAI0tqxlBEES6sxq/1cWeixvqlvj+/HZ/DAg67RDiMKyk
	oeLt7uh0NEu0Pf1tNLaPpQqXpus78Vg3K1zSfSyL6XsKeFi+wvPyz+rVi/UJM46ZmRPjAbE/pnp
	YCGaswtl35DObJCkmOp6oeF8Aw7p8RPEWHvVpK8AfoeEbG92qqqLFLVC9I7zwPkmZX5MVoRKHrf
	7Fk2jRb+VhySM7IpCNtQAORWCzc0dQ2Iwugx++N7P1nBlgyNnoOlXSy41ey441K5bJgSHRP1vdN
	xIrwdLD/KZr0wViC/fSqljDYoy4Jg8egBfkKPNmOSe/K+rilI7xemEPuywAUlBKko5R5f7+iuDE
	DAtWdpo=
X-Received: by 2002:a05:6214:3199:b0:917:a1d0:890c with SMTP id 6a1803df08f44-917aa185d44mr59027796d6.17.1790873754640;
        Thu, 01 Oct 2026 09:55:54 -0700 (PDT)
Received: from localhost.localdomain (pool-173-71-97-169.cmdnnj.fios.verizon.net. [173.71.97.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a89aca2asm30200356d6.15.2026.10.01.09.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:55:54 -0700 (PDT)
From: Akira Patafio <kokokoala4211@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Akira Patafio <kokokoala4211@gmail.com>
Subject: [PATCH] tty: pty: preserve open slaves after rejected locked open
Date: Thu,  1 Oct 2026 12:55:52 -0400
Message-ID: <20261001165552.2439-1-kokokoala4211@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Opening a locked PTY slave fails with EIO, but the failure path sets
TTY_IO_ERROR on the shared slave tty. Previously opened slave files then
fail I/O even though their master is still open.

tty_open() releases a file after the slave open callback fails. Merely
skipping TTY_IO_ERROR on the rejected open is insufficient: pty_close()
can mistake the failed file for the last slave and close the master.
Counting tty references is also insufficient because a real last close
can race the failed open and its release.

Track which slave files opened successfully. Ignore failed files during
close, and mark the master peer closed only when the last successful
slave file closes. A selftest checks locked opens with zero, one, and
two existing slave files, plus ordinary last-slave close behavior.

Fixes: 699390354da6 ("pty: Ignore slave pty close() if never successfully opened")
Signed-off-by: Akira Patafio <kokokoala4211@gmail.com>
---
The pre-fix EIO transition was reproduced on an Android 5.10.240 device.
The new selftest cross-compiles for arm64 with -Werror. I have not booted
a kernel with this patch yet.

 drivers/tty/pty.c                             |  32 ++-
 drivers/tty/tty_io.c                          |   1 +
 include/linux/tty.h                           |   1 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../selftests/filesystems/pty_locked_open.c   | 187 ++++++++++++++++++
 6 files changed, 220 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/pty_locked_open.c

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index cc7f709..3cc1494 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -46,12 +46,29 @@ static DEFINE_MUTEX(devpts_mutex);
 
 static void pty_close(struct tty_struct *tty, struct file *filp)
 {
+	struct tty_file_private *priv = filp->private_data;
+	struct tty_file_private *other;
+	bool another_open = false;
+
 	if (tty->driver->subtype == PTY_TYPE_MASTER)
 		WARN_ON(tty->count > 1);
 	else {
-		if (tty_io_error(tty))
+		/* tty_release() also calls close after an unsuccessful open. */
+		if (!priv->pty_opened)
+			return;
+		/* tty->count includes opens that have not succeeded yet. */
+		spin_lock(&tty->files_lock);
+		priv->pty_opened = false;
+		list_for_each_entry(other, &tty->tty_files, list) {
+			if (other->pty_opened) {
+				another_open = true;
+				break;
+			}
+		}
+		spin_unlock(&tty->files_lock);
+		if (another_open)
 			return;
-		if (tty->count > 2)
+		if (tty_io_error(tty))
 			return;
 	}
 	set_bit(TTY_IO_ERROR, &tty->flags);
@@ -223,14 +240,23 @@ static int pty_open(struct tty_struct *tty, struct file *filp)
 
 	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
 		goto out;
+	/* A rejected open must not disrupt already-open slave descriptors. */
 	if (test_bit(TTY_PTY_LOCK, &tty->link->flags))
-		goto out;
+		return -EIO;
 	if (tty->driver->subtype == PTY_TYPE_SLAVE && tty->link->count != 1)
 		goto out;
 
 	clear_bit(TTY_IO_ERROR, &tty->flags);
 	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
 	set_bit(TTY_THROTTLED, &tty->flags);
+	/* Record a successful open before another slave can close. */
+	if (tty->driver->subtype == PTY_TYPE_SLAVE) {
+		struct tty_file_private *priv = filp->private_data;
+
+		spin_lock(&tty->files_lock);
+		priv->pty_opened = true;
+		spin_unlock(&tty->files_lock);
+	}
 	return 0;
 
 out:
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 4856903..e0b5f97 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -186,6 +186,7 @@ int tty_alloc_file(struct file *file)
 	priv = kmalloc_obj(*priv);
 	if (!priv)
 		return -ENOMEM;
+	priv->pty_opened = false;
 
 	file->private_data = priv;
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0a46e40..c44d11f 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -247,6 +247,7 @@ struct tty_file_private {
 	struct tty_struct *tty;
 	struct file *file;
 	struct list_head list;
+	bool pty_opened;
 };
 
 /**
diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 9eb185f..5cbbfca 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -6,4 +6,5 @@ file_stressor
 anon_inode_test
 kernfs_test
 idmapped_tmpfile
+pty_locked_open
 ustat_test
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 03be337..b92a4f1 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -2,7 +2,7 @@
 
 CFLAGS += $(KHDR_INCLUDES)
 TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog ustat_test
-TEST_GEN_PROGS += idmapped_tmpfile
+TEST_GEN_PROGS += idmapped_tmpfile pty_locked_open
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/pty_locked_open.c b/tools/testing/selftests/filesystems/pty_locked_open.c
new file mode 100644
index 0000000..eba661c
--- /dev/null
+++ b/tools/testing/selftests/filesystems/pty_locked_open.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+#include <asm/ioctls.h>
+
+#include "kselftest.h"
+
+#ifndef TIOCGPTPEER
+int main(void)
+{
+	ksft_exit_skip("TIOCGPTPEER is unavailable\n");
+}
+#else
+static int expect_no_master_hup(int master)
+{
+	struct pollfd pfd = { .fd = master, .events = POLLIN | POLLOUT };
+	int ret;
+
+	ret = poll(&pfd, 1, 0);
+	if (ret < 0 || (pfd.revents & POLLHUP)) {
+		ksft_print_msg("master poll returned %d (revents %#x)\n",
+			       ret, pfd.revents);
+		return -1;
+	}
+	return 0;
+}
+
+static int expect_master_hup(int master)
+{
+	struct pollfd pfd = { .fd = master, .events = POLLIN | POLLOUT };
+	int ret;
+
+	ret = poll(&pfd, 1, 0);
+	if (ret != 1 || !(pfd.revents & POLLHUP)) {
+		ksft_print_msg("master poll returned %d (revents %#x), expected HUP\n",
+			       ret, pfd.revents);
+		return -1;
+	}
+	return 0;
+}
+
+static int expect_locked_peer_rejected(int master)
+{
+	int fd;
+
+	errno = 0;
+	fd = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY | O_CLOEXEC);
+	if (fd >= 0) {
+		ksft_print_msg("locked slave unexpectedly opened\n");
+		close(fd);
+		return -1;
+	}
+	if (errno != EIO) {
+		ksft_print_msg("locked slave open returned errno %d, expected EIO\n",
+			       errno);
+		return -1;
+	}
+	return 0;
+}
+
+static int transfer_byte(int master, int slave, char value)
+{
+	struct pollfd pfd = { .fd = master, .events = POLLIN };
+	char received;
+	ssize_t ret;
+
+	ret = write(slave, &value, 1);
+	if (ret != 1) {
+		ksft_print_msg("slave write returned %zd (errno %d)\n", ret, errno);
+		return -1;
+	}
+
+	ret = poll(&pfd, 1, 1000);
+	if (ret != 1 || !(pfd.revents & POLLIN)) {
+		ksft_print_msg("master poll returned %zd (revents %#x)\n",
+			       ret, pfd.revents);
+		return -1;
+	}
+
+	ret = read(master, &received, 1);
+	if (ret != 1 || received != value) {
+		ksft_print_msg("master read returned %zd (value %#x)\n",
+			       ret, ret == 1 ? (unsigned char)received : 0);
+		return -1;
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	int master = -1, slave_a = -1, slave_b = -1;
+	int locked = 1, unlocked = 0;
+	int ret = KSFT_FAIL;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	master = open("/dev/ptmx", O_RDWR | O_NOCTTY | O_CLOEXEC);
+	if (master < 0) {
+		ksft_print_msg("cannot open /dev/ptmx: %d\n", errno);
+		goto out;
+	}
+	if (expect_no_master_hup(master) ||
+	    expect_locked_peer_rejected(master) ||
+	    expect_no_master_hup(master))
+		goto out;
+
+	if (ioctl(master, TIOCSPTLCK, &unlocked) < 0) {
+		ksft_print_msg("cannot unlock slave: %d\n", errno);
+		goto out;
+	}
+	slave_a = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY | O_CLOEXEC);
+	if (slave_a < 0) {
+		ksft_print_msg("cannot open slave A: %d\n", errno);
+		goto out;
+	}
+	if (transfer_byte(master, slave_a, 'A'))
+		goto out;
+	if (ioctl(master, TIOCSPTLCK, &locked) < 0) {
+		ksft_print_msg("cannot relock slave: %d\n", errno);
+		goto out;
+	}
+	if (expect_locked_peer_rejected(master) ||
+	    transfer_byte(master, slave_a, 'B'))
+		goto out;
+	if (ioctl(master, TIOCSPTLCK, &unlocked) < 0) {
+		ksft_print_msg("cannot unlock slave: %d\n", errno);
+		goto out;
+	}
+	slave_b = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY | O_CLOEXEC);
+	if (slave_b < 0) {
+		ksft_print_msg("cannot open slave B: %d\n", errno);
+		goto out;
+	}
+	if (transfer_byte(master, slave_a, 'C') ||
+	    transfer_byte(master, slave_b, 'D'))
+		goto out;
+
+	if (ioctl(master, TIOCSPTLCK, &locked) < 0) {
+		ksft_print_msg("cannot relock slave: %d\n", errno);
+		goto out;
+	}
+	if (transfer_byte(master, slave_a, 'E') ||
+	    transfer_byte(master, slave_b, 'F'))
+		goto out;
+
+	if (expect_locked_peer_rejected(master) ||
+	    transfer_byte(master, slave_a, 'G') ||
+	    transfer_byte(master, slave_b, 'H'))
+		goto out;
+	if (close(slave_b)) {
+		ksft_print_msg("cannot close slave B: %d\n", errno);
+		slave_b = -1;
+		goto out;
+	}
+	slave_b = -1;
+	if (expect_no_master_hup(master) ||
+	    transfer_byte(master, slave_a, 'I'))
+		goto out;
+	if (close(slave_a)) {
+		ksft_print_msg("cannot close slave A: %d\n", errno);
+		slave_a = -1;
+		goto out;
+	}
+	slave_a = -1;
+	if (expect_master_hup(master))
+		goto out;
+	ret = KSFT_PASS;
+
+out:
+	if (slave_b >= 0)
+		close(slave_b);
+	if (slave_a >= 0)
+		close(slave_a);
+	if (master >= 0)
+		close(master);
+	ksft_test_result(ret == KSFT_PASS,
+			 "locked slave open preserves master and existing slave I/O\n");
+	ksft_exit(ret == KSFT_PASS);
+}
+#endif
-- 
2.50.1
