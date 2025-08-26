Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4912F8BE7;
	Tue, 26 Aug 2025 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248717; cv=none; b=dlXTqEezvy1ULwunUf8vOw/XUHLIyRcSpKZIbUnQVekItmNymPS1jqY+IGjUVD0FHY57XHGBV0hw1DpjURjEWpjsW1f1CvTmUa0NNmx9K+ovo5RzvLKna6Yzqi7D962sBGE9aX/pdJCUywcVL8SodLQwl8/poTfP91m/xjul9g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248717; c=relaxed/simple;
	bh=2sCgtf0iJuHZoEJ+ZjgF8LGfcrJ2jnuz9b44H6Mk4Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jczd8bseR8U5u2uIu/x8MP2ngLX4DgY4jLgO4tgdrMzqj73LpFF2UM4sRnMncfZuT6mxNRs4xRSbfTw56pn0kxG/LUer7W4Wu+3Mc3DXbD+JxE+Jc/Hu7PAn/zjPEL01bYySgMDErT6riFKN/7SpT3LoKhGJRmVwRn/x2IeXA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcVgD9H2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcVgD9H2"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c1aefa8deso1845490a12.0;
        Tue, 26 Aug 2025 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756248714; x=1756853514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFHzcEkMkKxjDsW7QyH+21adtRUMu8g3PdBU38OriB8=;
        b=NcVgD9H2oV+3W3WZgSxk5cF2Q2Vpz5ntRs7Ird924aZ7eg4iGktBEJ8prAAJ30+nDD
         U0bYB7TBC+2zGfk2Gba81Q5dN+D3yVoLMcB8Bi/dU31mQpcXuewcJjsKZgzML5z9vvcH
         4dblovf26PwLh8qOTj1HYk1Ne3WdvhPanSQyiCrzLOOZKFzbsfAlgkoLeycmiMy6f3xq
         2v9qgXFChHxzYcaNmtt4CGjPJ/tIU33sGroyCV/l8CaXAjrkwR2GqmS7kEZVBpvXAsT8
         hdbGThnLefZGwde2l4p5G5wXFRVqiCnASvGHdnRmzwdrt8GzU7yoWM2XuTy5+AmYEQrX
         Pr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756248714; x=1756853514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFHzcEkMkKxjDsW7QyH+21adtRUMu8g3PdBU38OriB8=;
        b=iiuIp22RtFJvslkRpn9799VMrMcxG/UoQEGiXr0bDoXFmTLHKAZao9hlqm+6zLSpu1
         A03e4rv2L2I3zTCgzSFGaVAMCTTMQQfmvGqW+M92z53NYUmoXHuHPX8UnOtQ7RLaERQ9
         nO5OJUk3oW+famptrocbF+BplFRVYnsndR9AwipGXpx8w3NbbDmHs7JBxNq+hKBaVu2Y
         Jv1SFzfu2fKR7W9+jem9LZMvA5aJXDueE50qlMkppf6KjWl+jCaXwsyxnvl4LkG6yDCY
         UKt7tlLtz6gRdtwiarkKZMXdxSgYUPXqGUACxyl8pjTsKOfih7Ntin8GTeuUAsX9r3Wn
         8aFw==
X-Forwarded-Encrypted: i=1; AJvYcCUIPdNAHxEGn6C9zNz/UKtBASMduwOUjczY6NpOPx9Jq1Lz5eyy6N2gZzA4x400+QCFDqp/I04O7wPT6E30KSw=@vger.kernel.org, AJvYcCWHFZ1naGJWILCI95bR+67f6qVhbRcKTP8qIDO588en2ugCi2pOd9eVVjX68FSW1TVDX1sNDJXasyuRSWCc@vger.kernel.org
X-Gm-Message-State: AOJu0YwABRl/xxCPB4sMUSwXgQZkQpHKD/UdScTH6U4DAsITDbCUw8/I
	qMlxik9//RWRYAEqYiPUpy7/ufAuS/xObS49opJA9LEs3gEA/9ugErRg
X-Gm-Gg: ASbGncv+c+BVFNaCsp+y2X3aEX1jZpVft9+10PXpw9QhFhIy2ILrYw+mprGISOoCur5
	k6crXGl0SnZux7XiMVXxO5N4A/sFBKGvoFYYYPWZyAChEQInyslXDztW1L36wd4a6OYkqvUUYzH
	x/3cz/U+We3AfDR/zKyjKaliKTBct9p8TlEdo1MqLczhfRUmMMJ9UWPecQ/UPFrtj8s00o7gNdJ
	Io0pIefYWupPs0HDK82L6yIQVc1HBj8bOvNwOq5vl8slo7a4+Nro8hMZvsfrXcgdZ/YxGpM7kMj
	bXoCbiv3TA1uagcRJkPsc6kGg/Wqr7XGQNI6icUg3Ipmotv781ngXqNH3A3PwnFu8kGkq2XkGPw
	D+Szgg7wsg/RVKqaDyl7u
X-Google-Smtp-Source: AGHT+IHBbRvLzIIWrINVvaClB1b0OPUk6BLcoAKkgULcCrNboGggfEcV+NS6zLTIGPlFc2xR7s/r5w==
X-Received: by 2002:a17:903:2f50:b0:240:e9d:6c43 with SMTP id d9443c01a7336-2462efa3c78mr199299725ad.51.1756248714470;
        Tue, 26 Aug 2025 15:51:54 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a601esm105340815ad.162.2025.08.26.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 15:51:54 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Tue, 26 Aug 2025 16:51:35 -0600
Subject: [RFC PATCH 5/5] tty: Add KUnit tests for ttynull driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-tty-tests-v1-5-e904a817df92@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756248707; l=6787;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=2sCgtf0iJuHZoEJ+ZjgF8LGfcrJ2jnuz9b44H6Mk4Ks=;
 b=7wonk4jVg8NsrTTBrfr6ESAy6WZFree5W8bJr7L4QLz5S5/8f6osUqGimZhjCM+tfxdsy0G/x
 5lMJhbjAnpQAT+KhMfWgRJQVpiNA4sbrEiobc0DSKSK13IqYtS0ervS
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Add targeted tests for the TTY null driver covering its data sink
behavior and driver characteristics. Tests verify that ttynull
properly discards written data while maintaining standard TTY
semantics for applications requiring TTY interfaces without
caring about output.

The tests are integrated directly into ttynull.c when
CONFIG_TTY_KUNIT_NULL_TTY_TESTS=y to test the actual driver
implementation.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 drivers/tty/tests/test_ttynull.c | 163 +++++++++++++++++++++++++++++++++++++++
 drivers/tty/ttynull.c            |   5 ++
 2 files changed, 168 insertions(+)

diff --git a/drivers/tty/tests/test_ttynull.c b/drivers/tty/tests/test_ttynull.c
new file mode 100644
index 0000000000000000000000000000000000000000..c062d69bd5d5975ab84442a83426a1d44440b0a6
--- /dev/null
+++ b/drivers/tty/tests/test_ttynull.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for the TTY null driver
+ *
+ * Tests for the ttynull driver covering basic lifecycle and sink behavior.
+ * The ttynull driver acts as a data sink, discarding all written data
+ * while providing minimal overhead for applications that need a TTY
+ * but don't care about the output.
+ *
+ * Copyright (c) 2025 Abhinav Saxena <xandury@gmail.com>
+ *
+ */
+
+#include <kunit/test.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
+#include <linux/string.h>
+
+#include "tests/tty_test_helpers.h"
+
+/**
+ * test_ttynull_write_sink - Verify ttynull acts as data sink
+ * @test: KUnit test context
+ *
+ * ttynull should accept all write data and discard it silently.
+ * This tests the core functionality of the null TTY driver.
+ */
+static void test_ttynull_write_sink(struct kunit *test)
+{
+	struct tty_driver *drv = ttynull_driver;
+	struct tty_test_fixture *fx;
+	const char *msg = "test data; discard me";
+	unsigned int room;
+	ssize_t write_result;
+
+	fx = tty_test_create_fixture(test, drv, 0);
+	KUNIT_ASSERT_NOT_NULL(test, fx);
+
+	KUNIT_ASSERT_EQ(test, tty_test_open(fx), 0);
+	KUNIT_ASSERT_TRUE(test, fx->opened);
+
+	/* Verify TTY is properly initialized */
+	KUNIT_EXPECT_NOT_NULL(test, fx->tty);
+	KUNIT_EXPECT_NOT_NULL(test, fx->tty->ldisc);
+	KUNIT_EXPECT_TRUE(test, !list_empty(&fx->tty->tty_files));
+
+	/* Check initial write room - should be available */
+	room = tty_test_get_write_room(fx);
+	KUNIT_EXPECT_GT(test, room, 0U);
+
+	/* Write data - should be completely accepted */
+	KUNIT_ASSERT_EQ(test, tty_test_write_all(fx, msg, strlen(msg)), 0);
+
+	/* ttynull discards writes; buffer should remain empty */
+	KUNIT_EXPECT_EQ(test, tty_test_get_chars_in_buffer(fx), 0U);
+
+	/* Write room should remain available for a sink */
+	room = tty_test_get_write_room(fx);
+	KUNIT_EXPECT_GT(test, room, 0U);
+
+	/* ttynull should accept all data */
+	write_result = tty_test_write(fx, msg, strlen(msg));
+	KUNIT_EXPECT_EQ(test, write_result, strlen(msg));
+
+	/* Multiple writes should all succeed */
+	write_result = tty_test_write(fx, msg, strlen(msg));
+	KUNIT_EXPECT_EQ(test, write_result, strlen(msg));
+
+	/*
+	 * TODO: Simulate hangup condition making subsequent writes fail
+	 * For now, just release.
+	 */
+	KUNIT_ASSERT_EQ(test, tty_test_release(fx), 0);
+}
+
+/**
+ * test_ttynull_read_behavior - Verify read behavior on null device
+ * @test: KUnit test context
+ *
+ * While ttynull technically supports read (via N_TTY), reading should
+ * behave predictably (likely EOF or blocking).
+ */
+static void test_ttynull_read_behavior(struct kunit *test)
+{
+	struct tty_driver *drv = ttynull_driver;
+	struct tty_test_fixture *fx;
+	struct tty_ldisc *ld;
+	/* char read_buffer[128]; */
+	/* ssize_t bytes_read; */
+
+	fx = tty_test_create_fixture(test, drv, 0);
+	KUNIT_ASSERT_NOT_NULL(test, fx);
+
+	KUNIT_ASSERT_EQ(test, tty_test_open(fx), 0);
+	KUNIT_ASSERT_TRUE(test, fx->opened);
+
+	ld = tty_ldisc_ref(fx->tty);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ld);
+	KUNIT_ASSERT_TRUE(test, ld->ops && ld->ops->read);
+	tty_ldisc_deref(ld);
+
+	/*
+	 * Reading from ttynull should behave consistently.
+	 * Depending on implementation, this might:
+	 * - Return 0 (EOF)
+	 * - Block (if no data available)
+	 * - Return -EAGAIN (if non-blocking)
+	 */
+	KUNIT_ASSERT_NOT_NULL(test, fx->tty->disc_data);
+	/* bytes_read = tty_test_read(fx, read_buffer, sizeof(read_buffer)); */
+
+	/*
+	 * Document the expected behavior
+	 *  - adjust based on actual ttynull implementation
+	 */
+	/* KUNIT_EXPECT_GE(test, bytes_read, 0); /\* Should not return error *\/ */
+
+	KUNIT_ASSERT_EQ(test, tty_test_release(fx), 0);
+}
+
+/**
+ * test_ttynull_driver_properties - Verify driver characteristics
+ * @test: KUnit test context
+ *
+ * Test the driver's static properties and configuration. Also, ensure that
+ * it implements the required file_operation ops.
+ */
+static void test_ttynull_driver_properties(struct kunit *test)
+{
+	struct tty_driver *drv = ttynull_driver;
+
+	KUNIT_ASSERT_NOT_NULL(test, drv);
+
+	/* Verify driver identification */
+	KUNIT_EXPECT_STREQ(test, drv->driver_name, "ttynull");
+	KUNIT_EXPECT_STREQ(test, drv->name, "ttynull");
+
+	/* Ensure that driver implements the required ops. */
+	KUNIT_ASSERT_NOT_NULL(test, drv);
+	tty_test_assert_valid_ops(test, drv);
+
+	/* Verify driver type */
+	KUNIT_EXPECT_EQ(test, drv->type, TTY_DRIVER_TYPE_CONSOLE);
+
+	/* Verify driver flags */
+	KUNIT_EXPECT_TRUE(test, drv->flags & TTY_DRIVER_REAL_RAW);
+	KUNIT_EXPECT_TRUE(test, drv->flags & TTY_DRIVER_RESET_TERMIOS);
+}
+
+static struct kunit_case ttynull_test_cases[] = {
+	KUNIT_CASE(test_ttynull_write_sink),
+	KUNIT_CASE(test_ttynull_read_behavior),
+	KUNIT_CASE(test_ttynull_driver_properties),
+	{}
+};
+
+static struct kunit_suite ttynull_test_suite = {
+	.name = "ttynull",
+	.test_cases = ttynull_test_cases,
+};
+
+kunit_test_suite(ttynull_test_suite);
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 6b2f7208b564b659bf7faa4113541fcea7ec6ac0..baad9f0e3d27d97409a571e8da953384b7c64891 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2010 Samo Pogacnik
  */
 
+#include <kunit/visibility.h>
 #include <linux/console.h>
 #include <linux/module.h>
 #include <linux/tty.h>
@@ -106,5 +107,9 @@ static void __exit ttynull_exit(void)
 module_init(ttynull_init);
 module_exit(ttynull_exit);
 
+#ifdef CONFIG_TTY_KUNIT_NULL_TTY_TESTS
+#include "tests/test_ttynull.c"
+#endif /* CONFIG_TTY_KUNIT_TTYNULL_TESTS */
+
 MODULE_DESCRIPTION("NULL TTY driver");
 MODULE_LICENSE("GPL v2");

-- 
2.43.0

