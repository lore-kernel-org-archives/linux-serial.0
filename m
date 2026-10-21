Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549226;
	b=Vc5piwHhW4ogNcTY/32X4tS0VX+jPhenUS26Xys34oED6cVrgJ9VvkaDBWFb5GmGAmnC
	 X3ekeG3R5Cr6Z07VU9odK7cJj5deeCSVfOYhv7U6ayQXzK7BxAxNcUgi8XWPumqipjABQ
	 jz1TxVKG5GrsTNmlquubhhwON9m85yqYOEA49WcMXGXO1lM2REEL59E2HuT9d8t0yCkgi
	 Ya7v7L/27zB8yFcL6z2p/xgL6R7aC9IzyVgsuAa94gfAsAKvpsGbj1IPt6xHxyWz05Iav
	 xHxHCfLuVe1jHxyydFuasAxfXOGF2b+3t6laBKUKzXy/cdsj2J3VXlpgH8e2Jj/elFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yos1+3QwUjrDuAOazo5OswZ8Efjv4lBkArOWfigb8n8=;
	b=dR4o9nXgsGPCWfV6ziwz98e/FZYBqx1vXO76Kq5MRtJg0yBkFl2pnxcAti/f6oGmRdJ4
	 7alQdyvnw/HTP8w6h+9DDWrFb3r2ydJFNBRTG7DB9Sus9s/jSJeiCR+yTXyg1OfpfdYDH
	 KhUhQyVTs1D3MRQ1v6o6l4uKBeDk9TFPp4IYDnjC/zNrBVXTN8dOfaPrhD/qeab2Or5yw
	 xVAzQMGgvKuGhgBrKJfoA/nmuC9dHodCruCybh71XDOqEF2mtNJ3zlIW9vyMRESH2uzjp
	 35YZcxqywepeWy0uytKkQWfNuM6k92N5Jp+ABS9+puOY4shjVWBzGd7IpMXnl6StyOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtGhLxtH;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D0606A328
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 02:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32D0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtGhLxtH
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38759bcd877so159680a91.2
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792549225; x=1793154025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yos1+3QwUjrDuAOazo5OswZ8Efjv4lBkArOWfigb8n8=;
        b=mtGhLxtHMUFPemGwSfIV1NL33M11RBxtFzcOHulj34SabBPdQXFIALEwlXrhDDBP8u
         SmWPgpNEZvGL2uAl6a9uximQp88MOK+j7A6fgv/JTIlKjeqWOx6anRdd6W+gJmKXzjuw
         Mo8ZiDgqmL8mnRwim9BkDtjYYqHZGIfpQFdyvLzpltu7NTI9ZspJYEfDo4qHmUsV0Xz9
         YFpEAPLXHs/smb6KgefJ+d1RqZsbjE5FgqPmvQYZZy8sd7FoG9JIw5vr0mg+CQ794E5K
         1uDci0Z7HcQ1JCKajfyvtQFLA+LoqqE64VfRe3WBh38z8U88pwWvSrZoOnPoyW7vKE/o
         hmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792549225; x=1793154025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yos1+3QwUjrDuAOazo5OswZ8Efjv4lBkArOWfigb8n8=;
        b=w5YXe0OowHX0b0Kx2EqvQCgpDcaFbF7TeEaOeNQYrTxIePRS8ZE6gkrL+oqa/RertY
         vhV3t1SoEx/KuGPZ48en+HaTtA6qwXMs9i1A0qlUZnd6joD07oeYv8eQU5cvsTcXETdn
         QGO5o1FoNFQxKNavT4uKQTGLuLnoS0q6mlr7aiIoFD0ptuA56ESllN/U/CG1It8eXaiz
         DfzM3vGnrMQdgF2cFCtRqruZ0pMaHS3ny0waBFcJ7f8mlPkVqxEabkInzNZ8vTzBTXQX
         NsWdJsV9tQWvtY5ICfnVMP+qxGWXj+ipauxT4dfBbomk5hGgcfDOUwHzXI3YNJfNW8Qx
         KBHA==
X-Forwarded-Encrypted: i=1; AKwUvBzdHg1G+C8j1th0FHGlC3tJjgg5faMxh+29fLl2q48SdGxy8Hi0Avoi7lNgkNZFOqpR1p93CBs9gkmI5E0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8fg2wxonXzzDUUYRashNgQTFnjUhC0JXz7IJHXN2kQYmjSAQj
	x/ONEquUjRV70TgUT3V/lmx8RoXRuirXrugFnXjDypO7wVPveUcf7+av
X-Gm-Gg: AYBFou2ds6mBcxVpqNsjY6sBbaED+cUMdvnDYSV+DHdytNHfSmo0kd6tAJNQKajBg1g
	19w7qBiEa0pztym6egUsOs17P2WHpWhQsAcmX96bQwLaoPf2qz2epQtwpeDPDLSuG1ZcHxhtJwq
	3rXfrz8rgOev2XXyhP6H6FUfvVQvOvnRKqjgJPyfRQ8lOYYdEnZnHe5GXUkruoCepEYi0BP1OAk
	fTqlqay5bcnCsGSP/nT/tk6Dv12ezQr0RI5SPOYVC1Oo/RBwZzFrsX3pxRIBQCSJnSCHQc8NjlI
	J6ccyYx6TgBXNRJAPpUr8M7sGoD60SZcfT9lfpR66tqxH1PZiUUrqkkST383y2Lt4G7Q+k+n2kC
	IZOPIqcLxV6fBvuoVZjjMALOeM1k0ANMC+viEukru4MIpqkncHvpBtO+TJKVCVJkQcw06kB5D1C
	S489gxk5TG1ceclKBZYVuq013k9jNT/PMpIGifWdPBkB1MIOWK3JwaWqmGMWIrEpdugY85JAfkZ
	fzUQGcjUeuhu2bFwWOPvXOHCTniGvhP+PkL/NquPwVWAiU01PpUeGzAfs6qQZA2fs3c/qIb
X-Received: by 2002:a17:90b:39ac:b0:3ad:85fd:711c with SMTP id 98e67ed59e1d1-3ad86ce82a7mr635334a91.28.1792549225142;
        Tue, 20 Oct 2026 19:20:25 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802917c3sm1979077a91.7.2026.10.20.19.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:20:24 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] tty: sysrq: reset the per-device key state when reparsing reset_seq
Date: Wed, 21 Oct 2026 10:20:07 +0800
Message-ID: <20261021022007.1717207-3-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021022007.1717207-1-zhanxusheng1024@gmail.com>
References: <20261021022007.1717207-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

sysrq_parse_reset_sequence() clears reset_seq_cnt, but reset_keybit is
only ever __set_bit() and reset_seq_len only ever incremented.  struct
sysrq_state is allocated once per input device in sysrq_connect() and
lives until the device goes away, so both accumulate every time the
sequence is reparsed, which happens whenever the mode 0644 reset_seq
parameter is written.

After writing 56,29,111 and then 59,60 a device keeps all five keys in
reset_keybit with reset_seq_len 5, so the effective combination is the
union of the old and the new sequence.  Holding just 59 and 60 counts two
of five and does nothing, while releasing a stale key drives
reset_seq_cnt below zero.

Clear both along with reset_seq_cnt.  Also delete keyreset_timer: with
sysrq_downtime_ms set, holding a full sequence arms it, and it is only
deleted on a press outside the sequence or a release inside it.  Dropping
the old keys from reset_keybit removes both of those cancellations, so an
already armed reset would survive into orderly_reboot().

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/tty/sysrq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 4fd5b3ace9c40..bb202fc1ccf0b 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -691,6 +691,15 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
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
 
 	for (i = 0; i < len; i++) {
-- 
2.43.0

