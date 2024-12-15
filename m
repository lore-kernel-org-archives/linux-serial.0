Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20886A41;
	Sun, 15 Dec 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734298230; cv=none; b=Ppp1VDXdY0Wp8bvSu3vyzo8orcGxCRck9PFdeIewOYl3et2fCAIwjdsCVh50JU3tsWhYZz833jUx8yyUuJ6OboY1puVxpUE6IbdBlY+Cu/cG0Ttx2YLUpPVmfKvvhcesKxzt6Fz2gUBCsUH+eT2mAX1upq6egVp8mqTLlk3J5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734298230; c=relaxed/simple;
	bh=/vgcjWBQaayL88eBJmHYgwfsah0n3Y19QFNSLC/BZGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jpqmKMuIYQIkoqFBv5ANqJ6GGG2VPMdjOdOcdjHU76ZEMziLpQThGKSogiVFv8q6GLskJNfSwbP43nIQZGxDGRqaeQzKM5YwyzPM6EKWCVZhaj2HOLnS6eRFQ2R9D44Ea6rdxvcPvlwutZEtJTPxFYrdRm/a7WtrgVlW5ZPm6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQxIvufE; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQxIvufE"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4affab62589so599726137.1;
        Sun, 15 Dec 2024 13:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734298228; x=1734903028; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zwdAWU5z4q3pUc9+OTHFhVntEGvY0ysvhuZV9WcLI6A=;
        b=eQxIvufEFfpbP+4Fx7wD/i0T8YKg8e27Js157Oht59kFf0B3TjtetVX/yFNmkmobRZ
         5huENcMrgMM58I29gbSFnWl7CodNCwipkTxKPafC6j/zKMwTvch/ng5+YBh7TWMO7r6o
         BVJiQUG87hdpYOWcOexmSxS8qiT/JNRrZginkEelgReEiPQ9sTdMQ19ojexVZ2PPyVHr
         TA92jXyD68OXOaYUqvZUuv0WTw1fpkha8WzVEwODLbkBOi0MIfBJp/B4nkF1RRLpJPyK
         YpG4wgr+S4h3sFL0r4rp3iqHkkaWgfBE5wEwGtlcPuOY2oejsA1yJtiMFz0XI8nC+sys
         NgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734298228; x=1734903028;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwdAWU5z4q3pUc9+OTHFhVntEGvY0ysvhuZV9WcLI6A=;
        b=MmWWz1SRddX4fcVM1wHoZRa2ST+jiw9pdNuwJpL2jZPbNbQ54FuXdaXOe4v0GK0KNy
         VpOIsicud1PsJ3colwz2XfPmqfhJDczCMNeNtbBS+rOrZVaHtQ5jxEGe8K/RiuttD4rq
         zArQNNuvj0mz5NYBjWfhd0l+8UXZ+BdHnhvhMT0fG16PMw428Y8fN/4/w1kDLCIZsSyx
         Da3ILP1dEmWPcJ2pOHqw2aC9Pwz3KbmoceXVrAiwV88MgvC4Bmz9hYODObbefMwgdyoj
         iEWe44X6SuPbV0RIPlHUC9KNp3dUqYpxNWsVOkTeZypxbWoggD35PrNvZFJ6dE0mVzd3
         qWMw==
X-Forwarded-Encrypted: i=1; AJvYcCUd1afihd4opMUkkhqc2xcpxmOUQOHk+sbMfCP8kA2lzA6RKRDlKWvueDKqtAzRN2awZctTam0MexjfBU61@vger.kernel.org, AJvYcCXYtAzcc8zkSIEylsGyhGdD2f/4gJ34YLZnmllO/+4xP9cYvtvJ7Cq6g4us7tfRGkSj3/CDyI5GIwWMBi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+VVVMhmOfZaeu946WfWE1AY95Dyxwp5h2BJmCCGQrjhPloRs
	dJUxDHKs302299LcTY9yhoZ/yueoc06CpL/VpZ2NGnoEtcXpJ20WNKHy6LZ4TjIDTA==
X-Gm-Gg: ASbGncu/5a7kYWovmhuTdxb/YnxV15D7/DGeajiIDe2paGiG7wY9m0dJ8w3x5sjgGKo
	qLHNG8ApXYO8MvRWrT77V+N9X4u/d2ltF8lxQthZ0Q3NP5YRbW4uulI70ev20AXtKyrBAUdKnz9
	GRBAr/y2u9N3Av+o/OnEZIQABWm0onOq94RdacnPWk4nJMxxSathcnHk2FwkdP69raLig2ROKqW
	e6xIjI0vvv9jgUIb1B8v/eLqP1tuMmlwwgdvaLDVo7fYWXCFUxaEo5gdCEpDdLdG1ZW+yn8qaGU
	CYvprnFIp6I0GJTCWrqFca2edpUp+e7vSQWQxXpecg==
X-Google-Smtp-Source: AGHT+IEkKWZUPMxcmijAdhVhuLa0n/V9pEl4+iPW0VFzMYQXiZclIuKwXu5A5SGdyt2MOcFtQ1Ug7g==
X-Received: by 2002:a05:6102:510b:b0:4b1:24c0:4272 with SMTP id ada2fe7eead31-4b25dc944f4mr9274852137.12.1734298227872;
        Sun, 15 Dec 2024 13:30:27 -0800 (PST)
Received: from granite.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-860ab587109sm677814241.11.2024.12.15.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:30:26 -0800 (PST)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Date: Sun, 15 Dec 2024 16:30:25 -0500
Subject: [PATCH] tty: mark ctl_table as const
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-tty-sysctl-const-v1-1-96884e456126@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHBKX2cC/x3MSwqAMAwA0atI1gZs/eJVxIWtUQNSpSmiSO9uc
 fkWMy8IeSaBPnvB08XCh0tQeQZ2m9xKyHMy6EJXShcNhvCgPGLDjvZwElBTZcrWqK6tDaTs9LT
 w/S+HMcYPkRhjsGIAAAA=
X-Change-ID: 20241206-tty-sysctl-const-2e4b37b1875b
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 "Ricardo B. Marliere" <rbm@suse.com>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>
X-Mailer: b4 0.15-dev-355e8

Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
ctl_table"), the sysctl registration API allows struct ctl_table variables
to be placed into read-only memory.

tty_table is registered as a sysctl table and should be treated as
read-only. By declaring the tty_table structure as const, we ensure that it
cannot be accidentally modified at runtime. This change improves safety
and aligns with the recommendation from commit 7abc9b53bd51 ("sysctl: allow
registration of const struct ctl_table").

Cc: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Ricardo B. Marliere <rbm@suse.com>
Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index dcb1769c3625cd0f7d1555260adfe6051139a305..0e84677712b4e1eb72f209c4d9c54a940b3a9041 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3618,7 +3618,7 @@ void console_sysfs_notify(void)
 		sysfs_notify(&consdev->kobj, NULL, "active");
 }
 
-static struct ctl_table tty_table[] = {
+static const struct ctl_table tty_table[] = {
 	{
 		.procname	= "legacy_tiocsti",
 		.data		= &tty_legacy_tiocsti,

---
base-commit: 535a07698b8b3e6f305673102d297262cae2360a
change-id: 20241206-tty-sysctl-const-2e4b37b1875b

Best regards,
-- 
Luis Felipe Hernandez <luis.hernandez093@gmail.com>

