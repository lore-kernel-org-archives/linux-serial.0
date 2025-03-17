Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D821A45C;
	Mon, 17 Mar 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194851; cv=none; b=feJdVTaCnsGODRn0omBN+QC1VWVd9BHsmhROzcyH7b8gNQMqH5azFGZlAOJ8nZYMw5ekz3HUb3C4jlBijUuBXa+tVLb7Yemq6DYczqpSQNsjcC/bIWGHE/XEEL2TqvLtZm+9DDsufID8ZJjNqoEXQMPiKcSJwKewTO6nVr6xDIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194851; c=relaxed/simple;
	bh=O0OSapv4EsD9+5CXeUGANegKYUuFAz0yv6FzuICkoZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujMH5PG+9QoQdHDtNp/JlvWvV2oQ9JZwkovCF2yy5QfS4EQnPYU7j3q4ZukZoADFDktC3HrNdV98wIm61hMBeYniD9mUUz82Xz2Ckjgm75WD/ayKd4LZmZmHYZ6KUUhVBVTQtjxtPudhKi014abDwqFtxHZfJ01csH5JFuLIRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUFRC0OY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUFRC0OY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF84C4CEEC;
	Mon, 17 Mar 2025 07:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194851;
	bh=O0OSapv4EsD9+5CXeUGANegKYUuFAz0yv6FzuICkoZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUFRC0OYunpSrZGiGaoz9Ho7NcXtTFX2AZxFiZkdgt0TYEn96RtT6/r7hwCxoXH+r
	 YnDI8ZW37LmjRYkfaSnI9iLFC4L3eiqzbfba4FvVDFWwmkQBotpr2DmANJO4gmED/s
	 hRenKmEOSp0b3qufeyTYHyohUuANmwbDp29y/DiQpu1jp7t3HvLDGoq2iq3KqsbnoU
	 vpklUmtPrDmQoyFasWM84CE0chuaui8ZBhly3zWo0OpudN8c8UJjF+k83j9Ff9z5yr
	 yaJbjbJR/psC13f3cZfo4EHDa+yXorCLwklTz/9oHxSgKrlN21w/o6khAlWuel66Gt
	 159J2Ls1pi6Aw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 01/31] tty: convert "TTY Struct Flags" to an enum
Date: Mon, 17 Mar 2025 08:00:16 +0100
Message-ID: <20250317070046.24386-2-jirislaby@kernel.org>
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
2.49.0

