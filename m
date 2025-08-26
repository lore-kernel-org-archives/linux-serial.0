Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BAE2F6581;
	Tue, 26 Aug 2025 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248716; cv=none; b=gjiZy/vMdocBvsMpsHcn8FKy4gHV39YFLn45gxin7e7hZKDD/mmyvQGnKPbXnH+BrTEX+hlFlmxgEKBbcCnJU30ibgnrT1HesJPlVA2LOjQcdsQM8VV8D55TcZxkk3wWSPMKavBxlHf3dR9cg4MwdGZOdG52K5NRkFq7nmnwj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248716; c=relaxed/simple;
	bh=JdXE8vYkTFnIcf9QUL8Bbqunld/9cGDUOO7aLLjXBeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h90BXqXoFyTSJfoJM5q6e0a+mKoiKpC9pgrTtAK4qwJpeslqSy4Iu7fa5hC9e6+/X13+BsBN3x6YTl39uDXHQDKW+HjrPBt7XPRjrFkpgMksyKMyIiBJYNsQ40J5A0DTKrLCyYR+vFXYm9FmN5N8LZmdQk3T+9VybWkIVIYKOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPGdXlqf; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPGdXlqf"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5376762a12.3;
        Tue, 26 Aug 2025 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756248713; x=1756853513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHq0wOrjV9AurPX5OQC4kD0MhUkJbDMxr/dKfoG/qIc=;
        b=GPGdXlqfS7+y9UPy95X6+Qr5W6jCOVrKXcOEPnudc/D+oA0tRsTwsPbIWI95bpySwL
         XysjN6EeQ6vjWsgTeV5MBkNaBvlr+ZI8RRtth7gnWf115Nt92ieYD9cxs09dZm/c/s2W
         KXCl6zitnx8d46ief84de7qAPFi/hPNMDUXKEate06XP7xR5rCWnDyt7CrUfkCRQMXep
         1EM2ZhdVJiqOXAlCI8di+vjniv7cY7ANGSsV2myDLxHAxmWRh17CNjwvuVvnHiBgADd4
         8BIQpoAMS6Mc7+KOec5qHzVVJerpUTagoLXPnN3Yxz1lbS30R17Pwjgq/AYTklQxPZuc
         fPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756248713; x=1756853513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHq0wOrjV9AurPX5OQC4kD0MhUkJbDMxr/dKfoG/qIc=;
        b=kSoVNfEQ28d1CO82QU7mhAOHK6JGp2LRGvZfZT68tWxLqVa0G7Nqnz4zFrDRhJBEgn
         45MOYFzLrt6lKF46XU6nKkcC2sf8Dpi2LEg1Tul8TycdrSpKTX342PdhpCjejRdNAQm3
         cWBYppkGrsZOF4gNc0wPmV3IGk6RxQUOOZIqTD9OOuGjnfgxgEDpRNEQsT67etT9h8CR
         OimTQ2GGoRUo5u1DE+DqaolB9+9TW/9Iv0ykCgG9xaiJ0O5RWmpWiss3MDE4GsbHkBII
         /FQ8PkLIzALh+5qV5JxEOFL2N8QCX4ikgfPQoRWx/IFwZ4AYv4gHyVKtd7/05p6hjVtp
         yCqw==
X-Forwarded-Encrypted: i=1; AJvYcCUYTchQTr+SusTsCt12FrZlLnhJ49UYQ/wV7j9vN1xDe6aOI10B6h4/09u8tWwl/Ewve5CGlh3sv4EU2xGa@vger.kernel.org, AJvYcCVhKKSSqaztU3W5nIAX6LG0pbljek5q0u39cSvtLRWmQwxpV/eoGO2hDwhoFZKZAnRPqGiR16669o4aKQqTKS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwikkevLsOj6osOAJ8+7AI016t7cYQrx26cFTYmIMnWWG+IZm72
	fScpPPy+xBERGG39LwoeGX1ZPoSa3z60LpdytIAMLZWfClA7lvKDDqRd
X-Gm-Gg: ASbGnct2woCpR5xQx2TcZFVlkRf9gypUJbb0TqRozDRjDX2qkjjIV+leOcvCKZW5E3F
	HsYGHv5diKw2lDO9l2OqO+94YYoFWCQRsQ9DkGEFSumpAuJ/1F3JBS8NUaMpkWumIl6ZkJn+GyF
	7F1rJ+3g6wIlq4TjoeDPDdet+3xrosfjKu3u75sme3mqV/Q6kqzQk136BV+tWZqkridNOId5trS
	MNFC61pAiHdYx3Y2I45FV5Y1fmHElFgOI6SrIEE9qrD8SG32kA3LhEIedc3lXIq6YZ/yMfYGKOD
	SXxQobtdfWJOyE3V6DcL/KvUeSTdGK9eVETAU5Rh4H9H2syTDsde+OItUjTTsBse2a2vztqyW4w
	KsAbH/z//BN4Z90ZDqlpo
X-Google-Smtp-Source: AGHT+IEr+9+07tQY/svF8vxrQjSuh6tfMO477xgIAefkyL5oX4CM+zCYiWD5GZXlBL0j65L4qV9sow==
X-Received: by 2002:a17:902:da47:b0:246:cf6a:f009 with SMTP id d9443c01a7336-246cf6af466mr105265565ad.46.1756248713253;
        Tue, 26 Aug 2025 15:51:53 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a601esm105340815ad.162.2025.08.26.15.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 15:51:52 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Tue, 26 Aug 2025 16:51:34 -0600
Subject: [RFC PATCH 4/5] tty: Add KUnit tests for core TTY functionality
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-tty-tests-v1-4-e904a817df92@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756248706; l=9255;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=JdXE8vYkTFnIcf9QUL8Bbqunld/9cGDUOO7aLLjXBeU=;
 b=WqwZ5Q8Yl82sL6CVZHhtWuxnm9v49DBwgCcVpn3exni0niQg2t1WdihaidhjM30HnO9J9OgTt
 fRlYMROK45eADhdp8gP3f9i6TEDiCGm84X9hkycUNzcpusN6cgaCfbN
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Add comprehensive KUnit tests covering fundamental TTY operations:
- Driver registration and operation validation
- Open/close lifecycle with proper cleanup
- Write operations and buffer management
- Flow control via write_room() and chars_in_buffer()
- RX data injection via line discipline
- Termios configuration for hardware parameters

Tests exercise real kernel code paths using the mock driver to ensure
TTY subsystem changes don't introduce regressions in core functionality.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 drivers/tty/tests/test_tty_io_core.c | 249 +++++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/drivers/tty/tests/test_tty_io_core.c b/drivers/tty/tests/test_tty_io_core.c
new file mode 100644
index 0000000000000000000000000000000000000000..626160e6ed738d56575cd340b3662aaa94f46a0a
--- /dev/null
+++ b/drivers/tty/tests/test_tty_io_core.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Minimal KUnit tests for TTY core using the mock driver.
+ *
+ * Scope:
+ *  - open/close via tty_port_* paths
+ *  - write() returns cnt, write_room() is large, chars_in_buffer() == 0
+ *  - stats (writes, bytes, last len) observable via tty_mock_get_stats()
+ *  - file_ops read functionality with various termios configurations
+ *  - set_termios operations for practical use cases
+ *
+ * Keep this small and obvious—no driver-side buffering or timers.
+ *
+ * Copyright (c) 2025 Abhinav Saxena <xandury@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
+#include <linux/string.h>
+
+#include "tty_test_helpers.h"
+#include "tty_mock.h"          /* mock driver API: register/unregister/stats */
+
+/* Single-port driver used across tests (minor 0). */
+static struct tty_driver *mock_driver;
+
+/* ---------- Per-test init: sanity only ---------- */
+static int tty_core_init(struct kunit *test)
+{
+	KUNIT_ASSERT_NOT_NULL(test, mock_driver);
+
+	/* Reset mock statistics before each test */
+	tty_mock_reset_stats();
+
+	if (mock_driver && mock_driver->ports)
+		KUNIT_EXPECT_NOT_NULL(test, mock_driver->ports[0]);
+	return 0;
+}
+
+/* ---------- Tests ---------- */
+
+/*
+ * Test: Verify mock driver has all required operations wired correctly.
+ * Expected: All mandatory ops present, ports array initialised, no NULL pointers.
+ */
+static void test_driver_ops_present(struct kunit *test)
+{
+	KUNIT_ASSERT_NOT_NULL(test, mock_driver);
+
+	/* Basic ops presence and wiring checks via helper. */
+	tty_test_assert_valid_ops(test, mock_driver);
+	KUNIT_EXPECT_NOT_NULL(test, mock_driver->ops->write);
+	KUNIT_EXPECT_NOT_NULL(test, mock_driver->ops->write_room);
+	KUNIT_EXPECT_NOT_NULL(test, mock_driver->ops->chars_in_buffer);
+
+	if (mock_driver->ports)
+		KUNIT_EXPECT_NOT_NULL(test, mock_driver->ports[0]);
+}
+
+/*
+ * Test: Basic TTY lifecycle (open/write/close).
+ * Expected: write() returns byte count, stats increment correctly,
+ * ldisc/port setup.
+ */
+static void test_basic_open_write_close(struct kunit *test)
+{
+	unsigned int idx = 0;
+	struct tty_test_fixture *fx;
+	const char *msg = "Hello, tty!\n";
+	struct tty_mock_stats before, after;
+	ssize_t ret;
+
+	fx = tty_test_create_fixture(test, mock_driver, idx);
+	KUNIT_ASSERT_NOT_NULL(test, fx);
+	KUNIT_ASSERT_EQ(test, tty_test_open(fx), 0);
+	KUNIT_ASSERT_TRUE(test, fx->opened);
+
+	KUNIT_EXPECT_TRUE(test,
+			  fx->tty && fx->tty->ldisc && fx->tty->ldisc->ops);
+	KUNIT_EXPECT_TRUE(test, !list_empty(&fx->tty->tty_files));
+	KUNIT_EXPECT_NOT_NULL(test, fx->tty->port);
+
+	before = tty_mock_get_stats();
+
+	ret = tty_test_write(fx, msg, strlen(msg));
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)strlen(msg));
+
+	after = tty_mock_get_stats();
+
+	/* Test interface contract, not implementation details */
+	KUNIT_EXPECT_GT(test, after.total_writes, before.total_writes);
+	KUNIT_EXPECT_GE(test, after.total_bytes,
+			before.total_bytes + strlen(msg));
+	KUNIT_EXPECT_GT(test, after.last_write_len, 0u);
+
+	KUNIT_EXPECT_EQ(test, tty_test_release(fx), 0);
+}
+
+/*
+ * Test: write_room() and chars_in_buffer() consistency during operations.
+ * Expected: write_room() > 0, chars_in_buffer() == 0, room unchanged after
+ * writes.
+ */
+static void test_write_room_and_chars_in_buffer_invariants(struct kunit *test)
+{
+	unsigned int idx = 0;
+	struct tty_test_fixture *fx;
+	char buf[64];
+	unsigned int room_before, room_after;
+	ssize_t ret;
+
+	memset(buf, 'A', sizeof(buf));
+
+	fx = tty_test_create_fixture(test, mock_driver, idx);
+	KUNIT_ASSERT_NOT_NULL(test, fx);
+	KUNIT_ASSERT_EQ(test, tty_test_open(fx), 0);
+
+	room_before = tty_write_room(fx->tty);
+	KUNIT_EXPECT_GT(test, room_before, 0u);
+	KUNIT_EXPECT_EQ(test, fx->tty->ops->chars_in_buffer(fx->tty), 0u);
+
+	ret = tty_test_write(fx, buf, sizeof(buf));
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)sizeof(buf));
+
+	room_after = tty_write_room(fx->tty);
+	KUNIT_EXPECT_EQ(test, fx->tty->ops->chars_in_buffer(fx->tty), 0u);
+	KUNIT_EXPECT_GE(test, room_after, room_before);
+
+	KUNIT_EXPECT_EQ(test, tty_test_release(fx), 0);
+}
+
+/*
+ * Test: RX data injection via flip buffers if line discipline supports it.
+ * Expected: tty_test_simulate_rx() returns injected byte count, or test
+ * skipped.
+ */
+static void test_flip_rx_if_supported(struct kunit *test)
+{
+	unsigned int idx = 0;
+	struct tty_test_fixture *fx;
+	int rx_result;
+
+	/* Raw byte buffer, not NUL-terminated */
+	static const unsigned char rx_data[] = "rx-line\n";
+
+	fx = tty_test_create_fixture(test, mock_driver, idx);
+	KUNIT_ASSERT_NOT_NULL(test, fx);
+	KUNIT_ASSERT_EQ(test, tty_test_open(fx), 0);
+
+	KUNIT_EXPECT_TRUE(test,
+			  fx->tty && fx->tty->ldisc && fx->tty->ldisc->ops);
+	KUNIT_EXPECT_TRUE(test, !list_empty(&fx->tty->tty_files));
+	KUNIT_EXPECT_NOT_NULL(test, fx->tty->port);
+
+	if (tty_fx_supports_rx(fx)) {
+		rx_result = tty_test_simulate_rx(fx, rx_data, sizeof(rx_data));
+		KUNIT_EXPECT_EQ(test, rx_result, (int)sizeof(rx_data));
+	} else {
+		kunit_skip(test,
+			   "ldisc does not support RX; skipping injection");
+	}
+
+	KUNIT_EXPECT_EQ(test, tty_test_release(fx), 0);
+}
+
+/*
+ * Test: set_termios() for hardware settings (baud rate, character size, parity).
+ * Expected: c_cflag settings persist correctly, hardware parameters validated.
+ */
+static void test_set_termios_baud_rate_and_character_size(struct kunit *test)
+{
+	unsigned int idx = 0;
+	struct tty_test_fixture *fx;
+	struct ktermios termios_before, termios_after;
+
+	fx = tty_test_create_fixture(test, mock_driver, idx);
+	KUNIT_ASSERT_NOT_NULL(test, fx);
+	KUNIT_ASSERT_EQ(test, tty_test_open(fx), 0);
+
+	/* Get initial termios */
+	termios_before = fx->tty->termios;
+
+	/* Test baud rate changes */
+	termios_after = termios_before;
+	termios_after.c_cflag &= ~CBAUD;
+	termios_after.c_cflag |= B9600;
+	KUNIT_ASSERT_EQ(test, tty_test_set_termios(fx, &termios_after), 0);
+	KUNIT_EXPECT_EQ(test, fx->tty->termios.c_cflag & CBAUD, B9600);
+
+	/* Test higher baud rate */
+	termios_after.c_cflag &= ~CBAUD;
+	termios_after.c_cflag |= B115200;
+	KUNIT_ASSERT_EQ(test, tty_test_set_termios(fx, &termios_after), 0);
+	KUNIT_EXPECT_EQ(test, fx->tty->termios.c_cflag & CBAUD, B115200);
+
+	/* Test character size changes */
+	termios_after.c_cflag &= ~CSIZE;
+	termios_after.c_cflag |= CS7; /* 7-bit characters */
+	KUNIT_ASSERT_EQ(test, tty_test_set_termios(fx, &termios_after), 0);
+	KUNIT_EXPECT_EQ(test, fx->tty->termios.c_cflag & CSIZE, CS7);
+
+	termios_after.c_cflag &= ~CSIZE;
+	termios_after.c_cflag |= CS8; /* 8-bit characters */
+	KUNIT_ASSERT_EQ(test, tty_test_set_termios(fx, &termios_after), 0);
+	KUNIT_EXPECT_EQ(test, fx->tty->termios.c_cflag & CSIZE, CS8);
+
+	/* Test parity settings */
+	termios_after.c_cflag |= PARENB; /* Enable parity */
+	termios_after.c_cflag &= ~PARODD; /* Even parity */
+	KUNIT_ASSERT_EQ(test, tty_test_set_termios(fx, &termios_after), 0);
+	KUNIT_EXPECT_TRUE(test, fx->tty->termios.c_cflag & PARENB);
+	KUNIT_EXPECT_FALSE(test, fx->tty->termios.c_cflag & PARODD);
+
+	KUNIT_EXPECT_EQ(test, tty_test_release(fx), 0);
+}
+
+/* ---------- Suite registration ---------- */
+
+static int tty_core_suite_init(struct kunit_suite *suite)
+{
+	return tty_mock_register(&mock_driver, NULL);
+}
+
+static void tty_core_suite_exit(struct kunit_suite *suite)
+{
+	tty_mock_unregister(mock_driver);
+	mock_driver = NULL;
+}
+
+static struct kunit_case tty_core_cases[] = {
+	KUNIT_CASE(test_driver_ops_present),
+	KUNIT_CASE(test_basic_open_write_close),
+	KUNIT_CASE(test_write_room_and_chars_in_buffer_invariants),
+	KUNIT_CASE(test_flip_rx_if_supported),
+	KUNIT_CASE(test_set_termios_baud_rate_and_character_size),
+	{}
+};
+
+static struct kunit_suite tty_core_suite = {
+	.name = "tty_io_core",
+	.init = tty_core_init,
+	.suite_init = tty_core_suite_init,
+	.suite_exit = tty_core_suite_exit,
+	.test_cases = tty_core_cases,
+};
+
+kunit_test_suite(tty_core_suite);

-- 
2.43.0

