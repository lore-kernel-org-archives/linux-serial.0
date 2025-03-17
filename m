Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85D21ABC0;
	Mon, 17 Mar 2025 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194870; cv=none; b=mbT9wP2PI0RpAy/nX8m+WrIDWXRhhsk8E96juk8TwBIUqmZeOjV8Y6ZHH2yL+m9d9s5Kd8N9KnPjS3meu6chdWulVUo8G5TW4epHtogQulCvAOhvZxsLy/BY6jT82St6StA4nupt19FK6PtBy05NelHVmJh0QEXzf7AuZvNqOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194870; c=relaxed/simple;
	bh=EBjqzOq3n1z3GifvOiI5e4JuRJnKD7yT2pW4+DHsZHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLyNO2bFe8+oHFpeyxJGbEMPaARX53bdgavYX1Q5iKvr3bZT+c3z1ZEQdjIW8ypOOR0iW6N1DXFM5xhG1StgyYNGNZdhXDsJZ7NJePp7iYymrDZZMXlopuLWPtYRuMp10djFUeFcK6Fxzvu6GD29++28ag5xu4sD9PXn9zd6bA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg/rzaOL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg/rzaOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D522C4CEE3;
	Mon, 17 Mar 2025 07:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194870;
	bh=EBjqzOq3n1z3GifvOiI5e4JuRJnKD7yT2pW4+DHsZHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qg/rzaOLWPFmPV1hUBeHJkPn8oVqdl3r8IDA3RpIwBk+qRbB1vjkZDVGMgIzSw+Zg
	 LzsfspGg5UT/u00KzKYO3eVl0pK3czu7sWlN+FFt6FRhtck5C0A7dG7M9pLdjB0CuZ
	 vZKtvWolDV9ZWEh4fbR6BZ6nm7aVdLO55TW8zHN1nUKLAjqrnGml0LHQt3hG6rYBTl
	 /o4HIQMmeLb0WxxNU8AkFbfjPSC4OExZANFtTXOQZhOJyKmulvGXOrd8xk7fKqzymS
	 Me7uuF1Ujag+jbIdSUo3LWlkbE5UB+geBrOWpx3bUe09LF1km/5ljepmqbHNQ42tK8
	 8B5y5nfAOepNQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 13/31] tty: tty_driver: convert "TTY Driver Flags" to an enum
Date: Mon, 17 Mar 2025 08:00:28 +0100
Message-ID: <20250317070046.24386-14-jirislaby@kernel.org>
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

Convert TTY_DRIVER_* macros (flags) to an enum. This allows for easier
kernel-doc (the comment needed fine tuning), grouping of these nicely,
and proper checking.

Given these are flags, define them using modern BIT() instead of hex
constants.

It turns out (thanks, kernel-doc checker) that internal
TTY_DRIVER_INSTALLED was undocumented. Fix that too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 Documentation/driver-api/tty/tty_driver.rst |  2 +-
 include/linux/tty_driver.h                  | 40 ++++++++++++---------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/Documentation/driver-api/tty/tty_driver.rst b/Documentation/driver-api/tty/tty_driver.rst
index cc529f863406..f6cbffdb6e01 100644
--- a/Documentation/driver-api/tty/tty_driver.rst
+++ b/Documentation/driver-api/tty/tty_driver.rst
@@ -35,7 +35,7 @@ Here comes the documentation of flags accepted by tty_alloc_driver() (or
 __tty_alloc_driver()):
 
 .. kernel-doc:: include/linux/tty_driver.h
-   :doc: TTY Driver Flags
+   :identifiers: tty_driver_flag
 
 ----
 
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index f3be6d56e9e5..d0d940236580 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -17,13 +17,19 @@ struct serial_icounter_struct;
 struct serial_struct;
 
 /**
- * DOC: TTY Driver Flags
+ * enum tty_driver_flag -- TTY Driver Flags
  *
- * TTY_DRIVER_RESET_TERMIOS
+ * These are flags passed to tty_alloc_driver().
+ *
+ * @TTY_DRIVER_INSTALLED:
+ *	Whether this driver was succesfully installed. This is a tty internal
+ *	flag. Do not touch.
+ *
+ * @TTY_DRIVER_RESET_TERMIOS:
  *	Requests the tty layer to reset the termios setting when the last
  *	process has closed the device. Used for PTYs, in particular.
  *
- * TTY_DRIVER_REAL_RAW
+ * @TTY_DRIVER_REAL_RAW:
  *	Indicates that the driver will guarantee not to set any special
  *	character handling flags if this is set for the tty:
  *
@@ -35,7 +41,7 @@ struct serial_struct;
  *	this case if this flag is set.  (Note that there is also a promise, if
  *	the above case is true, not to signal overruns, either.)
  *
- * TTY_DRIVER_DYNAMIC_DEV
+ * @TTY_DRIVER_DYNAMIC_DEV:
  *	The individual tty devices need to be registered with a call to
  *	tty_register_device() when the device is found in the system and
  *	unregistered with a call to tty_unregister_device() so the devices will
@@ -45,33 +51,35 @@ struct serial_struct;
  *	appear and disappear while the main tty driver is registered with the
  *	tty core.
  *
- * TTY_DRIVER_DEVPTS_MEM
+ * @TTY_DRIVER_DEVPTS_MEM:
  *	Don't use the standard arrays (&tty_driver.ttys and
  *	&tty_driver.termios), instead use dynamic memory keyed through the
  *	devpts filesystem. This is only applicable to the PTY driver.
  *
- * TTY_DRIVER_HARDWARE_BREAK
+ * @TTY_DRIVER_HARDWARE_BREAK:
  *	Hardware handles break signals. Pass the requested timeout to the
  *	&tty_operations.break_ctl instead of using a simple on/off interface.
  *
- * TTY_DRIVER_DYNAMIC_ALLOC
+ * @TTY_DRIVER_DYNAMIC_ALLOC:
  *	Do not allocate structures which are needed per line for this driver
  *	(&tty_driver.ports) as it would waste memory. The driver will take
  *	care. This is only applicable to the PTY driver.
  *
- * TTY_DRIVER_UNNUMBERED_NODE
+ * @TTY_DRIVER_UNNUMBERED_NODE:
  *	Do not create numbered ``/dev`` nodes. For example, create
  *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
  *	driver for a single tty device is being allocated.
  */
-#define TTY_DRIVER_INSTALLED		0x0001
-#define TTY_DRIVER_RESET_TERMIOS	0x0002
-#define TTY_DRIVER_REAL_RAW		0x0004
-#define TTY_DRIVER_DYNAMIC_DEV		0x0008
-#define TTY_DRIVER_DEVPTS_MEM		0x0010
-#define TTY_DRIVER_HARDWARE_BREAK	0x0020
-#define TTY_DRIVER_DYNAMIC_ALLOC	0x0040
-#define TTY_DRIVER_UNNUMBERED_NODE	0x0080
+enum tty_driver_flag {
+	TTY_DRIVER_INSTALLED		= BIT(0),
+	TTY_DRIVER_RESET_TERMIOS	= BIT(1),
+	TTY_DRIVER_REAL_RAW		= BIT(2),
+	TTY_DRIVER_DYNAMIC_DEV		= BIT(3),
+	TTY_DRIVER_DEVPTS_MEM		= BIT(4),
+	TTY_DRIVER_HARDWARE_BREAK	= BIT(5),
+	TTY_DRIVER_DYNAMIC_ALLOC	= BIT(6),
+	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
+};
 
 /* tty driver types */
 #define TTY_DRIVER_TYPE_SYSTEM		0x0001
-- 
2.49.0

