Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F02DF156
	for <linux-serial@vger.kernel.org>; Sat,  7 Feb 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770492572; cv=none; b=GIM0MWCcYgQe3UlcT0/vUbxSIjIvFF9cUh1vZ+K2IuButn1C/vZti7bpV5F3dD9/AEThib6NZa9iTNpszoxQvt0Jfm0FDJ/HRPNZXsL4bmpH/JSDvzw/aJ2+ZbMNnCsgofekdhPnDJXwA9fo2DjS7wRB4SrNB8n2J/pUm0vC04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770492572; c=relaxed/simple;
	bh=1XwCZACXh7XVimHfiAz3VFxENT0qeowTpniTRbSryQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eKWwQoHgyYQC4uHA1tJRa+NaggnCksyUqFA/EeiibFMFwuGRU6ouyzotA3Cjq0P1m1tbBy8vHuiHQ5igZmkJc2SVutn8xbBR38rZMgXkdid+NXObz9VicybWfph+jgb31OrX5jgdJNc8LSfi11N9Aar40+9lVJQiUC17T+LkKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeQCBsG1; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeQCBsG1"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81f38d974e0so415829b3a.0
        for <linux-serial@vger.kernel.org>; Sat, 07 Feb 2026 11:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770492572; x=1771097372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcvhmNVs84PWH3yl8LDlWw8EhMaj5VuDhhNZHpIXvLo=;
        b=HeQCBsG1oHOX/NOWlmvMEKeRCbnXSfYGs3bL9uk4Y1dUx5W8DSdxXH4uM1VJO23Zdg
         tC+4sIbbnEwQOT0t+CwDq9gV6ponFf2cZb47DugmvMRiK6n6LFtTgdoF2Iei/7cuq1mC
         3rh/77WyQveE+TSLBxzEKj9rSF2SPX8rfMtCTBQUNjgvFA+bkE1wUedS8wYIV9wAeucT
         DLzfAmdnWmLiY0UWd/plyc3VQeupIP8hkDkMPgN0nQHoJUI2W1Uh4/X39oOJZbpxO12u
         jGvTMTwWjNgVSOBaPEDNKMKwnELpSPor9O0HFjbHouiEb8DSz+TP6YSzFB+LXjnJpesQ
         HRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770492572; x=1771097372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcvhmNVs84PWH3yl8LDlWw8EhMaj5VuDhhNZHpIXvLo=;
        b=fCBvWElc92k9k4g2M9YIzDY8yY15S93v78MFP4oKibafQ5CJtSun11tYWm95zC/aPS
         OM5qo/+YLiGcwru6dJWEWT3378XSBrwzCWci/1z5YfpH5TS9WcKdygf3/73VgvIqANol
         4aGjc8A2B7/bUojRxuBtC2hiDSUuxVYQ2gsWR7T9GERMqAJFJa3Va3mb7/F1eC7E8Ghj
         D0YMBP3iZ/FO5EIcdArFulgzrn1RP6Gd/h9roi505Wd4zXoC/ltNLhx4GxNvCr7qNULq
         1va9Jla05C85YT7anKYPTTbeIXKRu1pkMDFCml3MnkASVELTklvDhDiWi9DXh3DpaQ5z
         FK0w==
X-Gm-Message-State: AOJu0Yw36mrPTHh1zh/M+uSiTsIcZVyorNQlaGNWb2/+tEZObrKPsW9g
	pt/BA8EoyxgBNmjHJ1Uq84DjSw6ppoYJflkLANZ+Tzukz0m9rKcdmiuELo0X5EpnWG0=
X-Gm-Gg: AZuq6aL+q0sbB52Sg2zhSq+++IKfd6DctrvX85fywWtBROXgCBVgyFmdWTDx0RO3OVu
	ieRhlveGemw2CVPbVXCvaDTGCTGxHuuDnXR5OHyuAC6TjTe9KUZ23HIMOGOdX9a4akITYyxnm16
	LII6RfL1ozII2N/6frOq0P6mlWJJt5W4zTJDvWulZ7wQ97E8hEcYMRLrggnM5ziOx5iCjrP6Liy
	jh3mAM2IA1pT8z9V+zORKqqJQr0WFd4ZP8eYSDnboXaprIWIE/Cru33FP4Pbx4BFI+hhWXOW8Jy
	R/2bbRQTk32cIsmAiOJpFecXmrbKs7DNblmCYKKKDQ5tyuF7/in2AxUK6UXKavdnWRY2AZKs+9o
	FEYURQ5uVTxl7a4j+xCouxHw8D5mYWpstMQ79Q2kcftvqHs+8PfKbizMRROWEF5Uv47bO+q8IWB
	twXJ5Cd1onyNvLGQ==
X-Received: by 2002:a17:903:2407:b0:29f:2df2:cf49 with SMTP id d9443c01a7336-2a951819ed4mr49880115ad.5.1770492571637;
        Sat, 07 Feb 2026 11:29:31 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:bb2d:e035:1f86:719f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c782desm60852705ad.25.2026.02.07.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 11:29:31 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Soham Kute <officialsohamkute@gmail.com>,
	syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
Subject: [PATCH] tty: vt: keyboard: fix general protection fault in k_meta
Date: Sun,  8 Feb 2026 00:57:08 +0530
Message-Id: <20260207192708.44188-1-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a general protection fault in k_meta() caused by
dereferencing an invalid keyboard pointer when checking META mode.

Add a defensive check to ensure the keyboard pointer is valid before
calling vc_kbd_mode().

Reported-by: syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index d65fc60dd..b535d7a42 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -880,7 +880,7 @@ static void k_meta(struct vc_data *vc, unsigned char value, char up_flag)
 	if (up_flag)
 		return;
 
-	if (vc_kbd_mode(kbd, VC_META)) {
+	if (kbd && vc_kbd_mode(kbd, VC_META)) {
 		put_queue(vc, '\033');
 		put_queue(vc, value);
 	} else
-- 
2.34.1

