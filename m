Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DF1F2382;
	Tue, 26 Aug 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248713; cv=none; b=aJSu0uQCKoRp0D35MHF8Lmr76R/qKgpAuPDczBHNmySrHeNdKVBX0xh9gl+316ijhth4bCkQp20pa/1yxhU6uXOqCeGOgTMqmFTIixv3qwwe9Yw6kDD4QOS8mZaWV8Ns5OfasMLHeT5Xrja3o+8JiJg57uy9vTKJavZZbjdmB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248713; c=relaxed/simple;
	bh=BF7kBQO7ZYNGz++8lrkbtrB7W8yYMojaBKbsVPLuNc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyJxkc1Fa1Tjvi+BbHT3gwb5R2TKgGJu0c56thN/2Q1JqKDvILhOOh0UF80gOAoTbtJ765sJMJVnjI5CCeJazcKMFL08A+wqNnROk7a+X3uHf70NQSvqMdwJuJEO2wIBw4Dlh4AvPg8KBnxm3QFArcf1ip+saGzqtpLwmKZzCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0Y2i1mK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0Y2i1mK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244580523a0so61152215ad.1;
        Tue, 26 Aug 2025 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756248711; x=1756853511; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yR8G0czTv3htBZuNHGulWIjLUJ2zOwYOErFDW8owQ5M=;
        b=Q0Y2i1mKkuZzJs/nAemXU6lsxueyGwHPXoNXSWjclySHhGcPLHpjuBCQWBU5LSN+rO
         7Z2y4ZKG+8QujNlMCAR8NoVwhIJLBer5iFWjAiyer2SwtqIvXyFTjwR11K4hxS5KiDgj
         ry4VVDUsp5RpIGzDAu0YL6c+sAeSZy9cUdgHlfy8N/0mG0PXcvUsEwOJq1fC8jonGPvd
         fi//PquwcjW9jQgGHLSyHVMOBBkYi5ybZ6PSz9+sd882QTJ8+fqJs1nsG2pKG0pI3yKG
         woBYswWWZnI5MUupXa0tFsubhOtz0y78y4csS/qN002pVeMaJoWza0wh/YxZQfbcJTZt
         ikNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756248711; x=1756853511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR8G0czTv3htBZuNHGulWIjLUJ2zOwYOErFDW8owQ5M=;
        b=A5NDPs6vST6v2XLno9cptKqYGnnY4lDjFRahlqjgXxigQw2MQrpGcQ//SiBGvTpIxx
         HXmj2urHOBmPONanJ4Yi/93MbdWPT1ihcmpn87vKH0tyr9NNwhnvlroyP65zwgKgEGQA
         bsQhFM0xY/wxQMZQ6UvrSZ5xNF8YxAkGrfn9M6vKZVV/sGsHDOW2EViTL45TzUg/Dnpo
         UjRzZLWwTorHSW6eMWZ+OxsVtVDvwtr35WZsDjChevFeVUzlQZ51RnVq/liS/BD+HpYk
         Pu+L5tAvSR/bl6BOS0zKngRKxc8VkHMP04f0lRj9Je4aMGD4WmBS1IhUHxfi+yKqjAmO
         8Law==
X-Forwarded-Encrypted: i=1; AJvYcCUZeIDwSR7xEt0J+INzf6YIXIgILnjlDIw8NQ14Q6pIYcJHBGEwYA+3tM1UoPQp3ZQd8e+ojCVbBiIQu6Un238=@vger.kernel.org, AJvYcCWRU/TNI011E+6dFqjPZTX0A9JYd0EQ+4qUsuHYWgYkbhbOUeijYzhiHdiyKBeTId3BOsZArwTZAKwnk2yj@vger.kernel.org
X-Gm-Message-State: AOJu0YyRMpdJ6OsrXRm46cixnQ6PVHbt7HyD4HSRbJVAZdOon0IzOiD7
	pKix4OUSzpQZJVanXNKU0Il8vHCkrenGBJyNb/RL12YvTabwtGp9eMVK
X-Gm-Gg: ASbGncvwLFm/Xmt8n24RGXY+rjzuUQ/Q0VQCkaPJh9hOTpSLaiDD4puSvNipge/bfQp
	kEJW5Yn1PwDunLvI1uuzLOHjGPxZ/xA1861x3WEaA0r4A513KIt+k5pEj+DV5RtvtKmRFzk6GRs
	muhAm/tAkBnP5NzivJ1xmaZZEYO6F1UgKeSISbzI9h9D9qUX4NGv0FD7cLs1xDCnAK2kH3sCnHK
	sjAGg2daAoigMR0gh/A+Z1Dtag/ExOlP6VforxNt5AjpqvoKM9F4eRlTRjLhjopHL5BXZURUZ1h
	H3y/ZkoM4T1F2VY9bSEFd9duwkpolChj+1w/oHHdVbaTHalSseHqmlkj9iAITjVHvJ5bswKXGpG
	HvuAUWCbyt2VeMTNpMvUvBbZFvKOuv7c=
X-Google-Smtp-Source: AGHT+IEjSg/wptlibuEPS3+h0fbv78JdD9oVr0ztHncjA7DYzOHurKEY4HSpVjseAYYr8cUoJiW0Ew==
X-Received: by 2002:a17:903:fa5:b0:246:b56f:7ec2 with SMTP id d9443c01a7336-246b56f7f2cmr112085625ad.51.1756248710622;
        Tue, 26 Aug 2025 15:51:50 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a601esm105340815ad.162.2025.08.26.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 15:51:50 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Tue, 26 Aug 2025 16:51:32 -0600
Subject: [RFC PATCH 2/5] tty: Add KUnit test helper functions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-tty-tests-v1-2-e904a817df92@gmail.com>
References: <20250826-tty-tests-v1-0-e904a817df92@gmail.com>
In-Reply-To: <20250826-tty-tests-v1-0-e904a817df92@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756248706; l=21106;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=BF7kBQO7ZYNGz++8lrkbtrB7W8yYMojaBKbsVPLuNc4=;
 b=VJhVgezEu94oBRKkY5V7RHnBCvBdi0oWZnsx+LFzy8JerAQJjI4ixfYORIOK9/bk+lEtY3WOX
 /xbWGTHdopNC79Y2ETPw68vjUOhMyLlYuE0rw1+xRWDoPSQ6sB7sYTA
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Introduce comprehensive test helper infrastructure for TTY driver
testing through real kernel entry points. The helpers are included
directly into tty_io.c when CONFIG_TTY_KUNIT_TESTS=y to access
internal functions while maintaining clean symbol export boundaries.

Key features:
- Complete TTY lifecycle testing (open/close/read/write)
- RX data injection via flip buffers
- Termios manipulation for configuration testing
- Automatic resource cleanup via KUnit actions

All functions use EXPORT_SYMBOL_IF_KUNIT() to prevent production
symbol table pollution while enabling comprehensive testing.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 drivers/tty/tests/tty_test_helpers.c | 387 +++++++++++++++++++++++++++++++++++
 drivers/tty/tests/tty_test_helpers.h | 239 +++++++++++++++++++++
 drivers/tty/tty_io.c                 |   4 +
 3 files changed, 630 insertions(+)

diff --git a/drivers/tty/tests/tty_test_helpers.c b/drivers/tty/tests/tty_test_helpers.c
new file mode 100644
index 0000000000000000000000000000000000000000..0de61626ccef1d4e4246f43347401ff46ac432ec
--- /dev/null
+++ b/drivers/tty/tests/tty_test_helpers.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test helpers for TTY drivers
+ *
+ * This file is included directly into tty_io.c when CONFIG_TTY_KUNIT_TESTS=y.
+ * This allows the helper functions to access internal TTY functions like
+ * tty_open() and tty_release() while providing exported symbols for use
+ * by test modules.
+ *
+ * All functions are exported via EXPORT_SYMBOL_IF_KUNIT() so they are
+ * only available when KUNIT is enabled, preventing pollution of the
+ * production symbol table.
+ *
+ * Copyright (c) 2025 Abhinav Saxena <xandfury@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/visibility.h>
+#include <linux/fs.h>
+#include <linux/kdev_t.h>
+#include <linux/uio.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
+#include <linux/tty_ldisc.h>
+#include <linux/termios.h>
+
+#include "tests/tty_test_helpers.h"
+
+
+static struct cdev tty_cdev;
+
+/**
+ * _tty_test_cleanup_release - KUnit cleanup action for TTY release
+ * @data: Pointer to tty_test_fixture
+ *
+ * Internal cleanup function registered with kunit_add_action() to ensure
+ * TTY is properly released even if test fails or exits early.
+ * This prevents resource leaks and system instability.
+ */
+static void _tty_test_cleanup_release(void *data)
+{
+	struct tty_test_fixture *fx = data;
+	int ret;
+
+	if (!fx || !fx->opened || !fx->file || !fx->inode)
+		return;
+
+	ret = tty_release(fx->inode, fx->file);
+	if (ret)
+		pr_warn("TTY test cleanup failed: %d\n", ret);
+	fx->opened = false;
+}
+
+/**
+ * tty_test_create_fixture - Create a test fixture for TTY driver testing
+ */
+struct tty_test_fixture *tty_test_create_fixture(struct kunit *test,
+						 struct tty_driver *driver,
+						 unsigned int index)
+{
+	struct tty_test_fixture *fx;
+
+	KUNIT_ASSERT_NOT_NULL(test, driver);
+
+	fx = kunit_kzalloc(test, sizeof(*fx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fx);
+
+	fx->test = test;
+	fx->driver = driver;
+	fx->dev = MKDEV(driver->major, driver->minor_start + index);
+
+	/* Create synthetic VFS structures for real TTY operations */
+	fx->file = kunit_kzalloc(test, sizeof(*fx->file), GFP_KERNEL);
+	fx->inode = kunit_kzalloc(test, sizeof(*fx->inode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fx->file);
+	KUNIT_ASSERT_NOT_NULL(test, fx->inode);
+
+	/* Initialize as character device with appropriate permissions */
+	init_special_inode(fx->inode, S_IFCHR | 0600, fx->dev);
+	fx->inode->i_rdev = fx->dev;
+	fx->inode->i_cdev = &tty_cdev;
+	KUNIT_ASSERT_NOT_NULL(test, fx->inode->i_cdev);
+
+	fx->file->f_flags = O_RDWR;
+	fx->file->f_mode = FMODE_READ | FMODE_WRITE;
+	fx->file->f_inode = fx->inode;
+
+	/* Register cleanup before any operations that might fail */
+	kunit_add_action(test, _tty_test_cleanup_release, fx);
+
+	fx->opened = false;
+	return fx;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_create_fixture);
+
+/**
+ * tty_test_open - Open TTY through standard kernel path
+ */
+int tty_test_open(struct tty_test_fixture *fx)
+{
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->file);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->inode);
+
+	ret = tty_open(fx->inode, fx->file);
+	if (ret)
+		return ret;
+
+	fx->tty = file_tty(fx->file);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->tty);
+
+	/* Verify the TTY is properly set up */
+	KUNIT_EXPECT_TRUE(fx->test, !list_empty(&fx->tty->tty_files));
+	/* Ldisc must now be fully installed */
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->tty->ldisc);
+	KUNIT_EXPECT_TRUE(fx->test, fx->tty->ldisc->ops);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->tty->disc_data);
+	KUNIT_EXPECT_NOT_NULL(fx->test, fx->tty->port);
+
+	fx->port = fx->tty->port;
+	ret = fx->tty->ldisc->ops->open(fx->tty);
+	if (ret) {
+		tty_release(fx->inode, fx->file);
+		return ret;
+	}
+
+	/* Enable non-blocking mode for predictable test behavior */
+	fx->file->f_flags |= O_NONBLOCK;
+	fx->opened = true;
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_open);
+
+/**
+ * tty_test_release - Close TTY through standard kernel path
+ */
+int tty_test_release(struct tty_test_fixture *fx)
+{
+	int ret;
+
+	if (!fx || !fx->opened)
+		return 0;
+
+	/*
+	 * This calls the internal tty_release() function directly.
+	 * This works because this code is compiled as part of tty_io.c.
+	 */
+	ret = tty_release(fx->inode, fx->file);
+	if (!ret) {
+		fx->opened = false;
+		fx->tty = NULL;
+		fx->port = NULL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_release);
+
+/**
+ * tty_test_write - Write data to TTY
+ */
+ssize_t tty_test_write(struct tty_test_fixture *fx, const void *buf,
+		       size_t count)
+{
+	struct kiocb iocb;
+	struct iov_iter from;
+	struct kvec kvec = { .iov_base = (void *)buf, .iov_len = count };
+
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->file);
+	KUNIT_ASSERT_TRUE(fx->test, fx->opened);
+
+	init_sync_kiocb(&iocb, fx->file);
+	iov_iter_kvec(&from, WRITE, &kvec, 1, count);
+
+	/* tty_write() is exported, so this works */
+	return tty_write(&iocb, &from);
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_write);
+
+/**
+ * tty_test_write_all - Write all data or fail
+ */
+int tty_test_write_all(struct tty_test_fixture *fx, const void *buf, size_t len)
+{
+	size_t off = 0;
+	int retries = 10;
+
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx);
+	KUNIT_ASSERT_TRUE(fx->test, fx->opened);
+
+	while (off < len && retries--) {
+		ssize_t n =
+			tty_test_write(fx, (const char *)buf + off, len - off);
+		if (n < 0)
+			return n;
+		if (n == 0) {
+			/* No progress - prevent infinite loop */
+			if (--retries <= 0) {
+				KUNIT_FAIL(fx->test,
+					   "Write stalled after %zu bytes",
+					   off);
+				return -EIO;
+			}
+			continue;
+		}
+		off += n;
+	}
+
+	if (off < len) {
+		KUNIT_FAIL(fx->test, "Incomplete write: %zu/%zu bytes", off,
+			   len);
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_write_all);
+
+/**
+ * tty_test_read - Read data from TTY (non-blocking)
+ */
+ssize_t tty_test_read(struct tty_test_fixture *fx, void *buf, size_t count)
+{
+	struct kiocb iocb;
+	struct iov_iter to;
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->file);
+	KUNIT_ASSERT_TRUE(fx->test, fx->opened);
+
+	init_sync_kiocb(&iocb, fx->file);
+	iov_iter_kvec(&to, READ, &kvec, 1, count);
+
+	return tty_read(&iocb, &to);
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_read);
+
+/**
+ * tty_test_read_all - Attempt to read all requested data
+ */
+ssize_t tty_test_read_all(struct tty_test_fixture *fx, void *buf, size_t want)
+{
+	size_t off = 0;
+	int tries = 8;
+
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx);
+	KUNIT_ASSERT_TRUE(fx->test, fx->opened);
+
+	while (off < want && tries--) {
+		ssize_t n = tty_test_read(fx, (char *)buf + off, want - off);
+
+		if (n == -EAGAIN)
+			continue;
+		if (n < 0)
+			return n;
+		if (n == 0)
+			continue;
+		off += n;
+	}
+	return off;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_read_all);
+
+/**
+ * tty_test_simulate_rx - Inject received data for testing
+ */
+int tty_test_simulate_rx(struct tty_test_fixture *fx, const unsigned char *data,
+			 size_t len)
+{
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->port);
+	KUNIT_ASSERT_TRUE(fx->test, fx->opened);
+
+	ret = tty_insert_flip_string(fx->port, data, len);
+	if (ret > 0)
+		tty_flip_buffer_push(fx->port);
+
+	return ret;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_simulate_rx);
+
+/**
+ * tty_fx_supports_rx - Check if fixture supports RX testing
+ */
+bool tty_fx_supports_rx(const struct tty_test_fixture *fx)
+{
+	struct tty_ldisc *ld;
+	const struct tty_ldisc_ops *ops;
+
+	if (!fx || !fx->tty || !fx->opened)
+		return false;
+
+	ld = tty_ldisc_ref(fx->tty);
+	if (!ld)
+		return false;
+
+	ops = READ_ONCE(ld->ops);
+	if (ops && (ops->receive_buf || ops->receive_buf2)) {
+		tty_ldisc_deref(ld);
+		return true;
+	}
+
+	tty_ldisc_deref(ld);
+	return false;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_fx_supports_rx);
+
+/**
+ * tty_test_assert_valid_ops - Validate driver has required operations
+ */
+void tty_test_assert_valid_ops(struct kunit *test,
+			       const struct tty_driver *driver)
+{
+	KUNIT_ASSERT_NOT_NULL(test, driver);
+	KUNIT_ASSERT_NOT_NULL(test, driver->ops);
+	KUNIT_ASSERT_NOT_NULL(test, driver->ops->open);
+	KUNIT_ASSERT_NOT_NULL(test, driver->ops->close);
+	KUNIT_ASSERT_NOT_NULL(test, driver->ops->write);
+	KUNIT_ASSERT_NOT_NULL(test, driver->ops->write_room);
+	KUNIT_EXPECT_TRUE(test, driver->flags & TTY_DRIVER_INSTALLED);
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_assert_valid_ops);
+
+/**
+ * tty_test_get_chars_in_buffer - Get number of chars in output buffer
+ */
+unsigned int tty_test_get_chars_in_buffer(struct tty_test_fixture *fx)
+{
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx);
+	KUNIT_ASSERT_TRUE(fx->test, fx->opened);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->tty);
+
+	if (fx->tty->ops->chars_in_buffer)
+		return fx->tty->ops->chars_in_buffer(fx->tty);
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_get_chars_in_buffer);
+
+/**
+ * tty_test_get_write_room - Get available write room
+ */
+unsigned int tty_test_get_write_room(struct tty_test_fixture *fx)
+{
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx);
+	KUNIT_ASSERT_TRUE(fx->test, fx->opened);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->tty);
+
+	if (fx->tty->ops->write_room)
+		return fx->tty->ops->write_room(fx->tty);
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_get_write_room);
+
+/**
+ * tty_test_set_termios - Set terminal attributes for testing
+ */
+int tty_test_set_termios(struct tty_test_fixture *fx,
+			 const struct ktermios *termios)
+{
+	struct ktermios old_termios;
+
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx);
+	KUNIT_ASSERT_TRUE(fx->test, fx->opened);
+	KUNIT_ASSERT_NOT_NULL(fx->test, fx->tty);
+	KUNIT_ASSERT_NOT_NULL(fx->test, termios);
+
+	/* Save old termios for potential restoration */
+	old_termios = fx->tty->termios;
+
+	/* Update termios */
+	fx->tty->termios = *termios;
+
+	/* Call driver's set_termios if it exists */
+	if (fx->tty->ops->set_termios)
+		fx->tty->ops->set_termios(fx->tty, &old_termios);
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(tty_test_set_termios);
diff --git a/drivers/tty/tests/tty_test_helpers.h b/drivers/tty/tests/tty_test_helpers.h
new file mode 100644
index 0000000000000000000000000000000000000000..10da4189e35880399e2c857f599ea7f4107f9e90
--- /dev/null
+++ b/drivers/tty/tests/tty_test_helpers.h
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * KUnit test helpers for TTY drivers - Header declarations
+ *
+ * Provides reusable infrastructure for testing TTY drivers through
+ * real kernel entry points without requiring userspace interaction
+ * or hardware dependencies.
+ *
+ * The implementation (tty_test_helpers.c) is included directly into
+ * tty_io.c to allow access to internal TTY functions while providing
+ * exported symbols for test modules.
+ *
+ * Copyright (c) 2025 Abhinav Saxena <xandfury@gmail.com>
+ *
+ */
+
+#ifndef _TTY_TEST_HELPERS_H
+#define _TTY_TEST_HELPERS_H
+
+#include <kunit/test.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/fs.h>
+
+/**
+ * struct tty_test_fixture - Test fixture for TTY driver testing
+ * @test: KUnit test context for assertions and memory management
+ * @driver: TTY driver being tested
+ * @tty: TTY structure (valid after successful open)
+ * @port: TTY port structure (valid after successful open)
+ * @file: Synthetic file structure for VFS operations
+ * @inode: Synthetic inode structure for device operations
+ * @dev: Device number (major:minor) for this TTY
+ * @opened: True if TTY has been opened successfully
+ *
+ * This fixture provides all necessary structures for testing TTY drivers
+ * through the standard kernel interfaces. Memory is managed by KUnit and
+ * automatic cleanup ensures proper resource release.
+ */
+struct tty_test_fixture {
+	struct kunit *test;
+	struct tty_driver *driver;
+	struct tty_struct *tty;
+	struct tty_port *port;
+	struct file *file;
+	struct inode *inode;
+	dev_t dev;
+	bool opened;
+};
+
+/* Core fixture management */
+
+/**
+ * tty_test_create_fixture - Create a test fixture for TTY driver testing
+ * @test: KUnit test context
+ * @driver: TTY driver to test (must be registered)
+ * @index: Minor number index for this TTY instance
+ *
+ * Creates a complete test fixture with synthetic VFS structures that
+ * enable testing through real tty_open()/tty_release() paths.
+ * All memory is managed by KUnit with automatic cleanup.
+ *
+ * Return: Allocated fixture or NULL on failure (test will abort)
+ */
+struct tty_test_fixture *tty_test_create_fixture(struct kunit *test,
+						 struct tty_driver *driver,
+						 unsigned int index);
+
+/* TTY lifecycle operations */
+
+/**
+ * tty_test_open - Open TTY through standard kernel path
+ * @fx: Test fixture created with tty_test_create_fixture()
+ *
+ * Opens the TTY using tty_open(), the same entry point used by userspace.
+ * This exercises the complete open sequence including driver install,
+ * line discipline attachment, and port initialization.
+ *
+ * After successful open:
+ * - fx->tty points to the allocated TTY structure
+ * - fx->port points to the associated TTY port
+ * - File is set to non-blocking mode for test convenience
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int tty_test_open(struct tty_test_fixture *fx);
+
+/**
+ * tty_test_release - Close TTY through standard kernel path
+ * @fx: Test fixture with opened TTY
+ *
+ * Closes the TTY using tty_release(), exercising the complete close
+ * Safe to call multiple times or on unopened fixtures.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int tty_test_release(struct tty_test_fixture *fx);
+
+/* Data transfer operations */
+
+/**
+ * tty_test_write - Write data to TTY
+ * @fx: Test fixture with opened TTY
+ * @buf: Data buffer to write
+ * @count: Number of bytes to write
+ *
+ * Writes data using tty_write(), the same path used by userspace write().
+ * This exercises line discipline processing, flow control, and driver
+ * write operations. May return partial writes based on buffer availability.
+ *
+ * Return: Number of bytes written, or negative error code
+ */
+ssize_t tty_test_write(struct tty_test_fixture *fx, const void *buf,
+		       size_t count);
+
+/**
+ * tty_test_write_all - Write all data or fail
+ * @fx: Test fixture with opened TTY
+ * @buf: Data buffer to write completely
+ * @len: Number of bytes that must be written
+ *
+ * Ensures all data is written by retrying partial writes.
+ * Useful for testing scenarios where complete data delivery is required.
+ * Will assert-fail the test if any individual write returns 0 bytes.
+ *
+ * Return: 0 on complete success, negative error code on failure
+ */
+int tty_test_write_all(struct tty_test_fixture *fx, const void *buf,
+		       size_t len);
+
+/**
+ * tty_test_read - Read data from TTY (non-blocking)
+ * @fx: Test fixture with opened TTY
+ * @buf: Buffer to receive data
+ * @count: Maximum bytes to read
+ *
+ * Reads data using tty_read() in non-blocking mode. This is useful for
+ * verifying that injected RX data is properly delivered through the
+ * line discipline to userspace. Returns immediately with -EAGAIN if
+ * no data is available.
+ *
+ * Return: Number of bytes read, -EAGAIN if no data, or other negative error
+ */
+ssize_t tty_test_read(struct tty_test_fixture *fx, void *buf, size_t count);
+
+/**
+ * tty_test_read_all - Attempt to read all requested data
+ * @fx: Test fixture with opened TTY
+ * @buf: Buffer to receive data
+ * @want: Number of bytes desired
+ *
+ * Makes a bounded number of read attempts to collect the requested amount
+ * of data. Useful for reading back data that was injected via flip buffers,
+ * accounting for potential delays in line discipline processing.
+ *
+ * Return: Number of bytes actually read (may be less than requested)
+ */
+ssize_t tty_test_read_all(struct tty_test_fixture *fx, void *buf, size_t want);
+
+/* RX simulation and testing */
+
+/**
+ * tty_test_simulate_rx - Inject received data for testing
+ * @fx: Test fixture with opened TTY
+ * @data: Data bytes to inject
+ * @len: Number of bytes to inject
+ *
+ * Simulates data reception by injecting bytes through the flip buffer
+ * interface and pushing them to the line discipline. This allows testing
+ * of RX data paths, flow control, and line discipline processing without
+ * requiring actual hardware or external data sources.
+ *
+ * Return: Number of bytes successfully queued, or negative error code
+ */
+int tty_test_simulate_rx(struct tty_test_fixture *fx, const unsigned char *data,
+			 size_t len);
+
+/**
+ * tty_fx_supports_rx - Check if fixture supports RX testing
+ * @fx: Test fixture to check
+ *
+ * Determines if the TTY has a line discipline attached that can receive
+ * data. This is used to conditionally run RX-related tests since not all
+ * TTY configurations support data reception (e.g., write-only devices).
+ *
+ * Return: true if RX testing is supported, false otherwise
+ */
+bool tty_fx_supports_rx(const struct tty_test_fixture *fx);
+
+/* Driver validation and utility functions */
+
+/**
+ * tty_test_assert_valid_ops - Validate driver has required operations
+ * @test: KUnit test context
+ * @driver: TTY driver to validate
+ *
+ * Performs basic sanity checks on TTY driver structure to ensure it has
+ * the minimum required operations. This catches configuration errors that
+ * would cause NULL pointer dereferences during testing.
+ */
+void tty_test_assert_valid_ops(struct kunit *test,
+			       const struct tty_driver *driver);
+
+/**
+ * tty_test_get_chars_in_buffer - Get number of chars in output buffer
+ * @fx: Test fixture with opened TTY
+ *
+ * Returns the number of characters currently in the driver's output buffer.
+ * Useful for testing flow control and buffer management.
+ *
+ * Return: Number of characters in buffer, or 0 if not supported
+ */
+unsigned int tty_test_get_chars_in_buffer(struct tty_test_fixture *fx);
+
+/**
+ * tty_test_get_write_room - Get available write room
+ * @fx: Test fixture with opened TTY
+ *
+ * Returns the number of bytes that can be written without blocking.
+ * Useful for testing buffer management and flow control.
+ *
+ * Return: Number of bytes available for writing
+ */
+unsigned int tty_test_get_write_room(struct tty_test_fixture *fx);
+
+/**
+ * tty_test_set_termios - Set terminal attributes for testing
+ * @fx: Test fixture with opened TTY
+ * @termios: Terminal attributes to set
+ *
+ * Sets terminal attributes through the standard termios interface.
+ * Useful for testing different terminal configurations.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int tty_test_set_termios(struct tty_test_fixture *fx,
+			 const struct ktermios *termios);
+
+#endif /* _TTY_TEST_HELPERS_H */
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e2d92cf70eb78ec6b2b93b55192e46781160c9dc..ac94a037358c9df0ba4013152878ca83a2e001c5 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3650,3 +3650,7 @@ int __init tty_init(void)
 #endif
 	return 0;
 }
+
+#ifdef CONFIG_TTY_KUNIT_TESTS
+#include "tests/tty_test_helpers.c"
+#endif

-- 
2.43.0

