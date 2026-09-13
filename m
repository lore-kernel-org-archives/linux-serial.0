Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD665395AD8
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338017; cv=none; b=Po0vvmSD0F/9v6XsxW44oS1GakyJosxSYHG6mQUVPTtQTBi9jdG8LXyqcxgVMb+KKc6yaVGcDU2LSRSe8RkcFWmfg8YwxfSppOSCGUu1jo+LrEgduuCYgRBgIZUll4VKvfeVemQGN8AKLlI+eYPtcWBR2jjfOfFN157GGlBgSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338017; c=relaxed/simple;
	bh=5pkHB3i164W8icF3HNIo5S3m7IXJeAl7ZFd29G+8BJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiO+mtg4YYSNzeVswul8cxdCN5RIdQuRXJ7gkMkCJW9nqNbRyGJ1/p2c+zQX+HMFThv8f8VEUz+8Im2YEZSJ3UiN36OtHPUzmszRfvMdN8fjz8xiwH+a5OHwu4jRltntN3MyXPhuRjt5O+xfloIBtL8bbt0HoUubbzfHUN+UQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=aucMGjy7; arc=none smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="aucMGjy7"
Received: by mail-yx2-f3.google.com with SMTP id 956f58d0204a3-671180edc60so51464d50.0
        for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789338014; x=1789942814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S1OwKuJbWNl7O6FSAPDDrjoi72RznfkxqUaE7FgbPyI=;
        b=aucMGjy74s6Z5XM2h/EnIm2F7ep/Pf04YdmPrh0i1AssTwZLuRehEIXzitKchSUWDb
         DDTNEa3GxalwWT0yDj3W6Xl5zva6wNoqj0/W1F5fjip+HosSD8hnqdgthxByURwWeklO
         U2Cidk6cROC6GWL8p+0sqyo/hC3Wt+4gTZvXoO/l20ipODBMadz7xYp4wwgyV7F8gBNU
         EiKFCLP6PBLagkowlIKlVgW8NwY+UxbsWu5x7HKjIVimpajXl+LK8vCSaSGH3oGDp7+K
         YnQ8IrQhflhbcT4JiVl0gC80pYaV8/rUTEr/p2fLyPEG3swtG8ZlTcptXN2z0FbwX2jX
         gDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338014; x=1789942814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S1OwKuJbWNl7O6FSAPDDrjoi72RznfkxqUaE7FgbPyI=;
        b=DtmPSP2PGHKF2Ol3Z231WDXaXJhg1S0aJpPGFzMCTWP5NZkFqgd2UJYl2a7FZ8JxTI
         c0GPse0uE2PolfmiOZK/2JRfdtXO+OVHfaNbt36XNmxSFSvViP4Ew4eM4vTJn7ykq0x0
         9jF0jRMajmBZyF9YrfKQua2Q3psi7fgWOxYMw+L3xcxCIk+7wRj1v26623WbhvFwK5kW
         lOweTUQsY5C7e56CGs/Nwe81tTA+N5LeAtJ9+lWjvAbEBoxTg5RnsCt5AM8w80V0qqGc
         /jSqR8RtkiSZ8VaKqzZihKA0o5iYcatnHUIQ+UljhKf8rpYchFQo1JzCnXpGkTKYsnZi
         rAXg==
X-Forwarded-Encrypted: i=1; AKwUvBzQ+SYYLW/ILsfsi1g9ye3m72/dl8mbIjfRUnCicybjVijtQDOQXt9X6RcgOTzDkZdCVtiAor3op90/S08=@vger.kernel.org
X-Gm-Message-State: AFuF++kueKehj5olrl1DQspanJwGHKqQRSwCb6SHlBCxX4ExmIDIZiNO
	n75yUto6cEI7LrIeQspGtWPgSZYarATJ8ho0KuhtVX7z37E/xZm1uJc8+dkhReCZr4X6
X-Gm-Gg: AYBFou2CTxPgJJ3MaWjk1CeznRgGmw765kgpQAt70o+pXlTbEGzElNOvmBus3Kd7+vH
	QrbEwbIcln73Taeuh9yB9V/EFmEjiVZr6MkOHC9JMaK2XxpE918NMXyuSOOyEURfAPbnv1Z/2BS
	moUyrXOyPdV4EQevB/wGH/8KEs7bxKPdaMqXF8FNTw2zWwf/NKT8A1Hzj7V3uopEG13+yci0vB8
	hrWQ79e2732xRQoguCWpYtf5kUQ8k/RTdk7IQcIxWM5bgeMf3fcEzk8rOgFC3C6R94xt8G/djLz
	Bsn6DxxO+dTtihzKMKxDZaWw2MS6Gx4uycORJwwm9T5OCXuqeLGvlcj5cyWZCc28EVCxTi1q2dq
	vnPvpqj9Nn8WmdYVykPgqdBQBvjy3sKw3PUGPgNyhkUpg1NxecZppmmL7K+63a75JjADmLIvifn
	szcnNxRW8d1dnw8N0ILOB4SLsCA+IBD6Cn/7gLTs6XPOdJkx0xY+3fiVlF62VShoGX1B4exDfgX
	tGLIfVODH5Tp5mFhxQ/KJpnRfYWRGrzzTfP6FsyvifmbmlhBQ==
X-Received: by 2002:a05:690c:b13:b0:820:100e:1abb with SMTP id 00721157ae682-88d235a8491mr430957b3.4.1789338013628;
        Sun, 13 Sep 2026 15:20:13 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125ea8a35sm3737883d50.19.2026.09.13.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:20:13 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 2/2] selftests/landlock: cover TIOCSIG signal scoping
Date: Sun, 13 Sep 2026 18:19:58 -0400
Message-ID: <20260913221958.839429-3-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913221958.839429-1-clusk@northecho.dev>
References: <20260913221958.839429-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a focused regression test for a sandboxed PTY master holder using
TIOCSIG to signal an out-of-domain slave foreground process group.

The test observes both the ioctl result and the target's signal-handler
effect.  It fails on the unpatched base because TIOCSIG succeeds and
SIGTSTP is delivered.  It passes with the preceding RFC prototype because
the ioctl fails with EPERM and the target observes no signal.

The identical test binary and initramfs were booted against both kernels
under QEMU.  TAP reported one failing test on the affected image and one
passing test on the patched image.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---
 .../selftests/landlock/scoped_signal_test.c   | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 259cdcc8aa5c..9e1dbcfa07c2 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -12,6 +12,8 @@
 #include <pthread.h>
 #include <sched.h>
 #include <signal.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/types.h>
@@ -681,6 +683,146 @@ TEST(sigio_to_pgid_members)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+struct tiocsig_result {
+	int ret;
+	int error;
+};
+
+static void handle_tiocsig(int sig)
+{
+	if (sig == SIGTSTP)
+		signal_received = 1;
+}
+
+static int setup_tiocsig_handler(void)
+{
+	struct sigaction action = {
+		.sa_handler = handle_tiocsig,
+		.sa_flags = SA_RESTART,
+	};
+
+	if (sigemptyset(&action.sa_mask))
+		return -1;
+	return sigaction(SIGTSTP, &action, NULL);
+}
+
+static int create_pty_master(char *const slave_path,
+			     const size_t slave_path_size)
+{
+	int master_fd, pty_number, unlock = 0;
+
+	master_fd = open("/dev/ptmx", O_RDWR | O_NOCTTY | O_CLOEXEC);
+	if (master_fd < 0)
+		return -1;
+	if (ioctl(master_fd, TIOCSPTLCK, &unlock) < 0 ||
+	    ioctl(master_fd, TIOCGPTN, &pty_number) < 0) {
+		const int saved_errno = errno;
+
+		close(master_fd);
+		errno = saved_errno;
+		return -1;
+	}
+	if (snprintf(slave_path, slave_path_size, "/dev/pts/%d", pty_number) >=
+	    (int)slave_path_size) {
+		close(master_fd);
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	return master_fd;
+}
+
+/*
+ * Checks that TIOCSIG cannot bypass LANDLOCK_SCOPE_SIGNAL when a sandboxed
+ * holder of a PTY master targets an out-of-domain foreground process group.
+ */
+TEST(tiocsig_to_foreground_pgrp)
+{
+	struct tiocsig_result result = {};
+	char slave_path[64], byte;
+	int ready[2], release[2], effect[2], report[2];
+	int master_fd, status, target_effect = -1;
+	pid_t attacker, target;
+
+	drop_caps(_metadata);
+	master_fd = create_pty_master(slave_path, sizeof(slave_path));
+	if (master_fd < 0 && errno == ENOENT)
+		SKIP(return, "Unix98 PTY not available");
+	ASSERT_LE(0, master_fd);
+	ASSERT_EQ(0, pipe2(ready, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(release, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(effect, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(report, O_CLOEXEC));
+
+	target = fork();
+	ASSERT_LE(0, target);
+	if (target == 0) {
+		int slave_fd;
+
+		EXPECT_EQ(0, close(master_fd));
+		EXPECT_EQ(0, close(ready[0]));
+		EXPECT_EQ(0, close(release[1]));
+		EXPECT_EQ(0, close(effect[0]));
+		EXPECT_EQ(0, close(report[0]));
+		EXPECT_EQ(0, close(report[1]));
+		ASSERT_LE(0, setsid());
+		slave_fd = open(slave_path, O_RDWR | O_CLOEXEC);
+		ASSERT_LE(0, slave_fd);
+		ASSERT_NE(SIG_ERR, signal(SIGTTOU, SIG_IGN));
+		ASSERT_EQ(0, setup_tiocsig_handler());
+		signal_received = 0;
+		ASSERT_EQ(0, tcsetpgrp(slave_fd, getpgrp()));
+		ASSERT_EQ(1, write(ready[1], ".", 1));
+		ASSERT_EQ(1, read(release[0], &byte, 1));
+		target_effect = signal_received;
+		ASSERT_EQ((ssize_t)sizeof(target_effect),
+			  write(effect[1], &target_effect,
+				sizeof(target_effect)));
+		EXPECT_EQ(0, close(slave_fd));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(ready[1]));
+	EXPECT_EQ(0, close(release[0]));
+	EXPECT_EQ(0, close(effect[1]));
+	ASSERT_EQ(1, read(ready[0], &byte, 1));
+
+	attacker = fork();
+	ASSERT_LE(0, attacker);
+	if (attacker == 0) {
+		EXPECT_EQ(0, close(ready[0]));
+		EXPECT_EQ(0, close(release[1]));
+		EXPECT_EQ(0, close(effect[0]));
+		EXPECT_EQ(0, close(report[0]));
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+		errno = 0;
+		result.ret = ioctl(master_fd, TIOCSIG, SIGTSTP);
+		result.error = errno;
+		ASSERT_EQ((ssize_t)sizeof(result),
+			  write(report[1], &result, sizeof(result)));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(report[1]));
+	ASSERT_EQ((ssize_t)sizeof(result),
+		  read(report[0], &result, sizeof(result)));
+	ASSERT_EQ(attacker, waitpid(attacker, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* Release the target only after the signal has either fired or failed. */
+	ASSERT_EQ(1, write(release[1], ".", 1));
+	ASSERT_EQ((ssize_t)sizeof(target_effect),
+		  read(effect[0], &target_effect, sizeof(target_effect)));
+	ASSERT_EQ(target, waitpid(target, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	EXPECT_EQ(-1, result.ret);
+	EXPECT_EQ(EPERM, result.error);
+	EXPECT_EQ(0, target_effect);
+	EXPECT_EQ(0, close(master_fd));
+}
+
 static void *thread_setown_scoped(void *arg)
 {
 	const int fd = *(int *)arg;
-- 
2.55.0

