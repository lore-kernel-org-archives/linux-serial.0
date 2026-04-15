Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306537F8B6
	for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278288; cv=none; b=lzGO5S5x2DtcJl8EeKn0PLLxHs2WN3jitDnxTiT991MpUx8L7Ds+XzR/mIKUYgNT8/ApHQIyBx335iBbI+ocNDDkpANrZArna6sA4p1wqoiKG/rl3IGrUzFY3UaM7dm282PDmsBL19IZNBkf8HBS1jRU+eFETV0BDB+TSp1HsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278288; c=relaxed/simple;
	bh=9RSII71/jNnvAOcFmcfnWZ0Y9rCchJepmkQZ7efG4JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMfFiiTGaC/uy54FRtQ9gKnS1kPa46zRfkEWMR6kBcTRnmh6+NJhsqDPMDoqs+nJ8a246rVaWySbxC+lKrOVeT2riN4Xa1koR1OIzPmOc3oqnKsXmBN//PLbB8KSipJKGDLfCWmVqiee6bgpH7eeOBD3kNCFX1e2Cgn9Po3eU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgMkqVhp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgMkqVhp"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f37c09352so2701610b3a.0
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278287; x=1776883087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4ZTI/wYqnqWn46+oi6fQh//I+QeN1uMmyxPHBv5EkQ=;
        b=JgMkqVhpgm3LLmArRPiCLbO6vyal9M0LC5x287tYgUigKrwzYQK3iItVFr1xHrf6nj
         6BqEQ4wlxRxdg5uqj1+4x4XeCwdqdOb8Cp252usHezcwIT7ZOKFa5lP051lZ5gOkFXhN
         o8KT1MHCNeJS7FzGGN9329bdJfeL3HiiDkyj1WCo1ds3lAM43E/a5o9kCgxtPOrztMyS
         do59b2j2W6HR/igAyp9nT5uRh7KcOhAIQxuVf9D44atThGH20yHU9+wxbKuhyPlLF0BI
         5N7EdCvFur+G4a8zJMawlw+0vtR+PkQsuE73UPUQA50QNbyTGOinkFOrX66vj7vYgxfL
         KweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278287; x=1776883087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4ZTI/wYqnqWn46+oi6fQh//I+QeN1uMmyxPHBv5EkQ=;
        b=gOS2H98ZW89zVJXBQRptHwUgLrB37BMMxG903TlZzLwDnybuWhxvGy2fKvBBkQzk/c
         VTspCmHVEkGMapCe/A/WlTux9iKeCUfDF3/4nJhVzO4R3+TL+7jbcF2NL93FnJsDpmjQ
         /ftwmaWGihbNv+ivWUQs9HXXNSx6ASUuH8dpvMjluMvNisgT9hSSfG2FsK9OpYbybagY
         HJ5ZrM7gp9uOOspAfeXS+FdzAcB3jh21THsqD8ymvTDZm9SgTy6WeG/EsryNiUssCiVk
         E7J9WrIvO/TNVgF7zDpteuT4RkxdRq/Brom7IcTuTgGbDp9UFGVWTyVIZPic1JmBL5fi
         qwhw==
X-Forwarded-Encrypted: i=1; AFNElJ//omtS7BM/PoXxkWsrd8wWMty8Jo2RCynbs+dRvJ7U1aC+ntTylN4n7WAWa6+hzGqqzusmhuSb5jPjakU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVsEBfags9OcYHE328F5ckPkWxqa4GhJG4EokB3wdrfWgmkV9
	kLd+oQ9jFH6V1/wb2PyEpuFmw1utqIGF2ggbeutMQsIp+J0cjwuCZ1+WLlE640rM4D7IEw==
X-Gm-Gg: AeBDiesPrymjSv+cBZTpmSnuFFfLJnTWDzoVdphefrY0Tuq1h1lv8dVKyrDYDzoYJ7L
	uVKBwvziYre0dXun8Gl8FHKj73i8qhN+X7+PL0cL72EG4mqPT0a6wTRfDEiC6h/+TIFXDo+wy5w
	+vakcYqcA8yn7B4FxIQDjdfdVYLXZmb2aZMKvXDAAK83XhZ9LCBIpN2I4FHWCvXbfRhVzlbYnzQ
	49N94bx1Wz23A/X+HQ3gGLEBhrRKiMMBrdZBvfg5AGrazw6TF/LKTfHqCkyvENB+Kvvov16VqCy
	+q/20i2bXd43niM6CvH3JxqO97RA5MRAye8RhwEwLGGF0yWPdnFuGQ1aYWwiSDXbaK3LgJJa2Wm
	nXxHN5ZKgjFq/7SGcd6du8HC1C3URBjOQ7ntVpQZ9qCI7of2BqwMuw8QTXL8GBY6O8DbPAUjeJT
	CE9MAWDgwhHeXjwHJA93MZaF/sNTP5FXilmmY=
X-Received: by 2002:a05:6a21:6da0:b0:39b:8e94:c4b2 with SMTP id adf61e73a8af0-3a06d17e69cmr551491637.12.1776278286823;
        Wed, 15 Apr 2026 11:38:06 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6707b717sm2546151b3a.21.2026.04.15.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:38:06 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_boca: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:37:55 +0800
Message-ID: <20260415183756.3770073-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in boca_init(), the embedded
struct device in boca_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  boca_init()
    -> platform_device_register(&boca_device)
       -> device_initialize(&boca_device.dev)
       -> setup_pdev_dma_masks(&boca_device)
       -> platform_device_add(&boca_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_boca.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_boca.c b/drivers/tty/serial/8250/8250_boca.c
index a9b97c034653..70ea8e30ae80 100644
--- a/drivers/tty/serial/8250/8250_boca.c
+++ b/drivers/tty/serial/8250/8250_boca.c
@@ -39,7 +39,13 @@ static struct platform_device boca_device = {
 
 static int __init boca_init(void)
 {
-	return platform_device_register(&boca_device);
+	int ret;
+
+	ret = platform_device_register(&boca_device);
+	if (ret)
+		platform_device_put(&boca_device);
+
+	return ret;
 }
 
 module_init(boca_init);
-- 
2.43.0

