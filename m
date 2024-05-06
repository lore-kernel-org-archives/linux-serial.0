Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E95158D97
	for <linux-serial@vger.kernel.org>; Mon,  6 May 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021722; cv=none; b=KDfXeaUeqSYHIgfMXTwH7JH+vbY10FBETwo4/D4JaVSwcRgb4wdbka8pZ73RU7hU6Jh8OHY1lQ67/Q9F1tb8Z3wy22sb3EGi/+omjH6Zhzu5qoeVA/kaTkAeVOStrr36NnF1qctt5JLir+QuqmAuVxYbrlJs0KjHqBi9DWdpVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021722; c=relaxed/simple;
	bh=eQ59GvPtmD0StGAqEgoE1xzghWc3vAliYszQLIkM+hw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DJuKBSzD2/dKnKWhF7PmcV+8mN++IdWdv5i6BZxsNIoUvm8Q6YVTUe7DcqpfmrZAslbjGBfU0wYWZeS+CNhBxgADslMs+dA9oOPf7gQJpLc6kIBy5RfXtQ4Qd3HQYR5TwZsRZmHydTenuxmi872Zwm+wp4TX7P21/rBqFeccTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDJxIxys; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDJxIxys"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-6f043baf8a8so1925798a34.0
        for <linux-serial@vger.kernel.org>; Mon, 06 May 2024 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715021720; x=1715626520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFb+/j2lVI6dVZBxEog24QJX60eA/cRB1E70DgXCvn4=;
        b=pDJxIxys8674EriR8t3UyYDgV5jqZlLwJaBZQsmQjp7lqwHPi7xeeQz7j5/jwu8Edk
         plyNvcXN93XfADxGLiPFCS8JuBrWMM7IYi71UvIt0W0aA5qTZyUo3ToVQCKNG+a9yUkT
         g9Bx58UOXNThpIkuqwkhmoym29CTDdjE0Q481sSpn5cRbFLs21dw15pSNBo+FlzhA2c+
         lGdiPp/q3KzXA6WGRjqxjyXC3IUbIr6BaojIj62Yk3b4DSse+PLLTUJWbAwJNqLvHwmt
         D5AUVsgzZtlvgZBaZsV9LOWL+KDrIvv96GcKsKyn+Shn2sqt6SNrufbaVfNh3mY5mHtv
         Qm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021720; x=1715626520;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFb+/j2lVI6dVZBxEog24QJX60eA/cRB1E70DgXCvn4=;
        b=U4BATUt8ZZryfNae64aN6RCA621rF+r6hzEbvAiKSrtjEG7mC6DLEkuTNssWKh8fHX
         Fy9M1pkhVF2XNU3482GtMwrFy1GRaKdCx0bqCPtJNNl5sIN/oYbBZYl2UNfQYhozmPzc
         RKnqp2LSHht7+ULl4y1DxytTj2ZjMbiKM4TrnIeSgi13C9CBtKUJrnhjUA+CjuZ6/poD
         Fr0ZG0xvF/tyBPnLfQnk+tushRiR25Ygf1l1bMhmTtYG+OMVSqZSN19bJBz5vr75E04b
         e9us4L+IBUX6j9U11kf6GkKOEnSSSrArGmSQX95k+uhHbiFSTV2lA2coY8nyeSkVDjc4
         ZmDw==
X-Forwarded-Encrypted: i=1; AJvYcCXLpK614hjR8JXMeiixTTJ61ATQGIkUpIAe3vMEOw72Sc5EfxER4UbFTjvKTpV8T1ZDtF0l3C2+C560ohpf4yL/Eil7kAomghYuHfN7
X-Gm-Message-State: AOJu0YyJOfewkSQrv19710eWXh7g4gscl14oQkfSkAyNCSoeST1ImHX8
	ub9qQCu1Td7lOG/78xs28qlNAwWHr9/MxpOCkOYS1LZGIOGJ0A5VKpHRTmNsGhb0NxvuFzzDn1X
	ILdCR34G1Zbljjqx3HqC+9g==
X-Google-Smtp-Source: AGHT+IFbnnHzpLP5ns+PA8kTWNDTcUvh/TQFs9fuiwaTLC20p8G5kV8pSk6Qj3cnP8mjE1lr7O70D3JP2zRte4Co1g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:808c:b0:222:1414:d29 with
 SMTP id q12-20020a056870808c00b0022214140d29mr38884oab.8.1715021720357; Mon,
 06 May 2024 11:55:20 -0700 (PDT)
Date: Mon, 06 May 2024 18:55:19 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJYnOWYC/x2MQQqAMAwEvyI5G6hFBf2KeIhtqsGi0ooI4t8NH
 meZnQcyJ+EMffFA4kuy7JtCVRbgFtpmRvHKYI2tTWNanGpUB7NLe4wTuRU9x5PQh9AR6cC2BX0 fiYPcf3kY3/cDhjl3DWkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715021719; l=3808;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=eQ59GvPtmD0StGAqEgoE1xzghWc3vAliYszQLIkM+hw=; b=XVVKygfhbc/BJCZeqQmuwfYK+srJRDUiBofzc7JKHYMaXrvrFCIV5PoAd9QhGRY/XOgmGRvF0
 xo/Ugu0sK3RAGr0ImfBUXBRnnyuGe13P17PZRP3P68ZL01qO4fSVZEy
X-Mailer: b4 0.12.3
Message-ID: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com>
Subject: [PATCH] tty: vt: saturate scrollback_delta to avoid overflow
From: Justin Stitt <justinstitt@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Using the signed overflow sanitizer with syzkaller produces this UBSAN
report:

[   31.304043] ------------[ cut here ]------------
[   31.304048] UBSAN: signed-integer-overflow in ../drivers/tty/vt/vt.c:309:19
[   31.304055] -2147483648 + -1073741824 cannot be represented in type 'int'
[   31.304066] CPU: 1 PID: 3894 Comm: syz-executor Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
[   31.304073] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   31.304077] Call Trace:
[   31.304080]  <TASK>
[   31.304083]  dump_stack_lvl+0x93/0xd0
[   31.304177]  handle_overflow+0x171/0x1b0
[   31.304186]  scrollfront+0xcb/0xd0
[   31.304196]  tioclinux+0x3cc/0x450
[   31.304205]  tty_ioctl+0x7fc/0xc00
[   31.304212]  ? __pfx_tty_ioctl+0x10/0x10
[   31.304219]  __se_sys_ioctl+0xe0/0x140
[   31.304228]  do_syscall_64+0xd7/0x1b0
[   31.304236]  ? arch_exit_to_user_mode_prepare+0x11/0x60
[   31.304244]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[   31.304254] RIP: 0033:0x7fc3902ae539
[   31.304263] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 8
[   31.304282] RSP: 002b:00007ffc8a457998 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   31.304289] RAX: ffffffffffffffda RBX: 00007fc3903e2f80 RCX: 00007fc3902ae539
[   31.304293] RDX: 0000000020000040 RSI: 000000000000541c RDI: 0000000000000003
[   31.304297] RBP: 00007fc39030d496 R08: 0000000000000000 R09: 0000000000000000
[   31.304300] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   31.304304] R13: 0000000000000800 R14: 00007fc3903e2f80 R15: 00007fc3903e2f80
[   31.304310]  </TASK>
[   31.304371] ---[ end trace ]---

This is caused by the scrollback_delta overflowing. Historically, the
signed integer overflow sanitizer did not work in the kernel due to its
interaction with `-fwrapv` but this has since been changed [1] in the
newest version of Clang; It being re-enabled in the kernel with Commit
557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow sanitizer").

Note that it would be difficult to reproduce this bug in a non-fuzzing
scenario as it requires inputting tons of scroll inputs via keyboard
before the scheduled console callback has had a chance to update.
Nonetheless, let's saturate scrollback_delta so it stays clamped to
integer bounds without wrapping around.

[1]: https://github.com/llvm/llvm-project/pull/82432

Closes: https://github.com/KSPP/linux/issues/351
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: I am using Kees' SIO tree as a base:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=dev/v6.8-rc2/signed-overflow-sanitizer
---
 drivers/tty/vt/vt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9b5b98dfc8b4..b4768336868e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -308,7 +308,14 @@ static inline void scrolldelta(int lines)
 	/* FIXME */
 	/* scrolldelta needs some kind of consistency lock, but the BKL was
 	   and still is not protecting versus the scheduled back end */
-	scrollback_delta += lines;
+
+	/* saturate scrollback_delta so that it never wraps around */
+	if (lines > 0 && unlikely(INT_MAX - lines < scrollback_delta))
+		scrollback_delta = INT_MAX;
+	else if (lines < 0 && unlikely(INT_MIN - lines > scrollback_delta))
+		scrollback_delta = INT_MIN;
+	else
+		scrollback_delta += lines;
 	schedule_console_callback();
 }
 

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240506-b4-sio-scrollback-delta-dff9aabace26

Best regards,
--
Justin Stitt <justinstitt@google.com>

