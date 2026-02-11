Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567935EDCD
	for <linux-serial@vger.kernel.org>; Wed, 11 Feb 2026 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844126; cv=none; b=t98i85A4Q5K45ECGfpMVql7MBUgTudRE95qi4UBAOOQ957IfduwuaTViaTwFWIXU6hLOihLn3pBlZCleHvYognpuNNw0WFovTc20W3O0E67B56DJUw7PAGEApowxrI1MUZRcum3UtFcc2Y8qLRl9t7N9+MC8NA46U+xKFdl+W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844126; c=relaxed/simple;
	bh=z4jTTEESpNFZ2fEd3XolkTZlAnL3AOQzhNkcZSkP2VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyI37mOBIwObKkWUOyk8JWuEAlr2Bke4JMNvHIB+hmQZtOkFS8IjDDC2SDc+AiWr1f1EWXrRHj93mESzTyxXQ6uxpoSJTTqiPzHNkmZDAITNXwTBwVvIpQYDCh6F3fH78ZHBjcrJgo9Qm5UEtNS+oOKmaifOuaXxtEXZdOAMPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK2QMlxy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK2QMlxy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso13499665e9.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Feb 2026 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770844123; x=1771448923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQk37ORPfKRulJt2gHEQspYYcrEwHGWlISpZL4lD8CQ=;
        b=AK2QMlxywnrt65+L7xQLqf6CPLgDnsbIgqXYiOlDdJeN6HIRsiCbEC9WWChiG8IctA
         fVLZBi2IVOysCVhCubUEfl2r5lPdkBtDDzEkxvpNS25J8VtMwi9MmQWr2CTUG9BCGSa8
         tXJFjnrIvhXBjuE1ZxmJxxxZZ5a4FqCvm9x34i5jX4YiAaKAZz06FWPe8YyotDhZgUnV
         kY7uAa2VzJtuujPU00jZXhgbQt4Y6nVDo3PVGOdixbOMq3xy7RG+yKjVBPnFSGr6lrVC
         II2lhOL0Vk/sr9PsjdQhzJCzMW1jsO+aus34Ca7cIfxgv1PLDqnhnsXXEZTrAngiMhFj
         rHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770844124; x=1771448924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQk37ORPfKRulJt2gHEQspYYcrEwHGWlISpZL4lD8CQ=;
        b=sf6VtcQynO92HL4l6ozrRfzfxFGoBQEmH0v0E3dgzaqpLIMaOLFlNcTl6kCpi8mgsu
         gyJ37Y0BILdoWG1SPUiVNcWA548mnamYLgDJ8O7pRQ5dIF/jCLMpjRY/ZhApcOCZf4c+
         KYpps07Rbdlz9keWFCq3ijp0HCfSRnSiNpza6CX/9+jv0ApXz5VfL+4Igy6oa6drkDVa
         n8+YdEOsK8piKAKYWzgrCsl0DLMXfTXWRd/mCwfXh/FPD2GTcq255WH3uuk8xj9p1kNX
         2zcWZypgx520ZeTi0bXQfHtpUPp9sWslISDjRBqev524sVJQQWYaOahMXaYs/PvrU9H/
         3WSg==
X-Forwarded-Encrypted: i=1; AJvYcCW5VtEwUPRdGoKYq+12SCKhDQ/ftuDnQ9VnY4SC8ckI4va0nUwg+ka/iJZcBD+9Jpp6Q9TnAlhIAwcl2BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaMOrY82/TsVxf1O24j2PQ8r3tPU1FAGqrQMrBEj02UXHwgh1
	85PcRoXeD/Gm/KnkRH9AMswLMvLsKGfKVE4s0R3XmllZ0C3iqKxCK8w3
X-Gm-Gg: AZuq6aJ9gFmGgna9HUY3KbCX6TjVyXXnjJVg0R7YG0xM3n4mLsFGg//MdCxvSq2E/wS
	js9hjo3lLBRqC+o+7KUhPn+Eh+y9P8GFN/o46+NWUERRFHQsXIsJGBTaH1dqp5q9D1hKq4VWpeL
	z1VhldGr1c/U/VvlRseuqCHsViPE715fkJIc4TvjsMMcoLJ8tpjfcKPqNJ0BjzJLqUnoYFNcM5X
	OsCNQo9WKON+GqqufmVGj+nbPVJZMdjeIHwj45oYnlfa/hKfYimfh6Q+FmZcPKBP4T/jipdHIyc
	D2vSUqg3IkCCzKhCc4Vfs48bADmrK6TjpKdDUG2KFUmfUZPdcLHrNpm1KvusESj+rVFyoPb6sRC
	cMaMWFq37JNyE8SGaiF0dO5zRf+BvU+8llYPo5+k/m6PDY0MBPO2fTQPHfYVektMwsPc1MYg0g7
	OBfzcKYcjc3M+MJ2vqidUWorDe6aLPcQSx44sqnZTO/5LrnFrsI6Xwii8=
X-Received: by 2002:a05:600c:6c4b:b0:47e:e452:ec12 with SMTP id 5b1f17b1804b1-483660302c9mr2249625e9.15.1770844123399;
        Wed, 11 Feb 2026 13:08:43 -0800 (PST)
Received: from osama.. ([41.36.52.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7e50casm141590125e9.8.2026.02.11.13.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 13:08:43 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	syzbot+80806cf7508e92c7cc86@syzkaller.appspotmail.com
Subject: [PATCH] tty: n_tty: fix KCSAN data-race in n_tty_flush_buffer / n_tty_lookahead_flow_ctrl
Date: Wed, 11 Feb 2026 22:08:38 +0100
Message-ID: <20260211210838.45127-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

n_tty_lookahead_flow_ctrl() accesses ldata->lookahead_count without
holding termios_rwsem, while reset_buffer_flags() in n_tty_flush_buffer()
resets it with exclusive termios_rwsem held. This causes a data race
reported by KCSAN when a PTY is closed while flush_to_ldisc is still
processing lookahead data.

Fix by taking termios_rwsem (read) in n_tty_lookahead_flow_ctrl(),
consistent with __receive_buf() which also modifies lookahead_count
under the read lock.

Reported-by: syzbot+80806cf7508e92c7cc86@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=80806cf7508e92c7cc86
Fixes: 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/tty/n_tty.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40d0a..725d6ed2b863 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1480,6 +1480,8 @@ static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const u8 *cp,
 	struct n_tty_data *ldata = tty->disc_data;
 	u8 flag = TTY_NORMAL;
 
+	guard(rwsem_read)(&tty->termios_rwsem);
+
 	ldata->lookahead_count += count;
 
 	if (!I_IXON(tty))
-- 
2.43.0

