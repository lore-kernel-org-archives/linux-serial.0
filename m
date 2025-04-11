Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E7278E65;
	Fri, 11 Apr 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370172; cv=none; b=Nqex6bklcPDgOgrQ1TYKvskRI+WV/8f74jnfDWb9JhyUMX7Cm2w64v+WABO+fHsXsnlUY8PivvsMCjKKupwvQQGjFQxc3Aevq8n6itbp331YuPunOaqwgTx8U+TL7TKqGyKD5mg9Jaz/a2b3L97g+6u2/70hEV9ksfE/0jc2spk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370172; c=relaxed/simple;
	bh=t51hRaoSLgtZoqvKBcyvdIVPw9VVq7caVwXSASFVwhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOUUYZxYnW7IZR1IaihJ81RRU030LfdDC8F4InpXt6I0XmqLq7lfleELdYT5kcXymkqA/u/X0iCXZOPgt+zQ/JH33mLodnn72v7ZSGDMygneZe5pD2QYFpODKoszTiHw+JncDp6YKBiOFevpaMOQY7GKJXFmeT0cT6ScWKsDLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNMlCive; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNMlCive"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227b650504fso17611965ad.0;
        Fri, 11 Apr 2025 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744370170; x=1744974970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJJum0r2Y/7pblb79ST9wzJVmnYSTf/wzYK4WqsJza4=;
        b=QNMlCivePW1RCRC6H85VqAZHAuuTM6JFkLNnrJ4yd2e2lMXn+1Vu+iLSOtMwWBYup0
         DlPCAz9qjFj7igiAf15FSeyy9jc6jeRiTegbzicZtUBbHCRerklSxpiMT1CW9jY7XK2c
         LeKcPVo6jv8FEIIyDulNTbQfpO8ZWrreQv+kPPMvZAH1lKPs3yzEHxHfhhRf+6R9VkCR
         IynroWykE/EM3lRgsWIQJ4MlPgZX8MZD6R6XsdmZP6eMNhIFxaZ+KVI97Jgx1EIF3ybz
         UBFg5jNAsztnHH9k0vFhAMxKVRDe0Z5V36KsBcD1yeJPm2hs7k1SsuzddTHeJXqta15l
         F6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744370170; x=1744974970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJJum0r2Y/7pblb79ST9wzJVmnYSTf/wzYK4WqsJza4=;
        b=iDJ4MD/7j8KoEn2MoeMJEuWTFClw78z1vjc6igAjv5xuFrLSzDW8UP8fqsrghzJqAD
         ZuGTdTpof670B+FIY06XIPhIWynnoQVwiYmNGd06ZPeL+aAXkhSXLWe9B9C5FWaXHQhu
         RWSjUen/ntMUcTrHkaQ6NzNKgmzFkddpadRpMWIDT9lVjKuPobbzh+u9Pa2fYVHtR9Zt
         RA1WRyXMRXRvvBlaXmqKrWFG76/3VCz6Ey9oxK9+YvkhSZ9+786/AW3zpqBiXw2Gf5B9
         w0T8jzN/4ubX/JhSBFM15lQdDlMBkgOIbQWhc/A45pHvCtWOwTi7bMaQqQ63ExnhVVJ4
         kCOg==
X-Forwarded-Encrypted: i=1; AJvYcCURPIJ1kiQvtgdsPt0VKasSPALeo4YG5BYcg9EWW4L/nWyVd+rj3OkAEdxJJn+16URcZTlBYlFhKrQ/NRA=@vger.kernel.org, AJvYcCVyolSHei7XgbKz1grqJBiIVBy+B58RGk6L2U2J/p5x/Ot84xi1hNbvn6OH4goRi4P8ybO1ursxWfnZgfh6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+2wuYQskEA5pcWzNPcxIoxC4zETxRQECmq1L8o+IYreiqmu/
	RTxoECmFpkQ74OzJ1WOkJ0ynsHE9uF7AH3S+XOf0rS3kHgDATfoR
X-Gm-Gg: ASbGncuhlVA4jZc/tCQL4neGN0Fwz05+pbAkoceKJDY88dCxfiGeclPtK23DnE8X6a3
	r/gDUDeaAmJ3h4RdebqFm5Wve1snIW3WfO1zsKO2aJHojruKQTsPkDhtEir750TeNDK0NiZwaVI
	4UrM7SZz1X1pzv7QcmOtiCjhG8IjGaCfLygptQollwVSKy6J/7v5sCUUdYePvaSvjWcfWS7G4hK
	MjC8rrPM1e4McVxkeXZ/vX/7trlpX+wTPFhcQ9DT7BN5LLvK/1GyvVaqvdqGD2wj5XM8sSFEQBw
	jkKadmIUs8xD8Z+eqGuteg3+y6SdRsOVtr1QxZNDTERh3pnoyPeGS+KYaL2Rl3Hnf8BSWvXVGua
	ReGSVdA==
X-Google-Smtp-Source: AGHT+IE37OKu2p+wl7A4uY1zRU9IcPq7RqORMjw09Nsb72jo6RP0YRdN1/ey2jXMQMHTP3gF+aPWrA==
X-Received: by 2002:a17:902:d485:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-22bea4bf561mr32527795ad.27.1744370170492;
        Fri, 11 Apr 2025 04:16:10 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccbf1esm46070665ad.251.2025.04.11.04.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 04:16:10 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: tglx@linutronix.de,
	hdegoede@redhat.com,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] tty: vt: keyboard: Fix uninitialized variables in vt_do_kdgkb_ioctl
Date: Fri, 11 Apr 2025 16:45:48 +0530
Message-Id: <20250411111548.31399-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected issue:

drivers/tty/vt/keyboard.c:2106 vt_do_kdgkb_ioctl() error:
uninitialized symbol 'kbs'.
drivers/tty/vt/keyboard.c:2108 vt_do_kdgkb_ioctl() error:
uninitialized symbol 'ret'.

Fix uninitialized variable warnings reported by Smatch in
vt_do_kdgkb_ioctl(). The variables kbs and ret were used in the kfree
and return statements without guaranteed initialization paths, leading to
potential undefined behavior or false positives during static analysis.

Initialize char *kbs to NULL and int ret to -EINVAL at declaration.
This ensures safe use of kfree(kbs) and return ret regardless of control
flow. Also add a default case in the switch to preserve fallback behavior.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/tty/vt/keyboard.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index ae92e6a50a65..d476c2e3f3d3 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2057,8 +2057,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
 	unsigned char kb_func;
 	unsigned long flags;
-	char *kbs;
-	int ret;
+	char *kbs = NULL;
+	int ret = -EINVAL;
 
 	if (get_user(kb_func, &user_kdgkb->kb_func))
 		return -EFAULT;
@@ -2101,6 +2101,10 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 
 		ret = 0;
 		break;
+
+	default:
+		/* unknown command, ret already set to -EINVAL */
+		break;
 	}
 
 	kfree(kbs);
-- 
2.34.1

