Received: from m204-245.eu.mailgun.net (m204-245.eu.mailgun.net [161.38.204.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1E1CB32F
	for <linux-serial@vger.kernel.org>; Thu, 21 Nov 2024 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187876; cv=none; b=kgjOfyyiviU1Ii9sbb5mfj1Ca1Kc+gshZYJtyAtj4qIxNkRn388BWm4T1IlmAyjhJKOMskYcwo8vdKdFMOVNWcoejuoBVgVZmbM64uDjxPhFcOyl+0FCyacnqWK/UjF2POSm5xeGt+b07+7pMKhpawuAlXYqXZVY1Bb8Cj8kYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187876; c=relaxed/simple;
	bh=hPoP4UsgoR6pocAyki75eRu7e8CX7z/KvJka510AE4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8jgv17AKUSV0uVK6f5zxN6zZ4QTMAN1nI3o/WzA1VRZQl/JePsS4o+kFDiunn6g2o0BJe1W6cJdlMbL2n9O1SgnpjxLCJ0YXLEWqMKW+2ImFmpAah2UahUtbNoo25ZECfHpfUTTc9uvrM4Vp4O1YX3Gc2ptJyKqPVOHIw5YCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gpost.dk; spf=pass smtp.mailfrom=gpost.dk; dkim=pass (1024-bit key) header.d=gpost.dk header.i=@gpost.dk header.b=WgN2ttIo; arc=none smtp.client-ip=161.38.204.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gpost.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpost.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gpost.dk header.i=@gpost.dk header.b="WgN2ttIo"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=gpost.dk; q=dns/txt; s=mta; t=1732187872; x=1732195072;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=eo+mKdfJYTtXszQHIhWJJbqlQbalGfzbrJ+bb8+8EuE=;
 b=WgN2ttIodL9tXlX2+cK/4qy7VdAjyzhz6TFOCDoVr9HRU0ZVEDq6rATLHN5Of6rTLn4hnBYurj7JSnE1nnISKWlXwFVcVNPNDCk3wzZamXeDOTYnRXyqzURDs6Uqf1Ne3FHk6M0BqUUi7dKdWPFZmKy3kYm3tRBF9b18CtDVh8o=
X-Mailgun-Sending-Ip: 161.38.204.245
X-Mailgun-Sending-Ip-Pool-Name: 
X-Mailgun-Sending-Ip-Pool: 
X-Mailgun-Sid: WyI1MmE4ZSIsImxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmciLCJmODkzZCJd
Received: from qubit.home (11.85.120.188.andels.net [188.120.85.11]) by afe10bebdc9e
 with SMTP id 673f16e05111dcf9bdc00174; Thu, 21 Nov 2024 11:17:52 GMT
Sender: gpdev@gpost.dk
From: Gil Pedersen <gpdev@gpost.dk>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Gil Pedersen <gpdev@gpost.dk>
Subject: [PATCH 1/1] tty: respond to TIOCGWINSZ when hung
Date: Thu, 21 Nov 2024 12:12:54 +0100
Message-ID: <20241121111506.4717-2-gpdev@gpost.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121111506.4717-1-gpdev@gpost.dk>
References: <20241121111506.4717-1-gpdev@gpost.dk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace libc implementations of the isatty() POSIX system interface
are currently unable to reliably determine if a fd is really a tty when
it is hung.

Specifically glibc libc returns the success status of a TCGETS ioctl.
This will return an incorrect result when the TTY is hung, since an EIO
is unconditionally returned. Ie. an isatty() will return 0, wrongly
indicating that something that definitely is a TTY, is not a TTY.

Userspace implementations could potentially remap EIO errors to a
success to work around this. This will likely work in 99.99% of cases,
but there is no guarantee that a TCGETS ioctl on a non-TTY fd will not
also return EIO, making the isatty() call return a false positive!

This commit enables a specific non-driver, non-ldisc, ioctl to continue
working after the TTY is hung. The TIOCGWINSZ ioctl was chosen since it
is readonly, and only access tty_struct.winsize (and its mutex), and is
already used for the isatty() implementation in musl. The glibc
implementation will need to be updated to use the TIOCGWINSZ ioctl,
either as a direct replacement, or more conservatively, as a fallback
test when the TCGETS ioctl fails with EIO.

Note that TCGETS is not available to use for this, since it is
implemented at the ldisc level, which can not be called into once the
TTY is hung.

Signed-off-by: Gil Pedersen <gpdev@gpost.dk>
---
 drivers/tty/tty_io.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 9771072da177..678fcc9b8264 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -157,6 +157,8 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 static int __tty_fasync(int fd, struct file *filp, int on);
 static int tty_fasync(int fd, struct file *filp, int on);
 static void release_tty(struct tty_struct *tty, int idx);
+static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg);
 
 /**
  * free_tty_struct - free a disused tty
@@ -433,16 +435,10 @@ static __poll_t hung_up_tty_poll(struct file *filp, poll_table *wait)
 	return EPOLLIN | EPOLLOUT | EPOLLERR | EPOLLHUP | EPOLLRDNORM | EPOLLWRNORM;
 }
 
-static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
-		unsigned long arg)
-{
-	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
-}
-
 static long hung_up_tty_compat_ioctl(struct file *file,
 				     unsigned int cmd, unsigned long arg)
 {
-	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
+	return hung_up_tty_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 }
 
 static int hung_up_tty_fasync(int fd, struct file *file, int on)
@@ -2817,6 +2813,25 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return retval;
 }
 
+static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
+		unsigned long arg)
+{
+	struct tty_struct *tty = file_tty(file);
+	struct tty_struct *real_tty;
+	void __user *p = (void __user *)arg;
+
+	real_tty = tty_pair_get_tty(tty);
+
+	switch (cmd) {
+	case TIOCGWINSZ:
+	return tiocgwinsz(real_tty, p);
+	case TIOCSPGRP:
+		return -ENOTTY;
+	}
+
+	return -EIO;
+}
+
 #ifdef CONFIG_COMPAT
 
 struct serial_struct32 {
-- 
2.45.2

