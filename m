Received: from mail-yx2-f10.google.com (mail-yx2-f10.google.com [74.125.224.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA873939D7
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338016; cv=none; b=pNeQSRC7snFqdpUz181UqBYv4MUamwXEOxxxUJ5sg7oBIhANxesV/+TWhS5Zx+Ocz3VJtQniMiwv677E+uz34gVSjo2jlIme/L2S3/Kg2qRGwNOfVm+CFHNRxpBexFb02AMU2Q2f/P2gdefQUX2Br3z+HrLmWJDQ2/6zAaGB9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338016; c=relaxed/simple;
	bh=e2TezCu4LqiwOcdr5Xl00ISXZkkloH+FEiSkQFIjp6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+V7hUxy3mVrb6Img1uvyJM7frtXO1CoDeOsRz64RGbtTPEypLeUF8jO4odqsHj6AzkKljnGix+ecsMzS2oREZqRi2y3ZJo916cmfjbYbjQsZxS2u6os7/Iuvdy6n1go5y+yW+pAHjzD8aN/gwhQpHF4kS8cBmuwcEx6cM8XGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=DhLmWKgn; arc=none smtp.client-ip=74.125.224.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="DhLmWKgn"
Received: by mail-yx2-f10.google.com with SMTP id 956f58d0204a3-66e579ea059so58619d50.1
        for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789338012; x=1789942812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jFsTrG3iHQyKHdq+1UodoaAkVXy7pVAAxAeiumEkAso=;
        b=DhLmWKgnMgKu4X0dE7YNzZom/2fDHYVqnmTL07C4ZYTYw+Cjl5MHzwNVOd/RshulgX
         xtMLnm5ELsbvexPumejfoCHeDKqrbaqh9Ch9jMQObu1vYzTDBHEOj4aoEe6GYlrOm3Ut
         CA/EI7Oq8h09mHAdCHxXJZWsxtvwQ47xd2V1UC3TZ5ce6T1F9L41pJKdXfMyxuy1JdMx
         NLDErNDzHpFnU355H3LzZJZwIie89s4Sq7fvh8MZEhGy+Upis9gRkqYbwkKnerrZNlCz
         wTKfnycas4yu0wYLYHPaaB1K5bKdOVOiDJz4nvfJaBTl0dh/8iThMXpn1AZFs7fnNcKe
         GIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338012; x=1789942812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jFsTrG3iHQyKHdq+1UodoaAkVXy7pVAAxAeiumEkAso=;
        b=YOSi6nM2uAAvt6WbujlcqPS3GdWUuvfCpU7RweUbdcdKdwzBLltcQ0Pgo2irHDhQm4
         jIJhSjT04CFRUbo5k2t06Tc/hNeMak78hXCsp9myF74H+7UaTrVSJ08sF/eO5zroCuQ4
         7pWaDfwBLCVk5LY5VZlzpofjMMbnLlRMdQBZhe9DIcl6FnCO/iEhuXWkXfbZYDL96BjH
         jKKlFfZMlP+3QZ1TWlBaOLvMh4z739PRlZHs7A+acxpyo8+4lorRhdCZoMT1ZXn7lodb
         aHpeGPfgKLOyY9536tPa9uKSwQtdHma+fmfLJ99CuqnGAmcGDCFc870LIl3suLCIBBf8
         6x2g==
X-Forwarded-Encrypted: i=1; AKwUvBw2enYRucwqXfLRw8xyrbyiUNg3oVShbX3P8Y25LjFeermuuDsapS3shxkx/2BsKB2KzbmOJemd9eJfMnU=@vger.kernel.org
X-Gm-Message-State: AFuF++lvoQVW4Sdzl5jRnuBUDimsaYj1FKqEvxc7mYqQ1sr2nncR0Cxl
	NprVUK3xK4sAmdvpn89dfS7iLLyXXOeT65IKfZTIwPoC4BTWMQHLIcXtPdIW9Tpze7oK
X-Gm-Gg: AYBFou1kVwFMy/NH996iLvuW963YZnDxzEj2eVA5Renft/bf2/I08yLLhFo6wV1OmqE
	8J4mLsbRW3vo8GUcClY0YN8YkvU9VumZQQLPuPWUwkXqLCD884o/9bPTDIi46U/I72I9HWjkD3o
	WlLLBgFyDVy4YKNMLnSDV4eIMDTJCJaO2Q9F8wug2fUCBpHVCaHZiyEV6XBz1SFL7RN+z8XWdbf
	SewwmE1Jw8zgigqJcxoq800Y8jUmHX9OwNp1HHjIMjHLGEUjsz484ZqBgNsFKEznAy1+eGE+Ce9
	XaRjDz9RyLWrZO0d+ffkDnm147Cg/htsRPbWnHYtlikg4zexh8f4RuKyipenJR/6pDtyhgQxCYV
	fAinjeFseeDR6h8K7aXHrTuhozXu6QXElklRJ+oUBWC+cJMjkbRSM81Ko5TN2W/ZVUu5Lht6i0R
	Y1QBr3SK8MP6lLGuciKknI3XBDW4IzGVjnn3rpasDRESHIN0gQOS2PU/T+zx3Qte5UF59KwjR2k
	9WkW96wf8A+HlmpGYIp2KvCdLhz9zvm5QLJ/dY=
X-Received: by 2002:a53:c9c1:0:b0:671:2f8d:eaf3 with SMTP id 956f58d0204a3-6712f8decebmr2752598d50.4.1789338012505;
        Sun, 13 Sep 2026 15:20:12 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125ea8a35sm3737883d50.19.2026.09.13.15.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:20:12 -0700 (PDT)
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
Subject: [RFC PATCH 1/2] tty: mediate TIOCSIG through task_kill LSM hooks
Date: Sun, 13 Sep 2026 18:19:57 -0400
Message-ID: <20260913221958.839429-2-clusk@northecho.dev>
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

TIOCSIG lets a PTY master holder send SIGINT, SIGQUIT, or SIGTSTP to
the slave's foreground process group.  pty_signal() currently uses
kill_pgrp(..., priv=1), which represents the signal as SEND_SIG_PRIV.
check_kill_permission() consequently returns before security_task_kill().

This leaves the operation outside every task_kill LSM policy.  In
particular, a task restricted with LANDLOCK_SCOPE_SIGNAL can use a
retained PTY master to signal an out-of-domain foreground process group.

Add a kill_pgrp_lsm() variant selected only by pty_signal().  It invokes
security_task_kill() for each process-group member immediately before
delivery while tasklist_lock remains held.  This preserves the existing
per-recipient and partial-success semantics without a separate pre-check
race.  Ordinary privileged process-group signals continue to use the
unchanged kill_pgrp() path.

This is an RFC because the policy boundary is not settled.  Landlock's
IOCTL documentation warns that pre-existing TTY file descriptors remain
dangerous, while LANDLOCK_SCOPE_SIGNAL separately promises to restrict
signals to processes outside the domain hierarchy.  The proposed helper
also makes SELinux, Smack, AppArmor, and other task_kill LSMs mediate
TIOCSIG for the first time.  Maintainer guidance is requested on whether
this should instead use a dedicated, opt-in TTY signal hook.

Tested on x86-64 QEMU with a held-constant four-cell effect oracle.
Across three boots per image, the unpatched kernel
delivered 96/96 cross-domain scoped TIOCSIG attempts; the patched kernel
denied 96/96.  Both images delivered 96/96 unconfined and 96/96
same-domain TIOCSIG controls, and denied 96/96 scoped direct-kill
anchors.  There were no indeterminate cases or kernel diagnostics.

Fixes: 54a6e6bbf3be ("landlock: Add signal scoping")
Link: https://lore.kernel.org/r/56bffc24f3d0d08b45a686a48e99766b0a0821fa.1780614610.git.hexlabsecurity@proton.me
Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---
 drivers/tty/pty.c            |  8 ++++++--
 include/linux/sched/signal.h |  1 +
 kernel/signal.c              | 30 ++++++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index cc7f7091ed9a..8f5eea156ce4 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -187,6 +187,7 @@ static int pty_get_pktmode(struct tty_struct *tty, int __user *arg)
 /* Send a signal to the slave */
 static int pty_signal(struct tty_struct *tty, int sig)
 {
+	int ret = 0;
 	struct pid *pgrp;
 
 	if (sig != SIGINT && sig != SIGQUIT && sig != SIGTSTP)
@@ -195,10 +196,13 @@ static int pty_signal(struct tty_struct *tty, int sig)
 	if (tty->link) {
 		pgrp = tty_get_pgrp(tty->link);
 		if (pgrp)
-			kill_pgrp(pgrp, sig, 1);
+			ret = kill_pgrp_lsm(pgrp, sig, 1);
 		put_pid(pgrp);
 	}
-	return 0;
+	/* Preserve the historical success result for an empty process group. */
+	if (ret == -ESRCH)
+		return 0;
+	return ret;
 }
 
 static void pty_flush_buffer(struct tty_struct *tty)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..7d6aee7256a3 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -337,6 +337,7 @@ extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid);
 extern int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr, struct pid *,
 				const struct cred *);
 extern int kill_pgrp(struct pid *pid, int sig, int priv);
+int kill_pgrp_lsm(struct pid *pid, int sig, int priv);
 extern int kill_pid(struct pid *pid, int sig, int priv);
 extern __must_check bool do_notify_parent(struct task_struct *, int);
 extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
diff --git a/kernel/signal.c b/kernel/signal.c
index a5e15bf09d31..758393b7257d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1426,13 +1426,22 @@ int group_send_sig_info(int sig, struct kernel_siginfo *info,
  * control characters do (^C, ^Z etc)
  * - the caller must hold at least a readlock on tasklist_lock
  */
-int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
+static int __kill_pgrp_info_filtered(int sig, struct kernel_siginfo *info,
+				     struct pid *pgrp, bool check_lsm)
 {
 	struct task_struct *p = NULL;
 	int ret = -ESRCH;
 
 	do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
-		int err = group_send_sig_info(sig, info, p, PIDTYPE_PGID);
+		int err = 0;
+
+		if (check_lsm) {
+			rcu_read_lock();
+			err = security_task_kill(p, info, sig, NULL);
+			rcu_read_unlock();
+		}
+		if (!err)
+			err = group_send_sig_info(sig, info, p, PIDTYPE_PGID);
 		/*
 		 * If group_send_sig_info() succeeds at least once ret
 		 * becomes 0 and after that the code below has no effect.
@@ -1446,6 +1455,11 @@ int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
 	return ret;
 }
 
+int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
+{
+	return __kill_pgrp_info_filtered(sig, info, pgrp, false);
+}
+
 static int kill_pid_info_type(int sig, struct kernel_siginfo *info,
 				struct pid *pid, enum pid_type type)
 {
@@ -1886,6 +1900,18 @@ int kill_pgrp(struct pid *pid, int sig, int priv)
 }
 EXPORT_SYMBOL(kill_pgrp);
 
+int kill_pgrp_lsm(struct pid *pid, int sig, int priv)
+{
+	int ret;
+
+	read_lock(&tasklist_lock);
+	ret = __kill_pgrp_info_filtered(sig, __si_special(priv), pid, true);
+	read_unlock(&tasklist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kill_pgrp_lsm);
+
 int kill_pid(struct pid *pid, int sig, int priv)
 {
 	return kill_pid_info(sig, __si_special(priv), pid);
-- 
2.55.0

