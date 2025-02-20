Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A71FDA94;
	Thu, 20 Feb 2025 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050194; cv=none; b=kMbuhfp4v4mOVuxmXVmaoxKdbao7GY1mE3J06npJIsxmr31wq/oaT1rbQizE2kA9+KKqYf5DQjcZFiaxTdg3yUrhfLMNekIUBltJRY6zvlD3Q5MRP42TJFtcJcpvCuc/dthnfE+eKmCAxgR/H4Z16DrcRBrZir7ZiynNrnJ7kYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050194; c=relaxed/simple;
	bh=zOOO9DB53BwVwmkA70kTsG+ATH7ViZTlm6u+KsTETy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqgJWrJXfvAjWRychs7g2f6m7+q0mKpNfVhG2p3L+foXfmW5yVjH9BpWECXy991mj2oih/K2rhy37c6+VAYm76gdGT7d4KvoSAdOgXFVoS47YlpDrfEWscdS5dox3nSADjY3qlqS7amTCLcLHQlJUWd0AmcwCG12gnrx5vh6adU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2p1F0OC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2p1F0OC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A5BC4CEE4;
	Thu, 20 Feb 2025 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050194;
	bh=zOOO9DB53BwVwmkA70kTsG+ATH7ViZTlm6u+KsTETy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2p1F0OC+O0qquknUbcikCULXrX3cNliYz4+9MvhEwf0S+VU0WfN5oFK0HK1efPx7
	 R4cKSkjvoWbcgLUzW+QvfVhqR6PDDz9qqP0qNrAiM4l2G5spc1XEj+mjvuMW0A+oX8
	 wcXd2sPqDBDAut7B2OSlh7wkfAskOwZjC64NH29wpBnlsjawC0znWWGieX++nT+pjV
	 j33uclDGWqRQR/IwY40OOsMHyPQAZK+QkpVBBqW7UPhdxoMljaG3ffKOfGVy0EATwR
	 tlWRHzbQrRbDONvjeBhg/OW5tXmcIs5Ot/m2TShFuP9Xys2bN2ldD67ahyeGC60jm3
	 HFGzl9RMsWrmw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 13/29] tty: tty_driver: convert "TTY Driver Flags" to an enum
Date: Thu, 20 Feb 2025 12:15:50 +0100
Message-ID: <20250220111606.138045-14-jirislaby@kernel.org>
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
2.48.1

