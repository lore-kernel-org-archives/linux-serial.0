Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE82E518121
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972701; cv=none; b=leSdttVDD1haNiuLDl9sdvleTD+iwqaH8fOmCNIJZd3ndr4YnE4awxHx+MnDB8Zxbsq6WUpq/HVXQokAUsE53RZ+KyXpwZEQ9lcxUrHoZ4sKsPOofS8ATJNTgm17cg9jcZaIn670uIWrcp+4GthSLbq7AOHQ60Y4r/OtSv8sS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972701; c=relaxed/simple;
	bh=gOIDQvoTPC54kqM693/RjiH3DniyfGvoRnPoN723y18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXXt6hAvqfzodV8nDVrCO+hGqP2EN+YIqfc2ulQ404DqMhLTFjG/wcDNaJZyu15+kU5F6fAZlsAprMTZWDmqRhZU0Pti21Z21oW4OfFHrydkxKwkSbK70aMq57Z+ibmQ+brljcXjNcP2Gib4wkt8ccYlX8O+XZmVQCObW1lGlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYGfOsnH; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYGfOsnH"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91795fb225aso2977576d6.3
        for <linux-serial@vger.kernel.org>; Fri, 02 Oct 2026 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790972697; x=1791577497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S35goerxP799yBtkbGvn8cEv+WRt3OcPuehglbCBDPM=;
        b=oYGfOsnHfMqF/z0u7x40j9iM9H9rkjtlCIWTe98cWdFMZ3azizldJBS2MmUneIw/Md
         8KjrNHhkfCVpFaFnPG1cb5+GnwcrCzKLb4XE6R55a+cWuUDTay1KyhHHpaEppMLH2GEY
         7WR28EHswmkIgaHWNl7oyBRhIzi7Yh+OfywVpcx9eJcB21d7OZ2Yy/+9vxEV+W5y5a6P
         6TfHqjTuVIE7G+tiacZFg9FXN3KjSmYm0GrmZozKzsadBpzhZNIDZBIuRisorTJs2kf+
         FF2V9k8GTmOoi8S3LcXhbc5eU2UusZ08fku5poy4OAE8m7oGFKKuOUTZgEi+PNW8Z8Rv
         GCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972697; x=1791577497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S35goerxP799yBtkbGvn8cEv+WRt3OcPuehglbCBDPM=;
        b=aoo+m6P6r5cHhfBcEQYEPWOwHsIaSzF1FIEL+wUHN4vLhm6CNl8Ok7jmdq7leqqVJC
         1i5ztXYfCQdsxHpbV10JH6ohVaJde0lCao/DABY5z1arUbdnGvaxFHNnh1fJ5M2RVlUG
         YK380QG5lFxCG+jP3Vqe50aHZgt1Xqt61UXygQeyupuOT8uyOHn2lRK9iY5Rv3JXAPUy
         SfaFFiLrbcwfupe6FrcXR4ciQwhuZOrEkoOEZTRudG1yDtIVzXZxQGCsvVXiZY959Yc4
         cFu7al8P9pSOewihMsfk/XSMbiEqWEQ0nXfBogChgLQw7tR7NWYx1jo1zY8hVea3xybB
         zHoA==
X-Gm-Message-State: AFuF++ll9CxyQbGg1XZOPD7PVPk2WXRz7BYIb4d8z9Rtyc3mHpAKBG0c
	xcBDu8HEI9g4H8v1kgepxLckmrSwhBveUyJplQuD/4vxhe1dZLA/oPoDjoH95qKw
X-Gm-Gg: AYBFou2jvOib9VchVPTSu7gSQ5N7Fk7+a3fMFe5KP7CECVYcSx27YyR6vGxIOGzuBZ9
	XPSKqdI+5c/TfCVO2wDHLtKAXIGCAy4xaicd/Syz4qsQPEUelfrCkMWlUGu/S7S4dARX5gtN7m0
	VbIXklOhmH0+1iwi+LF0+DzAtQDG4q9Re216ARyg/tK1N4GYAnJ8fnQzbV1/WuQ6ocqjCtpSZLo
	D80rZVpVOgd9w18mHhOLdpMTGJ0qGYPMc/8q6MhyAErlv+Yp8ALIsUrKzi6HhZBVQCi65ydgRGQ
	ZG5Ywf+uZdmDlACtttuorbu1B/nCFjnVq3P4H374NyQe2QeQCN/jgd3M8+76y+V6SQusBjQrnsF
	e8uigCZRfojHAHMwVcfC/wpnVDUW4wi8KysdnPSmmxlfrEr9/OkBME/PTe22LFz1bCcFPMbo58Z
	HBmg7qs3/4r18uOWBbLZzslUofN5EU1dSnVaxeGrwCRbLL+qBbxvPyiNwakLr1Ffiiedh2VRv6V
	/iQM+he3geIgc6YYWU1lpZ59RNz+LdQ9NRtsgNLAsWU7ZYVXMgcHJUshk5ir9fvd8UuuvuI6Hwx
	fQm1WjY=
X-Received: by 2002:a05:6214:598b:b0:917:bfaa:3c4f with SMTP id 6a1803df08f44-917c01f8e7fmr74650926d6.41.1790972697062;
        Fri, 02 Oct 2026 13:24:57 -0700 (PDT)
Received: from localhost.localdomain (pool-173-71-97-169.cmdnnj.fios.verizon.net. [173.71.97.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bc98fbsm28215126d6.29.2026.10.02.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:24:56 -0700 (PDT)
From: Akira Patafio <kokokoala4211@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Akira Patafio <kokokoala4211@gmail.com>
Subject: [PATCH v2] tty: pty: preserve open slaves after rejected locked open
Date: Fri,  2 Oct 2026 16:24:55 -0400
Message-ID: <20261002202455.25324-1-kokokoala4211@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261001165552.2439-1-kokokoala4211@gmail.com>
References: <20261001165552.2439-1-kokokoala4211@gmail.com>
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
slave file closes. In-kernel callers may pass NULL instead of a file;
retain the count-based close behavior for those callers. A selftest
checks locked opens with zero, one, and two existing slave files, plus
ordinary last-slave close behavior.

Fixes: 699390354da6 ("pty: Ignore slave pty close() if never successfully opened")
Assisted-by: LLM
Signed-off-by: Akira Patafio <kokokoala4211@gmail.com>
---
Changes in v2:
- Preserve the existing NULL-file callback behavior for in-kernel TTY users.
- Add the Assisted-by tag requested in review.

Tests:
- The selftest failed on an unpatched Linux 6.12.69 kernel at the
  pre-existing slave write with errno EIO (TAP fail:1).
- Built the patched 7.3.0-rc5 x86_64 kernel with legacy PTYs and Speakup
  enabled, without compiler warnings. Booted it in QEMU/HVF and ran the
  selftest in the guest: TAP pass:1 fail:0, exit status 0.

 drivers/tty/pty.c                             |  34 +++-
 drivers/tty/tty_io.c                          |   1 +
 include/linux/tty.h                           |   1 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../selftests/filesystems/pty_locked_open.c   | 187 ++++++++++++++++++
 6 files changed, 222 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/pty_locked_open.c

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index cc7f709..4024c5d 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -46,12 +46,31 @@ static DEFINE_MUTEX(devpts_mutex);
 
 static void pty_close(struct tty_struct *tty, struct file *filp)
 {
+	struct tty_file_private *priv = filp ? filp->private_data : NULL;
+	struct tty_file_private *other;
+	bool another_open = false;
+
 	if (tty->driver->subtype == PTY_TYPE_MASTER)
 		WARN_ON(tty->count > 1);
 	else {
-		if (tty_io_error(tty))
+		/* tty_release() also calls close after an unsuccessful open. */
+		if (priv && !priv->pty_opened)
+			return;
+		/* In-kernel users have no per-file open state. */
+		if (!priv && tty->count > 2)
 			return;
-		if (tty->count > 2)
+		/* tty->count includes opens that have not succeeded yet. */
+		spin_lock(&tty->files_lock);
+		if (priv)
+			priv->pty_opened = false;
+		list_for_each_entry(other, &tty->tty_files, list) {
+			if (other->pty_opened) {
+				another_open = true;
+				break;
+			}
+		}
+		spin_unlock(&tty->files_lock);
+		if (another_open || tty_io_error(tty))
 			return;
 	}
 	set_bit(TTY_IO_ERROR, &tty->flags);
@@ -223,14 +242,23 @@ static int pty_open(struct tty_struct *tty, struct file *filp)
 
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
+	if (filp && tty->driver->subtype == PTY_TYPE_SLAVE) {
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
