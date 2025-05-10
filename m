Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97878C91;
	Sat, 10 May 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746895118; cv=none; b=cPqMuAAFcWl+mvVhwdjQB2w1UtqezNt1QRu24m7jNuE5c8x9G+Y/cLOIk3AtxL91raRArk8u+AfW8+7AA+sYHmd1+GiZnyZ8tZxCZzN5Ur8EpzcY+DVBKDxVRkZuntYAqmqsZEZTYRW7jDU0O17DM9fH3IICJ2E7ph4YXjXu8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746895118; c=relaxed/simple;
	bh=+oD11Hhq1SifV8wWUxQGl8z4mlOsK5Dajs0XHf6rsDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYNt06mOM+dsMLEJlQh+WdJdIZq9+y2ZzGXwqL4w8+kOyFkZlCXWfP8F834ojhcBf+nnt61YJehoHQyA8H2IsSyIm8wBbnIvbXL4G5aGlkTx6B1AMWYsYFppqdfV7rMVyI36ofdHfqvAHGOuYvthDEst/9s7rDxRjIG55gm9iZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oor14e/2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oor14e/2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3826656b3a.2;
        Sat, 10 May 2025 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746895116; x=1747499916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYY3xvs/hoQR/RMoyxL6CTuYbkJnioycFjEXIOY4vtU=;
        b=Oor14e/2uianlPaE+/TzgH4tRk15biQ8wuEQEXyrHI5kyiC2esCMa609MPDUI4CEgo
         6wUNrMUoqh45EykTx8Bgf97LLkA4x8IP0SUdp5R3xH0RJYHiNiwNOQByl0qNzl3npCMf
         z9LiKBATdSNLrBcO09rFhMJVN4iPfftD2IIz27ytAgxMrhWlGzwWY6FlPcSASgJLAxn1
         T0LczP+0kd3wOwAJ2Ay0s0Yufj7NnLexdKzeFBKbWsMPqhE54PkLQ2qUNmm0T9yHa+a1
         Di9fRvRbwMbv2N+E6R3KYrNaUBPgdH1KHJhoDWW5UVha/a1hK607FXu9UWViAT/cAcNW
         /Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746895116; x=1747499916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYY3xvs/hoQR/RMoyxL6CTuYbkJnioycFjEXIOY4vtU=;
        b=lPbzIk/rvbskvZBMdRrOK5S8dYIlzwVxJ8LmIHySSSUqfSBC3699qW6nhVhCBTWPS6
         arjmUlE16BE4ddHwk9j2IDrIBqx+hYD0uwLshnEvrqaud3ucvTmF8nkfbBd36vYQMsYR
         Q0SUykAtkvCU+hQ+b1DdFb/9htODVispYGdDYI7omo9R2CmCJaWXV8HDolBsCX0mw2x/
         xbQNlPdj+4x4Pr7aU+EHyKSiJI6tq2CYmIy0ifYZAecLpCwLQ4Q0pVBHvySAI0uu7VvZ
         nFCqtIFj0phL0hTh8GGLmgHgz22ZQD02XQ0/N0GjH6eTQSGTtkqkj2T/Wbj2nls96nyF
         GVyA==
X-Forwarded-Encrypted: i=1; AJvYcCWVgnwvv041m9rPF/ZEDuvQc5kemwYXEqBP6Q51lOdWyv7SJp4I2cURci07zJ3MTuvfjHYlexgZ2ADfgMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxnWfC5/+C4WaDR24wT45+df1iwa6dGhsmSA4Z/YgqDwXhgk3t
	tIpF4EWoHxyoyHsuBgEkjFIALQ41u0n1j4WXJ5hYsIvOhUBcsUMrvGLQ8UDmRg0=
X-Gm-Gg: ASbGncso4CwIEMxg4i26JLN4MENqSP0DHQnfPV+Py10KxJ9tgIU6J+vuJQ4UJOM4/Lc
	uqqOkPqPvgCE2GsXfrKgUSOmNCy8QBaJiIk565RJx0iXgImpPufPrpA8D+Rd29gEASUXO/QDRKf
	XfoXN4fsgfdELzdgBnqES3AC8WEsEu94wSyR1GhB0uzN0p/ffLg+ANNqUKHQbxA7BCBoZ1KdUHk
	G+li76+uu6BmANTF0cdmdOx+l1vrSWdZ2DX1FwpR5tW+Hl4mlvYvrCGWDj7pX1y/HfyeU+x3Ros
	uhB7bUO2X2Peku7RjD+x6n1ftjBRZBjgdonccZ/NX+Gr71zaFFugI3Fo+0Cu7Pz/cOqor2oHCbY
	zJGl7lexPqxWUlNY=
X-Google-Smtp-Source: AGHT+IEalHcH+lEKumbEO69hX83MgcEzoVZj4otUwM2OLLsC3N5xsIFsWYOrkodSPcpFydmL3IHRDQ==
X-Received: by 2002:a05:6a00:855:b0:740:8153:68f with SMTP id d2e1a72fcca58-7423c00bf24mr10184167b3a.20.1746895115945;
        Sat, 10 May 2025 09:38:35 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237727a02sm3520937b3a.56.2025.05.10.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 09:38:35 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] n_tty: fix data race in n_tty_poll()
Date: Sun, 11 May 2025 01:38:27 +0900
Message-ID: <20250510163828.21963-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found data-race in my fuzzer:

==================================================================
BUG: KCSAN: data-race in n_tty_poll / tty_set_termios

read to 0xffff8880116b4d14 of 4 bytes by task 5443 on cpu 0:
 n_tty_poll+0xa4/0x4c0 drivers/tty/n_tty.c:2452
 tty_poll+0x8f/0x100 drivers/tty/tty_io.c:2208
 vfs_poll include/linux/poll.h:82 [inline]
 select_poll_one fs/select.c:480 [inline]
 do_select+0x95f/0x1030 fs/select.c:536
 core_sys_select+0x284/0x6d0 fs/select.c:677
....

write to 0xffff8880116b4d08 of 44 bytes by task 14547 on cpu 1:
 tty_set_termios+0xf9/0x500 drivers/tty/tty_ioctl.c:339
 set_termios.part.0+0x3bc/0x4d0 drivers/tty/tty_ioctl.c:520
 set_termios drivers/tty/tty_ioctl.c:454 [inline]
 tty_mode_ioctl+0x2db/0xa00 drivers/tty/tty_ioctl.c:807
 n_tty_ioctl_helper+0x4e/0x230 drivers/tty/tty_ioctl.c:986
 n_tty_ioctl+0x67/0x230 drivers/tty/n_tty.c:2509
....
==================================================================

In n_tty_poll() we are doing a read on tty->termios but we are missing
rwsem lock, which causes a concurrency problem. To fix this, we need to
add rwsem lock at the appropriate location.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/tty/n_tty.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 6af3f3a0b531..36b41374e1bd 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2449,6 +2449,8 @@ static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
 
 	poll_wait(file, &tty->read_wait, wait);
 	poll_wait(file, &tty->write_wait, wait);
+
+	down_read(&tty->termios_rwsem);
 	if (input_available_p(tty, 1))
 		mask |= EPOLLIN | EPOLLRDNORM;
 	else {
@@ -2456,6 +2458,8 @@ static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
 		if (input_available_p(tty, 1))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
+	up_read(&tty->termios_rwsem);
+
 	if (tty->ctrl.packet && tty->link->ctrl.pktstatus)
 		mask |= EPOLLPRI | EPOLLIN | EPOLLRDNORM;
 	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
--
