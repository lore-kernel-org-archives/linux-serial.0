Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617E256C6C
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778382856; cv=none; b=V6CkN5Pyj3Z5GpnYh00vxYusA+CGSvpW6yJoM8yDY4LL0nvL7gtUYuBZ/+ZQ1E6KzKMaeY2htbdjsh9EZqYkIGI5QJf4KapFEU7LPHHPxBP9ET3eo1dZLxP61WcvlUie0sis5at4lk5dHKk4ka9k8dLd1k51gQuf/Q/ejMaFjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778382856; c=relaxed/simple;
	bh=//I/6EMQ3rl40MxAjia93Ci3CX4B9b1McuAHLpTfpAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P7zQTFgcTWZId7pJmniUWzRGWXxOUYXEAZAQ7peHUKNAT0JfMXXSNFb67FIeJclicO74k8ImHgdpoWw+42mSzZu6d6pTuDCbXxciKiSOOtrQ2ws86TYRW33pcuHp2Q8kjAhP7kptILqMKha+TUK23u2YzcJLefX8kVVVarsBTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuQXk7XB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuQXk7XB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so1826852a91.3
        for <linux-serial@vger.kernel.org>; Sat, 09 May 2026 20:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778382854; x=1778987654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pTQn2s211z3JcOYJ6bPA9wHHQAfjgFTJm5bQ3cUbOwA=;
        b=iuQXk7XBQNXT2PCFwDBybumnwVyX4PaAtABlYFOdmBWYhdq313moE71YVKxYBhnOXw
         luGv/DyAKwJtY0b2j28yHp/TcnAMEmsLTjPVKfcpIPFOS2HtF/oRIxKFy4JiQDem7sxl
         N03R8EPXFDjmgC3qDbfImTdXLCllcH6MSRsIbtuw7sqnxy7KwIIkLYYcTCXca3vsFlbZ
         Ozbs6JnmZhJIF6iys7F7YM/H+io/rLpLtihp8EEkgn+e9H0jhC9cEuyV32zSjEfOUhrf
         ofLf3vBMsnNVDzmLLjuXvfMCkYtEvxvDtG9TjjgVsmrnOs+UsalCcRhSEl9+08tWzSho
         Z+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778382854; x=1778987654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTQn2s211z3JcOYJ6bPA9wHHQAfjgFTJm5bQ3cUbOwA=;
        b=Rx74UD3MACLcVopFp5NumggXpatCVBIKixitXqfpU6m7LdQg52zGodZeSDHRbwEidw
         9Iw28fJKt+k8pKUSUwJ+MYjsYkkL2C1Uu5CC2mYT3EVF1yxl4EYaX/8nma2HRD+UiruT
         XZWT5dY0qdwfrcZvFxASjrSOBkgfc94sxiNfrVwgMRu9EDpQv6yDkHYxXmJECPI8qLWE
         8t0TOWxu/dox1i7M0BP+AXani0ssz855bco6oXT7Iga+KDXjEHFuK/2cP3T2IwXWDToE
         e51Mz+W972p2cPhtwXDSrnMojacrshm7km+UVDZ0M14AAedLsn9oGTrOoBjiP1YCk/BY
         EAhw==
X-Forwarded-Encrypted: i=1; AFNElJ9kZzrnm1GuLPYEt3uQFMlup7T7tpTfEamzjb4Rca667B/PkeDw1hbdLSYZTuwIGbI5X2Mmy0q1weyp7xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2Pizx1LwMr9XvO0syAbUIN58ZgvaDyueV9kn70F4mQcihQLM
	asfEkSPfyS8lFtA06zRTHpwsTp3hLKCWhdgn218VMkHoeseDs9EwqsZ4
X-Gm-Gg: Acq92OEs1Gbc5LpxCBLMN8RxQKym1SPrqL7xL/8BkGWO2M4OoBaUC2Kq9pokpg59t2G
	5UNJqzOM+GqlQxDmGdk2VNor2D0Le1NgeVfGAlMJQ3Dy06mh9/wemRT1WlhxguL56K5yCkB6lHW
	G41xXpnt9hZvU4eaA766Fj2g1o0ZC5zSXNRB2icJYnyN8U2HM/TUh1Ym3R6n3RfR3913ZYxZ1Ot
	z8pyheAsQ5NN3TPIqEnEspTY/Mpyy4w0rCQj9q3bOuvTUktsv6SENoRIMNABtEyc1dK+aHhCGRs
	zPffujWMtJX9tsDawXK3ODuTk8mRhdm72uZfWIKLOgJ8PlfIbe639OJu/sJTdTXs6+M7qInLHv4
	kAhgVP3OevF+9B6s3aHwsf7mMLNBnZ+4GRfG6lLvmgxmxtXbfJA+ICAHQBjYDWTZfvjN+Qe1yh0
	KdrDOoeVQCyIdfA29XrhWyRgXEv4vf
X-Received: by 2002:a17:90b:1c0a:b0:366:527:3c9a with SMTP id 98e67ed59e1d1-3664ccca7b0mr8887873a91.15.1778382854366;
        Sat, 09 May 2026 20:14:14 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d625ee39sm3644658a91.4.2026.05.09.20.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 20:14:14 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] vt: keyboard: serialize KDGETLED with keyboard_tasklet
Date: Sun, 10 May 2026 11:13:48 +0800
Message-Id: <20260510031348.1922157-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KDGETLED reaches getledstate() and samples ledstate without serializing
against keyboard_tasklet.

That is problematic because kbd_bh() temporarily stores ~leds into
ledstate during a VT switch to force LED propagation before committing
the final value.  An unlocked KDGETLED can therefore observe that
internal sentinel instead of the last committed LED state.

Other ledstate readers in this file already quiesce keyboard_tasklet
before sampling the value.  Do the same in getledstate() so the ioctl
only returns a stable snapshot.

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/tty/vt/keyboard.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 13bc048f45e86..671ad4a5cb64c 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1127,7 +1127,13 @@ static void kbd_init_leds(void)
  */
 static unsigned char getledstate(void)
 {
-	return ledstate & 0xff;
+	unsigned char leds;
+
+	tasklet_disable(&keyboard_tasklet);
+	leds = ledstate & 0xff;
+	tasklet_enable(&keyboard_tasklet);
+
+	return leds;
 }
 
 void setledstate(struct kbd_struct *kb, unsigned int led)
-- 
2.43.0

