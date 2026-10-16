Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C6380FF7
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134410; cv=none; b=KqpaM+DhYVhqSTm8c4V3W3c+x5vGKq5t1c1Mfposi5oNnEsjE6K37bG7s+UmyYYT7cHDcAx9OW6+uJ3ZOqF1xoh0Tqe75m5DA+UJWtuw5W+RE9r7zJdXoHRpgz8T4GGolUMyrf6sSqTGVxp9IdKcfD4ZNKqLif9OxkqLREddJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134410; c=relaxed/simple;
	bh=USn6w+07pq189JJfQZSEywdO98S2dAszzeqvb9TXxqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOR4oZcs4FP+r2rV/qqw7W/zI4cRl7y4D4GxlacJ02PTC6bBJI2nSkiPnm45SfCQFET/j7yoo9HvDS629FBfodSlwuRRKsHCUkDnY/yN3jJ58irZobT+lfgZjXY4c4N3jOW7mxsciyDRUS/4IQV1Vr0vHI3OsqwYbZfu3BV9kYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km+ZU3If; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km+ZU3If"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so6435160eec.1
        for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 00:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792134408; x=1792739208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFiWoYztjzXHZLP55NqN/1kpppjMYdgZZKZWx6u33J0=;
        b=km+ZU3IfUpD4aGLtwUfJgHJkXvXQotBXzQVplB1FmpJpNUBjgNCwJphkPMWpoelFFo
         bJBsrXkIGFS8r7blZvmf/cxOCv3831xXw4pLStv1eGD0J9qkJnhgfMixj82eMVLvD4QN
         689g+hZfhzU1qrcBEGzgj0EoULMdFUgL7y4posnF4owhwn0hSC1MssSAo8GNf8X6TzEc
         apSF6CjhJSwJAyOz3Q1jZTXKHGtJLw3IsP5iGsprDk9CQdlwV3brQDdm535e7zJBlM+y
         8Z6dxzdqb5UoCJMuu4xgM/VcRtMDQJFwdHABU+8SlzDAX0nJt2kuJYNldok04fsdXmAF
         Hx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792134408; x=1792739208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oFiWoYztjzXHZLP55NqN/1kpppjMYdgZZKZWx6u33J0=;
        b=RTQj777opG96ZNeY06eC/WlhtRgbkbKwwy/8OXvaDZq8o4ktjLHpZcXBiSQPCh9gql
         Gt/6cnG10QHKXhuV1D2Pq22K+E6UGhuAez4dkIaU/AGmvMvsg06T11s8FE2h6nHQArH+
         d3bsgkpYUOtWgO7qPpb9itwCr6B+Y5+Q82WkTVwxxi0XpOVgiH7J2eeHoNi3y6QO9d6T
         9I8ZZGhTi4p0hF3LJLaajDeWGIpjuspt5Uf4etM2ogQH6p4hGsXO1wQ3bXg+OOm1DHuH
         4ufqMAmGe51ye0PdJV5clp4QKq9SQNacBiXrtwyPRHAf8R2fxsuG5z35T07HBf86mRdR
         6fXQ==
X-Forwarded-Encrypted: i=1; AKwUvByttXFhvJmSQb9AxLDX8GUbCx9B7ft+7Y6EpAnwEyqwXG21ldNKXyeteLe2ZjSOJBnQE5IBhTcEeu2aCl0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSSCeDuY3Gf6aQIPTQhRnjKZAVY0sebOZ5N/UF3Iv67qSomP7J
	MBCFC5YDJB2tPdoOn7xZBByGc9m38BlCBUMJFqkui3FHbDciRzzu3MH2Ny8edQ==
X-Gm-Gg: AYBFou0Qn5EdTlKrpCCH5/GQeqaEpGac2Z0QNLPYWyxVqqmBNRKEqXahC+S7t6ORHU+
	q7puQP388yrAPyBzAFBjSW6Da5aptroN7EHCTfBmC9rUEt6oST4avIgtz+PiJZjvuSlWigibkQ0
	+m1DlIGzKDkNxXhEBqhNb1Jw/7ZLJwuzonlhdDOoa5G3Nvh6eb+1wtpFRPRNr02kRTRv5cEWJWp
	FuY67j/5Mqe9rte+PpXR8dv4JAUuCKF3jG42cQsA8Nvb1hXCp5N87+DwZPmJuhK+1Kcx9GqXP+9
	LL1gYb2pxCbMmMh6u4EDJGMdmqtV4ikChPQ5w7ZHCM88xgQYXoV/03fhtbteJUTPoFDK9sljEYQ
	LiJ55caiNSikcH1tatmq4uWqMDWe2xNDu9j9zcYcIA0SycgKHDXMb1WiMClfid5qxayahSjGHhs
	tUh+wIxi2ptVay+EbR5P7horZJ698Fj9qyrbpf4ezmgKzYhmFA8qJslgsF2l9rNGUC6y40R0hBi
	+xE29j+ano=
X-Received: by 2002:a05:693c:88c9:20b0:34c:79d4:ba0d with SMTP id 5a478bee46e88-3537dffd5b2mr31110310eec.14.1792134407688;
        Fri, 16 Oct 2026 00:06:47 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm5005237eec.3.2026.10.16.00.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:06:47 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	stable@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2] tty: sysrq: reset the per-device key state when reparsing reset_seq
Date: Fri, 16 Oct 2026 15:06:36 +0800
Message-ID: <20261016070636.2559899-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysrq_parse_reset_sequence() clears reset_seq_cnt, but reset_keybit is
only ever __set_bit() and reset_seq_len only ever incremented, and
nothing else clears either.  struct sysrq_state is allocated once per
input device in sysrq_connect() and lives until the device goes away, so
both accumulate every time the sequence is reparsed, which happens
whenever the reset_seq module parameter is written:

  # echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq
  # echo 59,60     > /sys/module/sysrq/parameters/reset_seq

After the second write reset_keybit holds all five keys and reset_seq_len
is 5, so the combination that resets the machine is the union of the old
and the new one.  Holding just 59+60 counts 2 of 5 and does nothing.
Releasing one of the stale keys decrements reset_seq_cnt below zero.

Clear both along with reset_seq_cnt.

Doing only that would drop a cancellation the stale bits were providing
by accident: with sysrq_downtime_ms set, holding a full sequence arms
keyreset_timer, and the timer is only deleted on a press outside the
sequence or a release inside it.  With the old keys gone from
reset_keybit their release matches neither, and the armed reset survives
into orderly_reboot().  Delete the timer as well, since it belongs to the
sequence being replaced.

The boot paths are unaffected: the command line and
sysrq_of_get_keyreset_config() leave sysrq_reset_seq_version at 1, so a
freshly kzalloc'd state parses once with both fields already zero.

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v1: https://lore.kernel.org/all/20261016032732.2328852-1-zhanxusheng@xiaomi.com/

v1 -> v2:
 - Retitle from "Input:" to "tty: sysrq:" and add Cc: stable, per Greg KH.
 - Delete keyreset_timer when the sequence is redefined.  Clearing
   reset_keybit removes a cancellation the stale bits were providing by
   accident, so without this an armed reset would survive the release of
   the old keys.  Reported by the Sashiko bot.
 - Fix the description of the breakage.  reset_seq_cnt does reach
   reset_seq_len once every accumulated key is held, so the reset
   combination becomes the union of the old and the new sequence rather
   than stopping working.
 drivers/tty/sysrq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c2e4b31b699aa..013ad3a500703 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -689,6 +689,15 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	int i;
 	unsigned short key;
 
+	/*
+	 * An armed reset belongs to the sequence being replaced: once the
+	 * old keys are gone from reset_keybit their release no longer
+	 * cancels it.
+	 */
+	timer_delete(&state->keyreset_timer);
+
+	bitmap_zero(state->reset_keybit, KEY_CNT);
+	state->reset_seq_len = 0;
 	state->reset_seq_cnt = 0;
 
 	for (i = 0; i < sysrq_reset_seq_len; i++) {

base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
-- 
2.43.0

