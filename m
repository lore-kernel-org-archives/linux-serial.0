Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3532DCF45
	for <linux-serial@vger.kernel.org>; Mon,  4 May 2026 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879416; cv=none; b=H5H4i3M4Bw0TQZi6ysiRX40Noe5GKDmsieNaBa+oN/EzLxiuYoUIf01pxPHfMVfkUfyLSgyxdYeCGy74jdF/xU5tsAXVVOdwfWUJTC4R3e6FOj1da7RveiPPKqAX+z8bPQ0AGl4ml3syCkpSQ6Y6+snAl3NxIof0BCfjyrvu6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879416; c=relaxed/simple;
	bh=iDsKqcjhFpYKiMIlBQgKx3UNN7P/g7t9XkZG+KJB3Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EEY1pJBAWbuLWGfJppnNeMiyEda59XhDnNuy0iqY48aygTICunwuqphKt+La6WSJrXlSH9hXBkMuFG4aV1IdNrTyx//t75cduJ8iZiHa3sZY8nWmk0VFFkPwBse2EO7c4vGJRyu6OvcUiHI04/HTcm+nWl6TTyHDojzlJbCbUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5Ws/ccW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5Ws/ccW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f8bf96b46so1630160b3a.2
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777879415; x=1778484215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G79Fe6Z0WDcIL2gu8p8A7rVpAP0Dfe//QWOMktYjbs4=;
        b=a5Ws/ccWZfWzZ4i0+5/iN8mLPfHoiuFapcDDUfDPvq7ecYmiZ+ruzYks4IHJ0rCRvc
         NpsSjps4TFIUXoHwhtQqw67zvKsgMFAe4hdUiURHqTDg+8haA2Ru3JwpFbzjBBXz3fqQ
         3ed1SIz8IBgwRgeTog9H5k+xqCBgUqtyKhlZP9vGmLRv7pN3L7n50rFWoq4Z/pAAUMuO
         bfiEx7qpMe5uL6/39J466SniKV6jEFEo5WH3AvO8V1lXFGDOHaJWBCy8YUG/k/D3ITdD
         6s3zPzjqJ2nKDxSo+LiwpxDViRH3tzyJiVlTuiXtdqt5iCx4JhxpyLXErldCuaf/ECok
         pd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777879415; x=1778484215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G79Fe6Z0WDcIL2gu8p8A7rVpAP0Dfe//QWOMktYjbs4=;
        b=ECXsmTObZo5ndFfsXaX28Xn3kA8aFKvBOzcI58R5keRt7aC7gpoe4KFI/RpuDfv4hY
         7b6BzcyG48Tek1QyrcKndkZWQAOVnymx9bv3c93Kh6OvL2mnz+S2r8xOwiM78SM+0baW
         lkXM6z8dsQj5NEePvRcm8iHR8HdTcfMuyWEV8KTFTCYSpr0Z+8lhR75dwFS+NZgSt258
         UuygTsbN9CKYUbfje+x+lNA5LwYJ7RPYqev24oiGigyWDEdE9WzpWsuqfywummL3kKlo
         7PLJN+JCI0Ch1yxkjan6+IR5kX/AThPVqzq5A/3fKEXF1AnLrvExfukq0k06BwkeuEq6
         qXig==
X-Forwarded-Encrypted: i=1; AFNElJ+WniN7MItuTICpWbhtCAVHJimxv19KuVQUK8xEhejrNr96k3B+oauPB0X+CaTI4GzoY9ieuGq5kDq8RTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwWW1S/XhC/vLQMaBhYtYRYHUbX6U8MeMZxrw7mTEcs9YEp6G
	26fjEzbixMoWOq+swwImizrZNHZCk4ACjv9ntMybk1hu3jl2lY5IYgoP
X-Gm-Gg: AeBDievelgv1inqDSYeiNCirsPNyYpJWGyTWAGUaGr2UgHPxXJpk9ahoVljlr8b+0la
	qwfk0RJ4Ze8MeQKLcdTJNJOndw9E13hOe4ipVUYSRvesV+XrT1ALSw+eiPJSNLIYhVwnoa6PNWa
	DYIWl+xyChWR2HwI9y7AGvRpVZHtB5gxYBorGORRwrMPTps+n8MdI03m0Cu0Q7pF3tg57YxtE6V
	v07nAlqP7AdniCUFkM1xPFfyoRcsg3/CCj7c02outKZEaURQxXFitfBGuH7G5UfWJgm85W/fXDP
	hD9p6yTrarYhLYEV32fZh6YUm/6KxIz6nWJq5cwWxzBxJLz8RpI6VeaXLRW+eup6Bd9v/OxmC8s
	iDBIuWkrlub5SD4oTDp52Gfyfj+CoyvVqG5L6TT/6f8n77o73bLonSlXeCrHCdz9WXrWQ0XigyM
	VaQAJdiIYsFWfMmihs97cprJRuadpxsMtpNbXrQCc=
X-Received: by 2002:a05:6a00:b45:b0:82c:249e:a85b with SMTP id d2e1a72fcca58-8352d15654cmr7671003b3a.13.1777879414459;
        Mon, 04 May 2026 00:23:34 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515afca48sm9553982b3a.40.2026.05.04.00.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 00:23:34 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: peter@hurleysoftware.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] tty: n_tty: order lockless input availability checks
Date: Mon,  4 May 2026 15:23:21 +0800
Message-Id: <20260504072321.928921-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The N_TTY read buffer uses release/acquire ordering for its
lockless ring indices. Input producers release-publish canon_head and
commit_head after updating the buffer and delimiter flags, and readers
acquire those heads before copying data. Readers also release-publish
read_tail before producers use it to calculate room.

chars_in_buffer() and input_available_p() sample the same indices
for availability and flow-control decisions, but use plain loads. That
can miss the ordering used by the data-copy paths and can also let
poll() observe termios-synthesized availability with weaker ordering
than normal receive-side publication.

Use acquire loads for the lockless head/tail samples in those
helpers. When n_tty_set_termios() updates canonical/noncanonical
availability, publish the updated heads with release stores as well.
Keep the cached icanon bit as an intentionally lockless mode snapshot
and annotate that access.

Fixes: 70aca71f92ca ("n_tty: Fix unordered accesses to lockless read buffer")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/tty/n_tty.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40d0a..56b0cd96a453 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -213,9 +213,17 @@ static void n_tty_kick_worker(const struct tty_struct *tty)
 static ssize_t chars_in_buffer(const struct tty_struct *tty)
 {
 	const struct n_tty_data *ldata = tty->disc_data;
-	size_t head = ldata->icanon ? ldata->canon_head : ldata->commit_head;
+	bool icanon = data_race((int)ldata->icanon); /* lockless snapshot */
+	size_t head;
+	size_t tail;
 
-	return head - ldata->read_tail;
+	if (icanon)
+		head = smp_load_acquire(&ldata->canon_head); /* producer publish */
+	else
+		head = smp_load_acquire(&ldata->commit_head); /* producer publish */
+	tail = smp_load_acquire(&ldata->read_tail); /* consumer publish */
+
+	return head - tail;
 }
 
 /**
@@ -1779,14 +1787,14 @@ static void n_tty_set_termios(struct tty_struct *tty, const struct ktermios *old
 		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 		ldata->line_start = ldata->read_tail;
 		if (!L_ICANON(tty) || !read_cnt(ldata)) {
-			ldata->canon_head = ldata->read_tail;
+			smp_store_release(&ldata->canon_head, ldata->read_tail); /* publish */
 			ldata->push = 0;
 		} else {
 			set_bit(MASK(ldata->read_head - 1), ldata->read_flags);
-			ldata->canon_head = ldata->read_head;
+			smp_store_release(&ldata->canon_head, ldata->read_head); /* publish */
 			ldata->push = 1;
 		}
-		ldata->commit_head = ldata->read_head;
+		smp_store_release(&ldata->commit_head, ldata->read_head); /* publish */
 		ldata->erasing = 0;
 		ldata->lnext = 0;
 	}
@@ -1908,11 +1916,17 @@ static inline int input_available_p(const struct tty_struct *tty, int poll)
 {
 	const struct n_tty_data *ldata = tty->disc_data;
 	int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
+	bool icanon = data_race((int)ldata->icanon); /* lockless snapshot */
+	size_t tail = smp_load_acquire(&ldata->read_tail); /* consumer publish */
+	size_t head;
 
-	if (ldata->icanon && !L_EXTPROC(tty))
-		return ldata->canon_head != ldata->read_tail;
-	else
-		return ldata->commit_head - ldata->read_tail >= amt;
+	if (icanon && !L_EXTPROC(tty)) {
+		head = smp_load_acquire(&ldata->canon_head); /* producer publish */
+		return head != tail;
+	}
+
+	head = smp_load_acquire(&ldata->commit_head); /* producer publish */
+	return head - tail >= amt;
 }
 
 /**
-- 
2.43.0

