Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCB1F2BA4;
	Thu, 20 Feb 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050175; cv=none; b=q/AUrOGlPdzBIYOjMzLi8pZioz1hY+aIleGjOKAsKHxVl0WDGnqRLPpotLolx8r4Qdf25XwrJHUvZ7/a7UU8ziVRSlkobRlwEPmQEyLPfR/CaTeX++Byjbafj/zC19gREDzlFQG99uswwfZngKYRYImzbD7MaSpbzoCUmSdQxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050175; c=relaxed/simple;
	bh=UGUcZhh2uN5m2e5STrQhOWzZBbObdTYU/HLYBpoIjf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hs+QKrifHMRJbEPXy8w28z4z9GxMypjFLmXfL1tMPCqsJC4rVdyuS0EVcoJlrVYUT/z4/0L/xKp7/nKSKo6mpdRRZu63rBMFDGNo64tchVIEodWEQIzAFN2Tog0EHqyXNXuEz5teN5HCRSVWnqvy5iD5Mgqgt0VvRrYO5NchgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkxsvloC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkxsvloC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84209C4CEDD;
	Thu, 20 Feb 2025 11:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050174;
	bh=UGUcZhh2uN5m2e5STrQhOWzZBbObdTYU/HLYBpoIjf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkxsvloCLVEYCIdzMrcDLCc0pZu8PABLUaTOu6+J5rpGkZvViFEcvQKpj7FadD8If
	 A9dV1ZYQkNT34jjCS4uqeDZM7LKAurWwkoHD5TM3CqoKPkdtpuzrquDz1DlbmsBx8w
	 735cFSqL1hlgWOzTI2e4bpNY5X1gve8YlCkOGfw3j+TFOLa94bQJBU4wUeVcyEIvOO
	 htgU85v6t7aoeaL8Vhf9Q9af3lIVnB8ieTdfF09TL8rdoGeFEdlUgEIOlE4qR7WyOA
	 qm2hfkcN/g1+thcefn2sWIZbQoK3vjddXfRsOd18Ect9qxA4Od28jV9YidfmdIVCRW
	 iWLxTDogCp1wg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/29] tty: convert "TTY Struct Flags" to an enum
Date: Thu, 20 Feb 2025 12:15:38 +0100
Message-ID: <20250220111606.138045-2-jirislaby@kernel.org>
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

Convert TTY_* macros (flags) to an enum. This allows for easier
kernel-doc (the comment needed fine tuning), grouping of these nicely,
and proper checking.

Note that these are bit positions. So they are used such as
test_bit(TTY_THROTTLED, ...). Given these are not the user API (only
in-kernel API/ABI), the bit positions are NOT preserved in this patch.
All are renumbered naturally using the enum-auto-numbering.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 Documentation/driver-api/tty/tty_struct.rst |  2 +-
 include/linux/tty.h                         | 52 +++++++++++----------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/Documentation/driver-api/tty/tty_struct.rst b/Documentation/driver-api/tty/tty_struct.rst
index c72f5a4293b2..29caf1c1ca5f 100644
--- a/Documentation/driver-api/tty/tty_struct.rst
+++ b/Documentation/driver-api/tty/tty_struct.rst
@@ -72,7 +72,7 @@ TTY Struct Flags
 ================
 
 .. kernel-doc:: include/linux/tty.h
-   :doc: TTY Struct Flags
+   :identifiers: tty_struct_flags
 
 TTY Struct Reference
 ====================
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 2372f9357240..6bb4fb3845f0 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -251,7 +251,7 @@ struct tty_file_private {
 };
 
 /**
- * DOC: TTY Struct Flags
+ * enum tty_struct_flags - TTY Struct Flags
  *
  * These bits are used in the :c:member:`tty_struct.flags` field.
  *
@@ -260,62 +260,64 @@ struct tty_file_private {
  * tty->write.  Thus, you must use the inline functions set_bit() and
  * clear_bit() to make things atomic.
  *
- * TTY_THROTTLED
+ * @TTY_THROTTLED:
  *	Driver input is throttled. The ldisc should call
  *	:c:member:`tty_driver.unthrottle()` in order to resume reception when
  *	it is ready to process more data (at threshold min).
  *
- * TTY_IO_ERROR
+ * @TTY_IO_ERROR:
  *	If set, causes all subsequent userspace read/write calls on the tty to
  *	fail, returning -%EIO. (May be no ldisc too.)
  *
- * TTY_OTHER_CLOSED
+ * @TTY_OTHER_CLOSED:
  *	Device is a pty and the other side has closed.
  *
- * TTY_EXCLUSIVE
+ * @TTY_EXCLUSIVE:
  *	Exclusive open mode (a single opener).
  *
- * TTY_DO_WRITE_WAKEUP
+ * @TTY_DO_WRITE_WAKEUP:
  *	If set, causes the driver to call the
  *	:c:member:`tty_ldisc_ops.write_wakeup()` method in order to resume
  *	transmission when it can accept more data to transmit.
  *
- * TTY_LDISC_OPEN
+ * @TTY_LDISC_OPEN:
  *	Indicates that a line discipline is open. For debugging purposes only.
  *
- * TTY_PTY_LOCK
+ * @TTY_PTY_LOCK:
  *	A flag private to pty code to implement %TIOCSPTLCK/%TIOCGPTLCK logic.
  *
- * TTY_NO_WRITE_SPLIT
+ * @TTY_NO_WRITE_SPLIT:
  *	Prevent driver from splitting up writes into smaller chunks (preserve
  *	write boundaries to driver).
  *
- * TTY_HUPPED
+ * @TTY_HUPPED:
  *	The TTY was hung up. This is set post :c:member:`tty_driver.hangup()`.
  *
- * TTY_HUPPING
+ * @TTY_HUPPING:
  *	The TTY is in the process of hanging up to abort potential readers.
  *
- * TTY_LDISC_CHANGING
+ * @TTY_LDISC_CHANGING:
  *	Line discipline for this TTY is being changed. I/O should not block
  *	when this is set. Use tty_io_nonblock() to check.
  *
- * TTY_LDISC_HALTED
+ * @TTY_LDISC_HALTED:
  *	Line discipline for this TTY was stopped. No work should be queued to
  *	this ldisc.
  */
-#define TTY_THROTTLED		0
-#define TTY_IO_ERROR		1
-#define TTY_OTHER_CLOSED	2
-#define TTY_EXCLUSIVE		3
-#define TTY_DO_WRITE_WAKEUP	5
-#define TTY_LDISC_OPEN		11
-#define TTY_PTY_LOCK		16
-#define TTY_NO_WRITE_SPLIT	17
-#define TTY_HUPPED		18
-#define TTY_HUPPING		19
-#define TTY_LDISC_CHANGING	20
-#define TTY_LDISC_HALTED	22
+enum tty_struct_flags {
+	TTY_THROTTLED,
+	TTY_IO_ERROR,
+	TTY_OTHER_CLOSED,
+	TTY_EXCLUSIVE,
+	TTY_DO_WRITE_WAKEUP,
+	TTY_LDISC_OPEN,
+	TTY_PTY_LOCK,
+	TTY_NO_WRITE_SPLIT,
+	TTY_HUPPED,
+	TTY_HUPPING,
+	TTY_LDISC_CHANGING,
+	TTY_LDISC_HALTED,
+};
 
 static inline bool tty_io_nonblock(struct tty_struct *tty, struct file *file)
 {
-- 
2.48.1

