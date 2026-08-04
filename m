Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D0463B6A
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852193; cv=none; b=SWAFHs3oPDqfJoRUQ3l+R9ffwyz5YjZagJ8dO1jp2HKExVSZAJ7OUMWrDgZ2AUYu7jOEX3CbI+Wp5c14/c1x2I5DnKNRoLXX4qiO4x8v1QnOJfNSgdqV9rF1aYDTwZwZFJhZFWk7qBSEA887K4cu9yGHEoRZgcZA0TWVk5yKKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852193; c=relaxed/simple;
	bh=c/jldCHsn1gXilDxTKLh+mbg50n1kYkXdD+wvLJiUUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kp0hOuJrTTtFV7UFMOZCd060frYpeRQuNkZqdAuoNQdFgtjUlBIDs33f14vxczXfoj+nijvcx+5j9d03+EJqSFkU3jc5J6JPCU8d/WZkesVOLG/o05iZSVI++bUsPXgDV0c/L9f16JthP6S+7Ez9tEtuMFu6ttzA5Ybqhr7mxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RASRon6f; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RASRon6f"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-471eeac43bfso4412603f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852189; x=1786456989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0ui5oK9AY/l/1r8JIeMGahp/pYXTVjMsBc64nxxCXo=;
        b=RASRon6f1fCzWbdnMOc5Nklmsislq6JnMeAiE/ZMlH9c4l2SycXJKiA5IE2dERILL3
         VcY1A5PX6Dob7ZC4hqoY3fBUoF7e3JVzIeHKikT3bkZe1Rya51ShqWRZIXQYghR3zlGd
         dmc8+2RRHpZqsbpO5mcNfllSVqF+qXOlANCkdTJVwG32wVT8/1WeK81TP1brlw87Q8gM
         tgtIvssGSh+0sicPfGDL8EiPpr28q4O/IQXgDE2NQUlEJwljQrz9mJao2UWI89gqLJQ8
         4K+xvQi+YrYBcOkwEkGs33Y6GjoIGmHkb5APO0Tgip3IbF3oLP1LJuQMPyD+0mDFobqa
         tasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852189; x=1786456989;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p0ui5oK9AY/l/1r8JIeMGahp/pYXTVjMsBc64nxxCXo=;
        b=IXIQ5X+rYD1Hdvd6l9sq7SVupO00yYiqvmfflc+/+z+1qb8jLLmE96HWPWWKUhB+jZ
         0egTHLcDQcBD8iMrvtpjzxLOpDBRjQiS+4D0/W3ZZTe3b2tWxXESco1meigN5g73z7du
         /S1+H/AKPADyixLMYWLaaRuSFk7OIovcj0ybes1p563O9sw1GH5tLeEWg655ajUX2QoD
         8VEJwwRINuxj7uTNd2pFU3WGw+778Iw+m7vJ3c7YLFxzdjyLxKh0X8eE7sE1Jiuk67eS
         jYdtijZGq3G7gNG7pYKTwk1X73vXV8DJwBBkR1bkWOiBN4zqPvhbTwmZdVXDlnieSpzU
         wqfA==
X-Forwarded-Encrypted: i=1; AHgh+RoHrX3oKCc2gcDuaXZdloKILbTv6yKc8OYSOa1ynR12W3fha3sKdYcHw1vKnIHKlaLfn4zUHTh7zi1w6Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQkuDS2JIKFyaTLa9A1KnsLzGByJKFBS5+nF9MKxbRGoRZCPV
	KBPBVLTgd5n9QW5DtsLt7JQpC0SjqSH4777rs12Y1xrN3FjovEmz2be9S2MSTYUpGfAf+w==
X-Gm-Gg: AR+sD13r83mkmE2HEkvvjLEWqnyRXF0wHD1dr5r3wHnFEMcnl6KOUzFYIN8q9C/YlSp
	I+iovBvUN+UJwYGKjIlTNwCR2uxMSFid3u/nWEZyF5xOGf4QUx4j19FgCwN5zlZQwLu7WozdAmz
	DlywKcY/mJ9PWx2+HGFYrjCugSJKPlbys9IcHGar5KRrtV8DbDfY1VdlF8g6y2o4RDWeGCM/FYB
	9mrzsUNskRP6qaItZOobBz52rLKx4wypgEYUV/UKtEf3JtdqhYxkcukKUcgqkG0uvaAxvCUsXJD
	adPu1rfNnsvUSd9jMkUKgL3Kz7xoFPUKxdxBk2EUETXnBU+i8R+rM5jxhJN70Eui7vGQu88iSgP
	FyierAlJagrbGb2uPZ9SrGmUx0FGW6wEBzkZuVR57T6AifCrTN3vkjBUoKwb8K4mzE6337+QqpE
	YQeTFUdcUIg1mDUq8rt0fa+UvUde+eEvkYdK+oqH4Wj9gQ5baBgOzIXbwl91c=
X-Received: by 2002:a05:6000:1372:b0:47f:93b4:2def with SMTP id ffacd0b85a97d-47fd72e062dmr27002961f8f.28.1785852189032;
        Tue, 04 Aug 2026 07:03:09 -0700 (PDT)
Received: from metepc ([46.197.185.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2abbsm44236877f8f.9.2026.08.04.07.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:03:07 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzbot+d84934b4184d7f9a1aed@syzkaller.appspotmail.com,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH] tty: fix lock order inversion in tty_buffer_flush()
Date: Tue,  4 Aug 2026 17:02:51 +0300
Message-ID: <20260804140251.8197-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

tty_buffer_flush() calls ld->ops->flush_buffer() while holding
buf->lock. For the N_TTY line discipline, flush_buffer() is
n_tty_flush_buffer(), which acquires termios_rwsem.

However, the documented stable lock order (see tty.h) is:
  termios_rwsem -> buf->lock

Calling flush_buffer() under buf->lock inverts this order and creates
a circular locking dependency detected by lockdep:

  &buf->lock -> console_lock -> &port->mutex -> &tty->termios_rwsem
                                                -> &buf->lock

Fix this by moving the flush_buffer() call outside buf->lock.
The buffer data has already been discarded at this point, so the
ordering change is safe.

Reported-by: syzbot+d84934b4184d7f9a1aed@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d84934b4184d7f9a1aed
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 drivers/tty/tty_buffer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 96be90db5..bb7b7fbcb 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -244,11 +244,15 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 	buf->head->read = buf->head->commit;
 	buf->head->lookahead = buf->head->read;
 
-	if (ld && ld->ops->flush_buffer)
-		ld->ops->flush_buffer(tty);
-
 	atomic_dec(&buf->priority);
 	mutex_unlock(&buf->lock);
+	/*
+	 * Call flush_buffer() outside buf->lock: n_tty_flush_buffer()
+	 * acquires termios_rwsem, but the required lock order is
+	 * termios_rwsem -> buf->lock, not the other way around.
+	 */
+	if (ld && ld->ops->flush_buffer)
+		ld->ops->flush_buffer(tty);
 }
 
 /**
-- 
2.55.0

