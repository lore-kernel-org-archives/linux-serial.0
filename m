Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363807;
	b=qdWN+aDyY9/MSCVNLqTfouVAIlDcK7mchlOMw1HGBaEMOBIq9aZYrnOhVIwCtNLcPEuP
	 TiwrDrkN6Xp9wpL5KyZePdL6qb7u0B2iRo2hr4QXKpfCtYbiskMYbeUvoxCTgJYtFbsX0
	 y3dP5ydOCZKh2xNGH6PUmUyG96++ZnIkq6lnDFqI73SUKVGztbq3v3VzIs0viAX8FT6zy
	 zajqMJ+xNH5GY0IqalaLjXpO66/HkGupwTWrVXGtD25JhkE+zdd81/aN3INf5kQbCkUj6
	 XM2IAO87pw+ZzGMy6ji8VT1X82naohx3cdNSMIvvU8JTC6jsFrujVKzEkwsl4iViTtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pQElCk2k12jaC6kpnqjAIZ7YfARLoAsxq+ZYdTzaT7U=;
	b=5L06myiiQfJXZWecEmXz/NPFals7L7nhCXcjgSIuDUaK8JP4V86/qRzSR5gNciIhYkZ5
	 v8yket25/VpH3Fbl6GByo1Ex/TimtlNkLmh3iK9aGkmsNptvJWZPEKA+YSBhx0qwkn5f7
	 3uW5Z3mo8ljZiCDy4sXL6vhHmZd8qfBqP0XBNrmfkkBA2jfnev7E9D3CclcuFiOo63RAw
	 xfU+bwsf1e4PW+y+w1XtbnatgpswQcOTb6/sy9VXFzPtQaI0xs1mQZ+2ZvpsfzVvul/sP
	 NVTZMSGsJ6/StfJSzetJVrNO83zNZ9kbFl1tuGh3E8mYzPRnL79vgWLGDkjd7qFtQMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fj3ZP9Cf;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F342606A31F
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 12:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F342606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fj3ZP9Cf
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35b2c599f43so1552389eec.0
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363806; x=1793968606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQElCk2k12jaC6kpnqjAIZ7YfARLoAsxq+ZYdTzaT7U=;
        b=fj3ZP9Cf5Y+e7SRaimUSFagvNtkpeoPKFhmaUN/TOWxv6iWzE/oJaP4Li4NwNzjOSF
         YwditmzupbjQkaHhRBJK9P642j5o13rhvL2p2Xmh/RysNjrrSRaHtVDudU528cNZNRzm
         ndAZVJ9IrDhDAlLg07xslGNbl/1VLsnxzZ/jlRAKdsFsth8qhq0p8IZq+vACSXKox5oZ
         blxBPKgiWHn/p0w5vxI+udQejA6fBo6JKV7jdXSromfqxshAuHWOZB20pnGBOowFX1lT
         YFSb1tsVgw/XP/alZzIfMOkIetsIXRWL2AO6Ob3Aemg3ByvLsDjGHUKqICWJB5JF1me/
         AkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363806; x=1793968606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQElCk2k12jaC6kpnqjAIZ7YfARLoAsxq+ZYdTzaT7U=;
        b=My8Riq0rjSupbX9huAkZuO+Ea6El5Nud9sdIiT5MKkGlCyke6TD31ePC4X6RFhRfHj
         YE/yP/QUkIXL/qHf2p5VRN1D1pzKfpi0EukYVBSvo8kbJ18sGL+FCI1K5DQxtT/QQFc3
         AxKxS02xCnYMOxfzzk1yCWVvGT7XdGr/zdyyLVJkn03U6e5ywJcjM7vnaenm5yZ20fD6
         j3JCFIrZ3fKJMFzcO8txy4wKnsoAsxEggGjoPyPIgN+FJFGlKjwUIYpTHdw/XcdHRIHJ
         y8RttbZt48hKTfmL6jPaD6008thX1OnZqfA8EBrKoUWMTOWLujs5PBd2un1eCsh/8leD
         euYg==
X-Forwarded-Encrypted: i=1; AKwUvBwbBnld94SiAxlY88U61e9eLWaQKm+RbrGWTiEd4jKHobr0/YS1jDHL6IgjSgh3RWk/Hm1pZrZuyZTfLRU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlYl2W6zIHeU8R0X/PPNzVgV2K5Bs5m7+UgWv4HZv0qtyhl78r
	4r3+vSO5cYbH+lACx8GQGxZeoK6oG9IHy8rpm+MgKKkE3PWGTfiYAAIs
X-Gm-Gg: AYBFou3hGUrnxFSjn0cjeX6qNevocCl+vmCU0SNWnzjr+cN1fLKNs0Z6up6h2yTS9BF
	/3oJEq7aPFPi98beZmn7Uleblkii1eXRtgpJXUP2Dwp+ov000XNFUNM409yEHKoJA8lUuzndwDN
	2XTQCzrjhLJRA9qdVpb+OIrHYQYOz5bj6ZSQO7Kg72Swoh1TeQfM0jC/0gr/6StkZi6By9Gh44L
	1Cfd/i4e4q+tus/AsJ/OFWEARnXAcShn7+M07epFLopji24bqumtLzW00krg83YPY4qtS9DM54G
	KvjCvw0Inp8f57qGdjugwAdqFSa8gjlDY65SrsssOhQVi8Mqi9J9E3TbNgUuNbuPU9CsnNh+RAc
	3N9DGcjJ+RMhnOUANrEH1JpBcH3RuoUsJlVpzSvghWIMkBCXaFnb2qNty/o691SttbJSM4WYalb
	TLHqZeyLUr0enpZw8uuifFtu/3wipW6YsE+Jb4GKxqnxNX+J4TFeLi81qyMxbcc5BTbo4P+KW/n
	gw5GiqL2yGiC1Xvst2q6doVCaoQ3MJxmLUO6emMitTymlRL3oPWLjg7+TJvovUjCNYskPShW0CB
	eFTgbEM/QjhReU2uaDjWhJq9G0Pvyl3Bqf/CliDsjPe+R+AV/x17GGQZIUZbxCdtqaI=
X-Received: by 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr4018459eec.27.1793363806237;
        Fri, 30 Oct 2026 05:36:46 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm6382373eec.4.2026.10.30.05.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:36:45 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH v5] tty: sysrq: clear the old reset sequence when reset_seq changes
Date: Fri, 30 Oct 2026 20:36:40 +0800
Message-ID: <20261030123640.263164-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Changing reset_seq at runtime does not work on a keyboard that already
used the old value, because each keyboard adds the new keys to its own
copy instead of replacing it:

  echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq # Alt+Ctrl+Del
  (press any key)
  echo 59,60 > /sys/module/sysrq/parameters/reset_seq     # F1+F2

F1+F2 then does nothing; only all five keys together reset.

Clear the old keys when the copy is rebuilt.  If sysrq_downtime_ms is
set, also stop a reset the old keys already started, since releasing
them no longer cancels it.

A key pressed while reset_seq is being written can see a partial
sequence.  With this change that can happen on any keyboard, not only
on ones that never used a sequence, but the window is a few
microseconds and not worth closing.

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Cc: stable@vger.kernel.org
Assisted-by: Kiro:claude-opus-5.5
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v5: Dropped v4 1/2 and rewrote the changelog.  Tested in QEMU with a
uinput keyboard: the new sequence resets, while the old one and a reset
armed before the rewrite do not.

v4: https://lore.kernel.org/all/20261030045854.153556-1-zhanxusheng1024@gmail.com/

 drivers/tty/sysrq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b496..a90e97a6d7aa 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -689,6 +689,11 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	int i;
 	unsigned short key;
 
+	/* A reset armed by the old sequence must not outlive it */
+	timer_delete(&state->keyreset_timer);
+
+	bitmap_zero(state->reset_keybit, KEY_CNT);
+	state->reset_seq_len = 0;
 	state->reset_seq_cnt = 0;
 
 	for (i = 0; i < sysrq_reset_seq_len; i++) {

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

