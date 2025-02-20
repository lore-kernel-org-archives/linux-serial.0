Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54B1FCFDA;
	Thu, 20 Feb 2025 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050193; cv=none; b=f9n9at/j27fDkZbh0upuK4KTked6jtWFSWO7RbgI9ELFmFheH6SsknmVMRMFnsvnCCw15kDWOoEIYhehjK4LKNPcgatgwiTocwuGyt0KBXzPFn0H/HK4dToQCGuiqQzi2csBgxcx5hA6eQY+0yKEKSMHnbITIJ3Meoik1zCYC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050193; c=relaxed/simple;
	bh=0FMYyau3lU6OsZPeWKXYKIaiuxGFNc97kzzMytcgEUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgDlhtLafVhSut7keOTL3UetS1djfXnv/Yr9nwFkb+SzvC41dpnV5sjFe6MTcGHj2s5guCEcMomo5B33wEpV0PuaZpO4ueo9EUsaD/kiH78cLvplKAoDf6nvaEcn8AAwaSawmkPR4ByUPjVBHGN/aZDPLipJ5demuw4i0IgRU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN+TOOV5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN+TOOV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F06C4CEDD;
	Thu, 20 Feb 2025 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050192;
	bh=0FMYyau3lU6OsZPeWKXYKIaiuxGFNc97kzzMytcgEUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LN+TOOV5cYRQdT7ykSATcDjdN0DViHUnrWLUZ/h8ml7zqfwc4nKG3bWONVzbcJnG9
	 j7GeMrALbN+lv7cbJPWSdIvEITBy3dmoFczecd1to2Ix1T5ZZlgiVtv8oIKEnPCIt+
	 wnQ2y0erQUmO8RUZuyHEmIvKqCiwdEDv6Qz67SLyIvs/M0azZIpYZU0IV7OgzFODcG
	 Edck/UhaRXbLt70UVzWo1V1qOAj9gS0x44Bgm92ITzieBlOxs3p49e8gkg0jyz4Tri
	 wqwZBRNsvyS+eMFyluazhBAIpjHzDpc97tMYp06PZejyi+Kr+w6ar3NqcwfGKoB9vf
	 4FNDBdhmGW9Xw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/29] tty: tty_driver: move TTY macros to the top
Date: Thu, 20 Feb 2025 12:15:49 +0100
Message-ID: <20250220111606.138045-13-jirislaby@kernel.org>
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

So that they can be referenced in structs once converted to enums (in
the next patches).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/tty_driver.h | 156 ++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index d4cdc089f6c3..f3be6d56e9e5 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -16,6 +16,84 @@ struct tty_driver;
 struct serial_icounter_struct;
 struct serial_struct;
 
+/**
+ * DOC: TTY Driver Flags
+ *
+ * TTY_DRIVER_RESET_TERMIOS
+ *	Requests the tty layer to reset the termios setting when the last
+ *	process has closed the device. Used for PTYs, in particular.
+ *
+ * TTY_DRIVER_REAL_RAW
+ *	Indicates that the driver will guarantee not to set any special
+ *	character handling flags if this is set for the tty:
+ *
+ *	``(IGNBRK || (!BRKINT && !PARMRK)) && (IGNPAR || !INPCK)``
+ *
+ *	That is, if there is no reason for the driver to
+ *	send notifications of parity and break characters up to the line
+ *	driver, it won't do so.  This allows the line driver to optimize for
+ *	this case if this flag is set.  (Note that there is also a promise, if
+ *	the above case is true, not to signal overruns, either.)
+ *
+ * TTY_DRIVER_DYNAMIC_DEV
+ *	The individual tty devices need to be registered with a call to
+ *	tty_register_device() when the device is found in the system and
+ *	unregistered with a call to tty_unregister_device() so the devices will
+ *	be show up properly in sysfs.  If not set, all &tty_driver.num entries
+ *	will be created by the tty core in sysfs when tty_register_driver() is
+ *	called.  This is to be used by drivers that have tty devices that can
+ *	appear and disappear while the main tty driver is registered with the
+ *	tty core.
+ *
+ * TTY_DRIVER_DEVPTS_MEM
+ *	Don't use the standard arrays (&tty_driver.ttys and
+ *	&tty_driver.termios), instead use dynamic memory keyed through the
+ *	devpts filesystem. This is only applicable to the PTY driver.
+ *
+ * TTY_DRIVER_HARDWARE_BREAK
+ *	Hardware handles break signals. Pass the requested timeout to the
+ *	&tty_operations.break_ctl instead of using a simple on/off interface.
+ *
+ * TTY_DRIVER_DYNAMIC_ALLOC
+ *	Do not allocate structures which are needed per line for this driver
+ *	(&tty_driver.ports) as it would waste memory. The driver will take
+ *	care. This is only applicable to the PTY driver.
+ *
+ * TTY_DRIVER_UNNUMBERED_NODE
+ *	Do not create numbered ``/dev`` nodes. For example, create
+ *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
+ *	driver for a single tty device is being allocated.
+ */
+#define TTY_DRIVER_INSTALLED		0x0001
+#define TTY_DRIVER_RESET_TERMIOS	0x0002
+#define TTY_DRIVER_REAL_RAW		0x0004
+#define TTY_DRIVER_DYNAMIC_DEV		0x0008
+#define TTY_DRIVER_DEVPTS_MEM		0x0010
+#define TTY_DRIVER_HARDWARE_BREAK	0x0020
+#define TTY_DRIVER_DYNAMIC_ALLOC	0x0040
+#define TTY_DRIVER_UNNUMBERED_NODE	0x0080
+
+/* tty driver types */
+#define TTY_DRIVER_TYPE_SYSTEM		0x0001
+#define TTY_DRIVER_TYPE_CONSOLE		0x0002
+#define TTY_DRIVER_TYPE_SERIAL		0x0003
+#define TTY_DRIVER_TYPE_PTY		0x0004
+#define TTY_DRIVER_TYPE_SCC		0x0005	/* scc driver */
+#define TTY_DRIVER_TYPE_SYSCONS		0x0006
+
+/* system subtypes (magic, used by tty_io.c) */
+#define SYSTEM_TYPE_TTY			0x0001
+#define SYSTEM_TYPE_CONSOLE		0x0002
+#define SYSTEM_TYPE_SYSCONS		0x0003
+#define SYSTEM_TYPE_SYSPTMX		0x0004
+
+/* pty subtypes (magic, used by tty_io.c) */
+#define PTY_TYPE_MASTER			0x0001
+#define PTY_TYPE_SLAVE			0x0002
+
+/* serial subtype definitions */
+#define SERIAL_TYPE_NORMAL	1
+
 /**
  * struct tty_operations -- interface between driver and tty
  *
@@ -494,84 +572,6 @@ static inline void tty_set_operations(struct tty_driver *driver,
 	driver->ops = op;
 }
 
-/**
- * DOC: TTY Driver Flags
- *
- * TTY_DRIVER_RESET_TERMIOS
- *	Requests the tty layer to reset the termios setting when the last
- *	process has closed the device. Used for PTYs, in particular.
- *
- * TTY_DRIVER_REAL_RAW
- *	Indicates that the driver will guarantee not to set any special
- *	character handling flags if this is set for the tty:
- *
- *	``(IGNBRK || (!BRKINT && !PARMRK)) && (IGNPAR || !INPCK)``
- *
- *	That is, if there is no reason for the driver to
- *	send notifications of parity and break characters up to the line
- *	driver, it won't do so.  This allows the line driver to optimize for
- *	this case if this flag is set.  (Note that there is also a promise, if
- *	the above case is true, not to signal overruns, either.)
- *
- * TTY_DRIVER_DYNAMIC_DEV
- *	The individual tty devices need to be registered with a call to
- *	tty_register_device() when the device is found in the system and
- *	unregistered with a call to tty_unregister_device() so the devices will
- *	be show up properly in sysfs.  If not set, all &tty_driver.num entries
- *	will be created by the tty core in sysfs when tty_register_driver() is
- *	called.  This is to be used by drivers that have tty devices that can
- *	appear and disappear while the main tty driver is registered with the
- *	tty core.
- *
- * TTY_DRIVER_DEVPTS_MEM
- *	Don't use the standard arrays (&tty_driver.ttys and
- *	&tty_driver.termios), instead use dynamic memory keyed through the
- *	devpts filesystem. This is only applicable to the PTY driver.
- *
- * TTY_DRIVER_HARDWARE_BREAK
- *	Hardware handles break signals. Pass the requested timeout to the
- *	&tty_operations.break_ctl instead of using a simple on/off interface.
- *
- * TTY_DRIVER_DYNAMIC_ALLOC
- *	Do not allocate structures which are needed per line for this driver
- *	(&tty_driver.ports) as it would waste memory. The driver will take
- *	care. This is only applicable to the PTY driver.
- *
- * TTY_DRIVER_UNNUMBERED_NODE
- *	Do not create numbered ``/dev`` nodes. For example, create
- *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
- *	driver for a single tty device is being allocated.
- */
-#define TTY_DRIVER_INSTALLED		0x0001
-#define TTY_DRIVER_RESET_TERMIOS	0x0002
-#define TTY_DRIVER_REAL_RAW		0x0004
-#define TTY_DRIVER_DYNAMIC_DEV		0x0008
-#define TTY_DRIVER_DEVPTS_MEM		0x0010
-#define TTY_DRIVER_HARDWARE_BREAK	0x0020
-#define TTY_DRIVER_DYNAMIC_ALLOC	0x0040
-#define TTY_DRIVER_UNNUMBERED_NODE	0x0080
-
-/* tty driver types */
-#define TTY_DRIVER_TYPE_SYSTEM		0x0001
-#define TTY_DRIVER_TYPE_CONSOLE		0x0002
-#define TTY_DRIVER_TYPE_SERIAL		0x0003
-#define TTY_DRIVER_TYPE_PTY		0x0004
-#define TTY_DRIVER_TYPE_SCC		0x0005	/* scc driver */
-#define TTY_DRIVER_TYPE_SYSCONS		0x0006
-
-/* system subtypes (magic, used by tty_io.c) */
-#define SYSTEM_TYPE_TTY			0x0001
-#define SYSTEM_TYPE_CONSOLE		0x0002
-#define SYSTEM_TYPE_SYSCONS		0x0003
-#define SYSTEM_TYPE_SYSPTMX		0x0004
-
-/* pty subtypes (magic, used by tty_io.c) */
-#define PTY_TYPE_MASTER			0x0001
-#define PTY_TYPE_SLAVE			0x0002
-
-/* serial subtype definitions */
-#define SERIAL_TYPE_NORMAL	1
-
 int tty_register_driver(struct tty_driver *driver);
 void tty_unregister_driver(struct tty_driver *driver);
 struct device *tty_register_device(struct tty_driver *driver, unsigned index,
-- 
2.48.1

