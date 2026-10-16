Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627972F7EE1
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 03:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121262; cv=none; b=p1++i2xMfWcCvmuaGa9UpanM+rzP5iuu1R8ZJfN/FPU8/Wa0Ig6wQMOeAds/Pt3TSaurw9q6MCw/c2gOYTItQMt0UGKwllV5TYKQxJWGOZl0E3gB9EqlXt8piCvSNu5dRNqT+/tKXKL0/pzSAlioQkrkWwN8NMMvtgUL2uYnlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121262; c=relaxed/simple;
	bh=+7Xk2sw3Wtz36aZj8CThZvU+Fd3CpGSJQ58bpbKZg1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGyzIvjTh3wgM2G87+Z66rhc7BVMRBMe+2Cc1rVoEfkZD2H71IQDVoN0kS/DLkUAuF2C7CJgXgRbmQu4DWArKUGTNfafh+kmJkDwnppbzOmn+CfOQyKMumZLrXDaEd4x7EmKNGLEam3PwNr2xw8j8NO9vTU/aBFW0WVvNQ7EpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcFjEjvm; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcFjEjvm"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so14299317eec.0
        for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 20:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792121260; x=1792726060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2YZBaOUFYzuTeMdOIpOPEVgHo9o2UPoUqPPnpI8qbJg=;
        b=bcFjEjvmTlR3vgr7JYTLAPQy6Csds9L/ke+l8on1BeaVNh5B+znN4NS6J5TkmAsHZl
         b3fJnxXgbk7HCbUE24oeh10d6HNSTslU316C2qxvv9wVKtWzsRxGflXjFOWpjT6Ek1E3
         l18ud/2sb2XnQkK5FMdb7kukfpa3gTIbqsTOUdzRfeI5S7X0SSPaS6o7mzbEuRdmOgkp
         id1Og+UEmWzmoGEfZ9tO2Z3TdCb9eg7JaQ1rA2Kj8aTH73qB99rlkAkJNZfcCxgELGE1
         EQTivvT029+paOjYahtKzoghOZ28CXjC7RjosqoztSOPiYGNMTjoTue/Z6k9lAw9Vj2h
         gx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792121260; x=1792726060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YZBaOUFYzuTeMdOIpOPEVgHo9o2UPoUqPPnpI8qbJg=;
        b=KLv1sswJcgRqA6y8y/dKD0tKFx7rieEiYItwpVSrnPYFp9GD84Qsst9JF96ak0SUut
         za6hoOGxWEe9Z02CQEfVy5uGhKf0rOoIrX1vrDKhgaxQBC0z83iz+tHrfEfrjvEUKRh5
         8yliFxIl8LyPBttmw4MIf+kz+3bqF5d4GAlLGO7GsEORn+sCtWyzj2dVfyKmSCF3ydel
         YGKiLDccU4M8zItHCEYtEJIiDt+Tw1XFseIsy+YtnVioWZccotC4Mj0Z7gGcxRIvZPWv
         g5n5EZh7rPKq9VpEgo4rnjLZyuepq0ec9c7k1kgb0TOUVXiPSBmHoTUJzZ/B6JrpS5Mx
         8YmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxv+7dDhGXTvH0H71WGXg2L2UqAbiVXI/doGLcRY1SdnINfu3TaK7j/eZeczc+3atlWFEv6/+aswpp3+D8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBpD3i9jDQOhbzyMGMRKG75mvKvTx4+8ZS9TRWK5pfwgk+rBMq
	caT51jlX/Qf9H2KNdlHQuyjPntkqcKk9uOolg4O0XvsZVbmn3EhtqBfMC5WXdQ==
X-Gm-Gg: AYBFou26hN3yLEbgX2lVvyZSfo0NJf/apKwFN4F/j7koHiXGehYAt/gNjqdqQsC1z+T
	2TZ6Wc5qYWhK+iQkSIczbul2Lx72MQvKAxAOkCoJPgnbOWMXOmfcclDu0L3tCItSwifuU9q8WBv
	jMydtzWq15/vqdTy8Sb5sza/NbJeIZDO7SJO9jkhwYO2CLqQ0j6ULN87bUAjWbfeoO+lzHfTej/
	uIDfya0tHN8rEdoGvUKGshNiyo5n1Lq8O6sktDVsocf7QjKyM3a3Mc7GjurQdY83RSlYruplvhR
	fLs4IYpALjoAyK3ceLq90MJ5IbiXTjbkdt+INfBRGT8nwghKOkFhs00kl6Yic2sbm9YV1+2ItVF
	WOPdfnwGTbyg4V95utn8zmu7ZeawVxcX17XWsg4nRt51YOwTiRrbuVbtV+tHZoQ3gpqLlFXCIAF
	iCwHXoujFtijLwOS2fP0xZ4b7PACG5E5itSGbAFr40VeDk6MBo2/YzukXY5Om1z79AzE7D611Nf
	POCyvAkm3E=
X-Received: by 2002:a05:7300:828a:b0:34c:d1f2:b552 with SMTP id 5a478bee46e88-3537dedaa87mr26823702eec.4.1792121260463;
        Thu, 15 Oct 2026 20:27:40 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm2617092eec.20.2026.10.15.20.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:27:39 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] Input: sysrq - reset the per-device key state when reparsing reset_seq
Date: Fri, 16 Oct 2026 11:27:32 +0800
Message-ID: <20261016032732.2328852-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysrq_parse_reset_sequence() rebuilds a device's view of the reset
sequence, but only clears reset_seq_cnt.  reset_keybit is only ever
__set_bit() and reset_seq_len is only ever incremented, and nothing else
in the file clears either.  The struct sysrq_state holding them is
allocated once per input device in sysrq_connect() and lives until the
device goes away, so both accumulate across calls.

The function is called from sysrq_filter() whenever
sysrq_reset_seq_version has moved on, which happens when the reset_seq
module parameter is written.  It is mode 0644, so this is reachable at
runtime:

  # echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq
  # echo 59,60     > /sys/module/sysrq/parameters/reset_seq

After the second write reset_seq_len is 5 rather than 2, and
reset_keybit has five keys set rather than two.  The trigger in
sysrq_detect_reset_sequence() is

	if (++state->reset_seq_cnt == state->reset_seq_len &&
	    !state->reset_canceled)

and reset_seq_cnt cannot exceed the number of keys actually in the
sequence, so holding the whole new sequence no longer resets the machine.
The stale bits also make keys that were dropped from the sequence still
test positive, so pressing one takes the increment path instead of
cancelling, and releasing one decrements reset_seq_cnt, which can take it
negative.

The boot path is not affected: both the command line and
sysrq_of_get_keyreset_config() leave sysrq_reset_seq_version at its
initial 1, so a freshly kzalloc'd state parses exactly once with both
fields already zero.

Clear them along with reset_seq_cnt.

Note the error direction is towards not resetting, as reset_seq_len only
grows, so this costs an emergency reset on systems that reconfigure the
sequence rather than causing an unwanted one.

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/tty/sysrq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c2e4b31b699aa..d28a4726b07fc 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -689,6 +689,8 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	int i;
 	unsigned short key;
 
+	bitmap_zero(state->reset_keybit, KEY_CNT);
+	state->reset_seq_len = 0;
 	state->reset_seq_cnt = 0;
 
 	for (i = 0; i < sysrq_reset_seq_len; i++) {

base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
-- 
2.43.0

