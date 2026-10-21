Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548070;
	b=470jca9EtR/5BQZi78blIu2jYUR5QB7IjT+sWe0Zf5hh061lFpuR90+L3B10Wv8p2Q5w
	 MN8lbjNC2zOqCdl4Z3Ncy16OzgCWTguiHcbHYC3YlPWHuyHgFtRCqSYkw/wBQHAmbyAIW
	 xHaMLTrS9haokDCK69g2nmTKeXuVyqMn9fUUtdVFfnuGADamVywIxWufrAZ+OnwHMessX
	 tHAWAaP9/SErIme5FAbot4+aCI0FLCbCMjhqwqyFcZ6kdK1TG+Fb7Hq+Z3+wevmmunGTy
	 WofMcUB85Tg4lIMDgxLwlq6uD7J72JvAd5bISR0K3B/8dXU/FsuussTbQ1DmachGP3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Iu0fYDBNq0qM6ieGxF7SKF04cC/pqSqWPF7xJOKvPpg=;
	b=Is+J1FHw2EHxkiHBsMUlWWJykWSHDB6PnCk3USvzSnFYrBATQR6n54tK/28F2T0DhF+n
	 y6irXMcNIBxuZRr6BRE3OKcHyswcFQ4Wy6pSxpB/l7c9KmfY9lw9im8KadOOj3y1d1Fl+
	 a0/iehABdE9UHzNYNsKOzMUwRn28jMad+B2LbTC3HXCVUZnxomiTDlz0p4at1WOePS5va
	 snZLtIKdchUC2iPsHNkAGw1gg5IAgrmUxfSvIK0M8tP76DACBpgeoE3hFsLIgjzirH9Bt
	 wVJBO8+/jhl2BJU5q5Ioijk4aIdwT4nbuABH/D2qKnY0tudyoq6LDeiwz0o1o2YB8vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="H/qc23LJ";
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E8606A31C
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 02:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF9E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H/qc23LJ
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f48c750afcso150470a34.0
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 19:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792548068; x=1793152868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iu0fYDBNq0qM6ieGxF7SKF04cC/pqSqWPF7xJOKvPpg=;
        b=H/qc23LJt1zaJUKjsYtuGYdJ0pe02S4mnxUAMJRBt87ufBzk59e56YDAHdz+vpyVGJ
         MVjkLTkvdFioYj5XfSVFo3WdQx+G9s1sqkDYvTRhmCXBd7E15B/tLnEG4GZZdVFOhX1z
         g0euFhYYKRjdo/dkgI8tNC9CQ/3U2RG12L7qbxU65its+crA6ffH+whZMbIiwjL/dSkU
         U+GVOAPwA81SXxvtLbkn4uS9SSiqQKMAyoRRjDO+d8+O97oVPf9EheNXjD4/08CRLYcF
         Zebnxl97GuCNOC65qWa4IkYSRxI3SQSp3Ek2KpBb3HUI2xWZyhhzTZvp/oDLC0kXNjz6
         1btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548068; x=1793152868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iu0fYDBNq0qM6ieGxF7SKF04cC/pqSqWPF7xJOKvPpg=;
        b=26emH6NwXqbQ3bpLfGLkAqw52W/gPxOVqLGk4L22PS+gRPLRA3CT/rOjupyg6BlEG3
         Ixhi+k8hyaD1O1tYoEPSTcRiex7iLG2ERTQ2S4Y5/vxHfCW5MK4hnYTPwq1WpIl80ktG
         wMcIgeUxK9aV0DsIM1h/d2AbiKroeIQOoiG2dYuA3Al/LNH7pVq07J2s5H2xGw/lGokP
         4ou7m2/b4nrooxIZfOo0b/eXrZzrx2eDxk1+dWXmObpxdWurzkxBRsI+qGTrsUQ0F2Nv
         B6jgG6t1d/rHsUcAfZUdHreLk/pUgZRZzX/bdCwvXb0qgWH3bN5i8oGps6B0wCj6PKVw
         rq+g==
X-Forwarded-Encrypted: i=1; AKwUvBwwGLAWiJScM/IlIBrVurd2nPhZ1cm9RyrxYRG6+EMqZAl1RCVJbvS18R5FVhonhg/lZFdHfUE1kzJsvVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzFO3IwwAdhVCPXzG/e8wtuz3a30pK8MgXmRkb4JN6K6myXt/5
	NA1+f5J3qqq1p+cpOTkYbX6OHhbnbnnCmFkxNFLXyVyAm3SI3HC//olT
X-Gm-Gg: AYBFou3Sxbz4sSu3yqQIoIP3WFOBCNA9OG/Wb13K9dIyRrYi6TgL34ev+N6L//ucwwV
	EWr3/aV6nRzJWm47Fdby/aOtdlvYoTDv7V9lauUZmo31C80hRCS5GI5AR0YFAi/7badibfDUMvw
	BZiwBjwfvNGYKH2W+QiaUS0MOOHN2gQfGDUutYmWpKtyQZ0tre1/gQnG2zXhxsdgUP2xILmqGtV
	hB9f3IoSGQuoP7zY4B6QVd5FIyApHBsi/9P4HPSofdrjS9WWR4y1ujxaJgO9xooSEldJcFBIPhX
	uzplxUF8AJ4iwnX2nIMnIfYm2OUnuGRNo4Nv2WGqUMxiplY7kVi+rWlJmI/v/784bDXUN2TRzOW
	NaRp+kUQ0LxPoWqPLjq8WN5/RFnoiM8i3KR4jzJOjdL7K4/nW9pa2PwJuDXLU9PTShDzC4i9QPS
	IevdJ+n1HT8TzXQXv/Y53ZzUO9iGHhhR4LMbgwaIEU8HYAkV7y/rEIode36MpM70yrihCFprupm
	ZNvvyeAdP1yYd1kYF654pield8bd7NSIz4+eufcDXiLIBKoh+GZa34IxTDkUympSWdUhB11Z297
	LSIernhgpGJ22sZ48iXLTIU=
X-Received: by 2002:a05:6830:680c:b0:81c:5aac:798a with SMTP id 46e09a7af769-84d087fe940mr357225a34.13.1792548068561;
        Tue, 20 Oct 2026 19:01:08 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cba7d431esm1071785a34.2.2026.10.20.19.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:01:07 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Abhinav Saxena <xandfury@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH] selftests/tty: tiocsti: expect the privileged parent to succeed
Date: Tue, 20 Oct 2026 21:01:06 -0500
Message-ID: <20261021020106.94174-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FD passing tests open a pty in a child process, which may drop its
privileges first, and pass the FD to the parent, which always has
CAP_SYS_ADMIN. The child's own TIOCSTI is checked against
.expected_success, and so is the parent's TIOCSTI on the passed FD.

TIOCSTI checks the capabilities of the caller, not those of the process
that opened the tty, so the parent always succeeds. Where the child has
dropped its privileges and is expected to fail, the parent's check fails
instead:

  # tty_tiocsti_test.c:620:test:Expected result (0) == variant->expected_success (-5)
  # tty_tiocsti_test.c:622:test:FD passing: expected error -5, got 0
  ...
  # FAILED: 13 / 16 tests passed.

fdpass_pty_restricted_nocap, fdpass_nopty_permissive_nocap and
fdpass_nopty_restricted_nocap have failed like this since the test was
added in v6.19. The FD passing tests are skipped without CAP_SYS_ADMIN,
so these three fail whenever they run.

Checking the opener's credentials instead was proposed together with
the first version of this test, and the reviewers did not see the
current behaviour as a problem: a process with CAP_SYS_ADMIN is
responsible for what it does with the FDs it accepts.

Expect the parent's TIOCSTI to succeed, and drop the log message that
calls this a security concern.

Fixes: 7553f5173ec3 ("selftests/tty: add TIOCSTI test suite")
Link: https://lore.kernel.org/all/2025062327-shady-broadcast-237d@gregkh/
Link: https://lore.kernel.org/all/20250624.3bb75890f0b0@gnoack.org/
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested under virtme-ng as root with KASAN/lockdep kernels, next-20261020
    and next-20260930, two runs each:
    
      before: pass:13 fail:3 (the three fdpass_*_nocap variants above)
      after:  pass:16 fail:0
    
    An LLM was used to help with this patch.

 tools/testing/selftests/tty/tty_tiocsti_test.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/tty/tty_tiocsti_test.c b/tools/testing/selftests/tty/tty_tiocsti_test.c
index 5e767e6cb3ef..411fb459cbce 100644
--- a/tools/testing/selftests/tty/tty_tiocsti_test.c
+++ b/tools/testing/selftests/tty/tty_tiocsti_test.c
@@ -610,17 +610,14 @@ TEST_F(tiocsti, test)
 		/* SECURITY TEST: Try TIOCSTI with FD opened by child */
 		int result = test_tiocsti_injection(_metadata, received_fd);
 
-		/* Log security concern if demonstrated */
-		if (result == 0 && !variant->requires_cap) {
-			TH_LOG("*** SECURITY CONCERN DEMONSTRATED ***");
-			TH_LOG("Privileged parent can use TIOCSTI on FD from unprivileged child");
-			TH_LOG("This shows current process credentials are used, not opener credentials");
-		}
-
-		EXPECT_EQ(result, variant->expected_success)
+		/*
+		 * TIOCSTI checks the capabilities of the caller, not those of
+		 * the process that opened the tty, so the privileged parent
+		 * succeeds even where the child failed.
+		 */
+		EXPECT_EQ(result, 0)
 		{
-			TH_LOG("FD passing: expected error %d, got %d",
-			       variant->expected_success, result);
+			TH_LOG("FD passing: expected success, got %d", result);
 		}
 
 		/* Signal child completion */

base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
-- 
2.56.0

