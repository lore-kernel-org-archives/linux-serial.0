Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549223;
	b=uH8T5p7Tt81KvgSyxmHGGaIzSjfP05asJDx+HDi8KYZmGizyhcveyXT1pxKo1bcoPa+f
	 eh+xe2njOXzq9CNuMCbc9OkM98Ie8ifrwoPXkWiexSlkD2tAIPOpH22hMMgD73+h8GyS2
	 MMItU7mselP+1nJWpOwvTDa2ppnJMzew7tnSp8AnDxy/Z2wCH94lS8K2nrAHpU0Y5vK99
	 ylopyPWAfOnAMx1LloqxwdCBNS/+nzhwBcUTtdInp/E5Ysr7h1VQT4tFwMq+MroeGW4zZ
	 wAhoiMuUe825LjSu92e0ZfHfdsw+itkUzL4rBY0xp4lrPRipYUFSDBehbvuQIbMS0Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R5ABPDAmo5azEmu7/mky1scPxil0XjKLikkEmkdrdYo=;
	b=1NV7Y+arwY/JUTKQC98MOaAWjkQcZ2QNH9/32gRQzigu02DqzrUJ0b+EI6iOg+uCqQJQ
	 ohPfRrdvVDibq8b5XtE3O6Qd4bp9iP/Db4FYAQdx9ExZ8nCehai8N/m1r/4zqS8t/eEH2
	 I56d0y2olTF1Qp62LnPNv6wuKlNfE17RyiU9buKGB1IunXQD431vU8PEa2pP/9VNjNCvY
	 eIn73dgRkro/AF+4xuPB60sL1zD1DuTjf3iwZJwfNsNO+rclHEbphNGJAQp88PIZZEpEz
	 rEkgI8+oThzO15IZUshQDCH2SUyo0nAjIPwh7MKhXPVAnoxrTMGLRuSKYjF/zeuVDVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="EBv/bMGy";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C2606A31A
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 02:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 425C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EBv/bMGy
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9d1114320so1501505ad.3
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 19:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792549221; x=1793154021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R5ABPDAmo5azEmu7/mky1scPxil0XjKLikkEmkdrdYo=;
        b=EBv/bMGypR2npgmJLCUWcx3lu9HKsaMzuXOR0VtSOLu+i1JCf+PUB+wYHRl04p23IO
         8JiytqtZA3biivPnDbWAgHpcXNouI6ERlFDIHcB+9q7/BUfRvNJ2Rf9cpd4n/zpzXH0+
         BEi6N7S0DC9fU1r2YQcs3Ehuay5SmrnNRZQrjnJvirKS8YyMyk6trIufa/dUywSIauMK
         6jdJxWoIMl8EwJQ2nf33l4bH8Ji3RlXojw2UrvqD3QdkZtYZKQ7Br9tHBVqKDK7xEFVM
         DcL9/lvaQuCJ8rSymKS1Uq8QgkslafS+sHedWg2mCLvrD32Ls5FQIUjfBKsQE+dA5Osu
         HDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792549221; x=1793154021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5ABPDAmo5azEmu7/mky1scPxil0XjKLikkEmkdrdYo=;
        b=uJuvhK5DXD8+eNJI3AFIK3DM9m/aCO0THhKmer5iafiffaPcfa42Tfg2T+1ynPMOy7
         PPGB4D6Nmn9i4dCMg52tevwGV581oZVKTHnE8aTJlesk2ipzJ0Oc7QncW0/6n5aNASh9
         fs7plVZ1PgeqSIFwxMXKgHqkNHmoZvE+y3q345n347V5P+/sIfqBmpHnHRsWolOFgZ6C
         MefDHgEpoeQt/iJ9ybmzM2ry1nWqxmahP142bxI3jtAXmn+KJXTWdYEflyD4vi0FVK6u
         GCMcEzQBHbhOwBM+m59yakde2sVDDiKdVU0tmJrYkKO4t8JAdAbh9WsNJ4wkqvGF69/b
         O9bA==
X-Forwarded-Encrypted: i=1; AKwUvBxgOY0kAiwduF6972HqEwtWAkiy8qyzGUqjETC/uAVbJqP49GmmHnEV4v4OzP48lVwURN+T4Qe+gSqDq88=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu34obQEhQERN6nYZ18ps0Nakz/5odkOJZzDMNxIW+/NQBoKrd
	vMOsO7UL7dW/RRDZYkmCImcxlrPaQ9UMB+sKROyC8epNADyfzhg2LA8l
X-Gm-Gg: AYBFou1Ie3faCqPbH7cEwLyJS2V7OVcPsrhK08gGmVfNQdlthlZSb3+LQGk5yE/fjKu
	RX4Jl8doSpNwe6bopXZ4SytHYJ5wB5u0ztioS5APk7rJRNsqqwWEqSnrKJtNFZdxJd6os2K9JOR
	l7vEvpIsYIyQ5jR/XHyVcVDSlC9dSl/HEVpVnOZuP/7K8zbutDfJLEldyKt8nJRtdU/6V8e4zm+
	2uUJlGquDUinj8ohyAa0Dbi8njBsj68/5dnwT4ZzQH+Kpsx0HFnFs+scbhGQLiTyWdnC4Q3E00A
	hI42OQxeoe4F+K0J73Gsoob5PTqe0+Cos7jOtdWfCekuUAMxxfnbeZjREOl1O9Br5A9H7we9LG2
	OK0by+fpI2kfODbR+Xmy/FwRhQP1PLTxWWIM68krVuD6kBBW7UwWAq+om4RbR6TxvKZ4RH1c/L7
	+oTGTC9VfamqD6TMQcUkcdd2IcbBtdz9or/foZVk3noZK1A5gB7hT+ehKkJrQzclmjnOI8fhOxa
	XIOEV25lTWMPkQavrfFelwEP2ISAvz5OsmKeg8GgvSlvwCz9xmRs+2Smqb4cteu2x7RAc+x
X-Received: by 2002:a17:90b:4c49:b0:3ab:a188:b8b7 with SMTP id 98e67ed59e1d1-3ad86f1bbf2mr640265a91.22.1792549221435;
        Tue, 20 Oct 2026 19:20:21 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802917c3sm1979077a91.7.2026.10.20.19.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:20:19 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] tty: sysrq: reparse the reset sequence when its length changes
Date: Wed, 21 Oct 2026 10:20:06 +0800
Message-ID: <20261021022007.1717207-2-zhanxusheng1024@gmail.com>
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

reset_seq is a module parameter array, so a write to it is handled by
param_array(), which publishes the new length only after the element
setter has already bumped the version:

	kernel/params.c:
		*num = 0;			/* sysrq_reset_seq_len */
		do {
			ret = set(val, &kp);	/* bumps the version */
			...
			(*num)++;
		} while (save == ',');

sysrq_handle_keypress() decides to reparse purely on the version, so a
keypress landing between the last setter and the matching (*num)++ parses
a sequence that is one element short and then latches the final version.
Nothing makes it reparse afterwards, so the device keeps the truncated
sequence until the parameter is written again.

On a device that has not parsed before, a two-key sequence truncated this
way leaves reset_seq_len at 1.  The parse runs before the keypress is
recorded in key_down, so reset_seq_cnt is 0 and reset_canceled stays
false.  A single press of the remaining key then satisfies

	if (++state->reset_seq_cnt == state->reset_seq_len &&
	    !state->reset_canceled)

and sysrq_handle_reset_request() goes straight to orderly_reboot(),
because sysrq_downtime_ms defaults to 0.

Record the length the parse used and treat a change in it as staleness
too.  The truncated parse then no longer sticks: once param_array() has
published the final length, the next keypress reparses.

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-173915@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/tty/sysrq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c2e4b31b699aa..4fd5b3ace9c40 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -676,6 +676,7 @@ struct sysrq_state {
 	int reset_seq_len;
 	int reset_seq_cnt;
 	int reset_seq_version;
+	unsigned int reset_seq_parsed_len;
 	struct timer_list keyreset_timer;
 };
 
@@ -686,12 +687,13 @@ static unsigned int sysrq_reset_seq_version = 1;
 
 static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 {
+	unsigned int len = READ_ONCE(sysrq_reset_seq_len);
 	int i;
 	unsigned short key;
 
 	state->reset_seq_cnt = 0;
 
-	for (i = 0; i < sysrq_reset_seq_len; i++) {
+	for (i = 0; i < len; i++) {
 		key = sysrq_reset_seq[i];
 
 		if (key == KEY_RESERVED || key > KEY_MAX)
@@ -708,6 +710,7 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	state->reset_canceled = state->reset_seq_cnt != 0;
 
 	state->reset_seq_version = sysrq_reset_seq_version;
+	state->reset_seq_parsed_len = len;
 }
 
 static void sysrq_do_reset(struct timer_list *t)
@@ -903,7 +906,9 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
 		/*
 		 * See if reset sequence has changed since the last time.
 		 */
-		if (sysrq->reset_seq_version != sysrq_reset_seq_version)
+		if (sysrq->reset_seq_version != sysrq_reset_seq_version ||
+		    sysrq->reset_seq_parsed_len !=
+				READ_ONCE(sysrq_reset_seq_len))
 			sysrq_parse_reset_sequence(sysrq);
 
 		/*
-- 
2.43.0

