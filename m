Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8734DB52
	for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2026 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947541; cv=none; b=ROZzhpdItyU7wZNd9qI+3P2NbA87rLYslCU3JoIscd7H8gLMsqnEjQ157aoHYJk30F+fJdzAWz7J7vh933jGYoBlNGE1znrxnbdMUDzbE4qB7/1uludEjz/y7OLAeRRPq/qRp3fUFEa8orlrXBfGSpti4DQ84aUOrNLhGQHr8tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947541; c=relaxed/simple;
	bh=e2Mc99S14EwiVlrTIXj/dnyd1xTRih+Mv0plP40AMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNebd0b9f4Q0+Kd5kMNUnIWJoyHtL/PmgnwGlFfK2M3IJWIr21hMK4ZbEvf3iEtX9jNgQUGTItwZMqd/Wg4z/iVZUzhwlZvkRUM2KHrwaHgVY6UJ3AvWPY2J1fZgs8b3zc1bbqSb2ePTEWVJ+ifOB75ebnGWlh/hXyknAJcl7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjdev.com; spf=none smtp.mailfrom=jjdev.com; dkim=pass (2048-bit key) header.d=jjdev-com.20251104.gappssmtp.com header.i=@jjdev-com.20251104.gappssmtp.com header.b=a6Z67XBM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjdev.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jjdev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjdev-com.20251104.gappssmtp.com header.i=@jjdev-com.20251104.gappssmtp.com header.b="a6Z67XBM"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37df72c9984so699550a91.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2026 16:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jjdev-com.20251104.gappssmtp.com; s=20251104; t=1782947540; x=1783552340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dokrBTB60egFqlcTSb9K7bU6xTuOWrnhTXnVJVb3iw=;
        b=a6Z67XBMGfMHqV0Zq6ymj2ustnAktBSM8ZcqexC+sS2JQIcwUi4IEPq5TACgXJi46L
         vfVOwU/gUNkDw+2qEQWKVQDxtgOk4sEngrYrfwdqzuXDPD6ZasKcfP+IRlhlIRuuZyGT
         FHGokoFqnSZKBqCh0E32Uq6s7wGQE8UTeKHu5uJv61yXd8c9e55IuUPYS6M7Axn9Tdwq
         Dgeq4+iP3FTc3RgiFyIUpXPSrlhFv3eWqPmV+bA46bKz7v5iLscdgQvr/vk6+BjqO5rP
         5nOsDX+3J8/6a7wu/bP4ja6oVhUK2E/4JmZXCHoY7ScK/NyitP4rXj/vbSnHx6FHIqo2
         FwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947540; x=1783552340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dokrBTB60egFqlcTSb9K7bU6xTuOWrnhTXnVJVb3iw=;
        b=U9432H9M/GAdlKe1DPPiPbqb97vUgQCO5MS/5aXV0fgFZPj9zC51P+wFkN4Fynm+e5
         0OBwPLpqQ7AJUg5ZnaNf5vWs498PKMNpEFtIpcyTRzhtck0gGPtje0ZYFLFRZcBy5FPT
         tFAMMjHedeMzocD8jM0mrP4IHLm9UBOOnSQDRV6eSSWRp4urJrWS/y+qelywLXapelFq
         0TdvWMnMHCaI1FrTKxoL8fwAsx5d3nPCTpPAQjGb6qRLP/6av4wvSwgKVSHjoPZAEXfS
         lx1yyU9B4ICN5TiWCNaY2jKxktviqiOUG6m6uO43OsMaAFs49T+KcI22hwuligU4OSmM
         yCYg==
X-Gm-Message-State: AOJu0YzJu2x8d5S9M++KK7yCHcipVPx7M6xcAimAykrdDqoUkEa9Cgpw
	oVwfHX1wjdlvV91e4w09flreUx/xy0iLRbYKYJ862qLHeuHBpaNrZOw2bhutY2+vvg==
X-Gm-Gg: AfdE7cnBsdbXT2FhkRLX+XtNakWBMBVc7XobMm1GhPseZL4Cgr8FrQMd2abQgENA5S6
	e2TiwKxrFqDpcPnKf5UHHAcKszknrt8q8K2++vowB57SJ06PEQUwSaqZ9XX88elE3b/kHjDr6kR
	cuXlHyi3SqlRYweDsKulhOP5dRiwPb8SrtfA41awXXVBZNHZ9AaUi0OAqzjHEYtCfhMvTZDdVTZ
	xZXjetx/gp0lnsVUZN2wkcrHYS3Jt2U0mhRm2zERLsii7dmT3BHvZHOoBGldoSMjenVFaasZhJL
	35C5Szt4fsoMT2bcunRCGYyBMude97CbPrjnOUhCS5HzMTKs6onQZyyGN/oFCKxWz/v7eojmyx2
	6LZieLsipXeT11BpWKg8tZzxggeaF8JSztwdVxmWOhhnuCMCOgIIjJQYQ+VjA+42Cf3na510fiC
	jXUE7J2zDDkQ==
X-Received: by 2002:a17:90a:d408:b0:380:7b4a:162 with SMTP id 98e67ed59e1d1-380aa12f611mr3830833a91.9.1782947539761;
        Wed, 01 Jul 2026 16:12:19 -0700 (PDT)
Received: from jjbox.local.ftr ([47.151.31.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813c4dsm1968839eec.7.2026.07.01.16.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:12:19 -0700 (PDT)
From: John de la Garza <john@jjdev.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John de la Garza <john@jjdev.com>
Subject: [PATCH] tty: tty_jobctrl: use guard() in tiocgsid()
Date: Wed,  1 Jul 2026 16:12:15 -0700
Message-ID: <20260701231215.4092457-1-john@jjdev.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

guard()s express more clearly what the lock protects and let the
function return immediately instead of jumping to an unlock label.

Signed-off-by: John de la Garza <john@jjdev.com>
---
 drivers/tty/tty_jobctrl.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index ef8741c3e662..939569f12119 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -542,7 +542,6 @@ static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
  */
 static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
-	unsigned long flags;
 	pid_t sid;
 
 	/*
@@ -552,17 +551,13 @@ static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t _
 	if (tty == real_tty && current->signal->tty != real_tty)
 		return -ENOTTY;
 
-	spin_lock_irqsave(&real_tty->ctrl.lock, flags);
-	if (!real_tty->ctrl.session)
-		goto err;
-	sid = pid_vnr(real_tty->ctrl.session);
-	spin_unlock_irqrestore(&real_tty->ctrl.lock, flags);
+	scoped_guard(spinlock_irqsave, &real_tty->ctrl.lock) {
+		if (!real_tty->ctrl.session)
+			return -ENOTTY;
+		sid = pid_vnr(real_tty->ctrl.session);
+	}
 
 	return put_user(sid, p);
-
-err:
-	spin_unlock_irqrestore(&real_tty->ctrl.lock, flags);
-	return -ENOTTY;
 }
 
 /*
-- 
2.54.0

