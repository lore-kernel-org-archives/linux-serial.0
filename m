Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E192CCB9
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521108; cv=none; b=Iqv4IXpS30IFQcamMIal3jA+iaN1WIecV8g8d0WriE6IeE3dp5Way9Hdiz2l4D96a3WOK5aCig/lQx3IeNCUV1I6g++NzVPCzbRtdBTGUIc/kSpcZufbPRF0Nv6KOrsFdaAcsXAuO1uAxeIOAY+EiXHa/AkO7AVODXXcyjSDd0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521108; c=relaxed/simple;
	bh=SJRRGxOTPHxzTyKNjhPZiDQLH8oJZ0bbZe6wvXlfvs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EskdDlUtJdDV35r2ClxHz8EHpfxiIzBzLYprgtMXuvmbfLmDhC4AO1XJLCnCWHF3+X7hHtsTkfmnQqCr+q+1SBKktU0MM5hCPpAxpP7eRaBm36D4SwEHtO7AcO9/f40+2LzuCkYMNY6oSgRpktnqBJpLZGEO0o42R6J2Vk0fCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npSr8OiP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npSr8OiP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f64ca1c2dso440379f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521101; x=1786125901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ov0n2RcORghbpUiI0SclFJ455T7zBH3NXkUIJ9HOsqI=;
        b=npSr8OiPL2bPvR6QWzg1RLwvB6W7xbq+i0rnNrozuiFklyjfYebfidQMAT1Ti+m6BA
         g+GVGZhDvAjsQ8wc/5OQtShzyliEIXVD+3djFbIj5HfThcwyrhyLhHJKa9oV/2UyEH7p
         B974pmAgCgHzZJnlptKvT5kBAs78sb7OlzS3hDUAJkeZz463qYE9/gMxKQA3O4Q9tT65
         VRel1LWzlB6hblHuuFrSVz2wejM+ZLxIevl6kRr3X5gdk/s4XwbFR3DNwhueRvVNjUno
         KOjcuhgDGGj+3ebg+1++fswqudxlG257HC8oeB9L2I0UriGGeOMfcfXC7BAdsUqQHf2x
         J5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521101; x=1786125901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ov0n2RcORghbpUiI0SclFJ455T7zBH3NXkUIJ9HOsqI=;
        b=CihHsxyffe+ZVxLSJxb/Ghjc3MBZwcFzdv9iE+ynfamXZnmw1rwkeog7BLvahiDkB6
         PCUFyE5avEmnoVq6dN6w5UuHn696K5TUyCZScRCmWkjy0dW3DK95HgjJenT7b4+VsSi0
         6PPAUPhQqBtZFq+V2EQVf/rhfKUzGHiG01xbHTfLUftu/pre9Lkw4oG5FTkduZC3K0cJ
         zj7Vl5nfxD/d37HkX30oDpHCOjyvRfJokiVMUWe+LV/dPaotYX//u941htxge39Watjh
         ia1OCRFMjABmG5udKQfq3DlCOfakTufpci4yX4brCmJxkWm/tGgmpp/92x6IwyJjGAyk
         +owA==
X-Forwarded-Encrypted: i=1; AHgh+RqrgC0hTE5ZAaKosKOXP0JzXpvzWMijG+PPVDzUBy9Yb007vgHaUYIPKoHd+vvucPgNl61j12JVqtKB3K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPD9RN+ps3d6JS45mgKE43xESN9zWpQNNHFNZJVALlPHnARnz
	kKgL+b/iGXuuhborr95sVBciAd8o53Ov8ZioaUvk8QE2x3TZIIgAs96g
X-Gm-Gg: AR+sD12Ruaj48SJRDan9YGgBhVZq3SYwkNr/mM1cqf+oMKO/CxHDGAQ0HUUqJF64d4t
	jU8A1qo9T/CEql7d8reikGOMA8iJoIlTkghtG4ULpUNGSL5kND+RB2bUxyj3Mh0qo7Ch/hcrTLo
	GvhYvxzfxUISc7d2kQyzxKH78/4v4U1rqg6KClNDEjlTGPtrnO2eBn6tiScqQfjxfzFgvW5JokT
	m2c5/tDMvTPx3urr1oK+1E+6pcdItDr4zoHpI1Otm+z3o3XA2p4NS3rv+cLuqtN33LkaZmYRvh7
	A0LT8RK2KkrmgfP2HmW737Co3E6yt+uLH5lIFacnlIW1PEuRQ8/njvkOuGd5XJD6I3gqxV/0HU8
	iWGRORi2xw9TUcgBVrkQusSHiPMfpfh5xC9u0L7tCR/orPmiMGlc84xb5RpDibtW6pCjTZ6Qgj0
	IFGR1JlWBvGQTUuMEM4dDaoIoIIUIe+cPGY3Tk4qwTp5Vqmi6zGrBG5+tCIXQ1M8gIznGRSQR2Y
	ap7ZICbLxzkcbj9IPr/7s/maKf7we6GgCIzsZRatOXs6YrcX6N34U38+vmSgf9hXA5j5wpCYZnb
	hbwnz9XZtBkCeKvXDmYntbPDOBUof9Gsi0DOLsLKBmy2l37nLJVBozpm+q7RQtbd8AHj
X-Received: by 2002:a05:6000:46c9:b0:47f:8ac0:ccd3 with SMTP id ffacd0b85a97d-47fd72ba5a2mr973748f8f.2.1785521101441;
        Fri, 31 Jul 2026 11:05:01 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bb4esm7914465f8f.30.2026.07.31.11.05.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:05:01 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] tty: clear cdev pointer after cdev_add() failure
Date: Fri, 31 Jul 2026 20:04:57 +0200
Message-Id: <20260731180457.10964-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_cdev_add() drops the cdev reference when cdev_add() fails, but
leaves driver->cdevs[index] pointing to freed memory.
tty_unregister_device() later passes that stale pointer to cdev_del(),
causing a use-after-free.

Clear the slot after dropping the reference.

Fixes: c1a752ba2d6b ("tty: don't leak cdev in tty_cdev_add()")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/tty_io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e742bf9d8631..4889076b975f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3167,8 +3167,10 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
 	driver->cdevs[index]->ops = &tty_fops;
 	driver->cdevs[index]->owner = driver->owner;
 	err = cdev_add(driver->cdevs[index], dev, count);
-	if (err)
+	if (err) {
 		kobject_put(&driver->cdevs[index]->kobj);
+		driver->cdevs[index] = NULL;
+	}
 	return err;
 }
 
-- 
2.53.0
