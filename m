Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A91348C6E
	for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2026 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942570; cv=none; b=ZpbG+B27BUMovgN1J9DLIeC6Ry/C6W+WISacOsYfqNULeLwVhVMPV2Maxc9vOZpfxn9xWwLKw2Nw/bs7NvIzHts+ecLujLpR8nA6QmTETBXeGhqIL9RwvNEuskpSv9z9pc9BWiBqeD0Hb6I4kfAsaIXhxXcu6ni41VFR4wC4O8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942570; c=relaxed/simple;
	bh=e2Mc99S14EwiVlrTIXj/dnyd1xTRih+Mv0plP40AMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRJ0M5Op3UtmWJkoSbV6+QvqYs3ZMbzyYBdhfuC30iciYE3OJ0dgx3sEb5QtMzZHtgFR61xfmph5vFKYH97DDivPV+KMqcMWTytt0jHG/sdhvkJe72Fe3DuHRGasEiOTV7Cz0uay6rNg/wtmdmFL1xstt55PI952hrhdLT2G9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjdev.com; spf=none smtp.mailfrom=jjdev.com; dkim=pass (2048-bit key) header.d=jjdev-com.20251104.gappssmtp.com header.i=@jjdev-com.20251104.gappssmtp.com header.b=pJBDzHIp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjdev.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jjdev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjdev-com.20251104.gappssmtp.com header.i=@jjdev-com.20251104.gappssmtp.com header.b="pJBDzHIp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38005a36edbso677298a91.1
        for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2026 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jjdev-com.20251104.gappssmtp.com; s=20251104; t=1782942568; x=1783547368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dokrBTB60egFqlcTSb9K7bU6xTuOWrnhTXnVJVb3iw=;
        b=pJBDzHIpsKpKIS38jm9SnAGUQpj4SqMh7VC7TDVSt8dSB/3WF6dPiJgWuHd4ofemxN
         KCFnyUT6GcomqqG1UQSx22Qcb++l8Ml9LQh1ZO1rX1Cnw9JLhsgeULlIPTiKrbCzluSK
         jiP0x8id71FCHWJ0hvVEXrYkMPdupicY7NFG1F2ezft/O0C+nhI91OWVnCTSP8TI7ZoZ
         NvP9Dwg1v10E/0FfA5Gewi2l5lLIiSCRCsjnAW1/sWYSdDSS8TTTk4hRBQa3YXypwKMV
         znV3S0jy7qRUwk0oEUYYy6hUp1/lXnd6tt3Szr7+18O1ZT4DZ6sICK945uvwfUSjwepH
         FHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942568; x=1783547368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dokrBTB60egFqlcTSb9K7bU6xTuOWrnhTXnVJVb3iw=;
        b=pYTcHduff7KsDc/B06Lj+flFYCodNnrZ9tlnI3J1ikvyeblo7Sr5xf+k9/VLg3H87+
         J8lE1eIbb271QACZz6Q6z/lwswejnHYfjSqX+WJCpmYMLUGpQRZ2GdtFYQoB916FhnbP
         lra7x6zWg9UV9J7UH4NYyLpa1g0/nfIZVVtrIU+6Art7RfQebudRNFt7xetw2zr/Y809
         ex3PcpQRh0Wib6lWKnqA7gvaPgIs0CTTeAoL0QvsXzXHnkwkgQ4jy8R/ga8WAxpXMAor
         uon/Ff2HTxgpDiIDafPVFeOyuHcXeG1/TQQ38pQtaYNS6ZKsZo8T30qY66Il2EGtHRVM
         wqPw==
X-Gm-Message-State: AOJu0YzA9+R79YgUYcHL0ewFeWgkSBOebjh6ocB412SPYa7Q7R0P6OEL
	ETJ5NsdJ0PM6EvaXpnzVjJNQ2vZy86Fm7LYvJsGO4wrh3DpOpaky2qGn4Ynh5fDs5+UYIi0WxbM
	s1ibtLQ==
X-Gm-Gg: AfdE7cm1dLH9Wee1N4iuAfF+rVQq/HFwKoVTIBBY7Pxqd3HKNKk+ds130ac7i2dOrzq
	ndc/2jkXfVL9HGSXICLfq0D3Yrnl5HxAWjqYX+Pgl2+ZJoh8XaMX17VfJNTyzYKAfe7zar/jWl8
	/6G6h/0V/QV+c+XcUnXyMQouu6AuGaPQ5MPnaNQl2AwAE7MsYzr6ewPu5b6U2by2ny+HkSiBbE7
	rj8Fs+CKrDNdZ+h7sJt/HmK1scrrj84afNaMjEitCvMn5/Wuc+ZKpdRQmDAEc+h9ZzQS078QzZA
	SSyTDprkgXRWHAak74VUu8G/Cxc4hmwtT9onEH7+60WPzRyr7PCS3iwzCikpfYbdtdMyrmMxwBO
	YWQJfBszvecUHD3IG5WU1M7sdcIEANcC316j0L1btAO59S3iI9PQp5E/+qzmot0aVkAyZdCFrHd
	nPq9r2/oNRbA==
X-Received: by 2002:a17:90b:5845:b0:36b:9e24:c692 with SMTP id 98e67ed59e1d1-380aa1c9748mr3074310a91.20.1782942568113;
        Wed, 01 Jul 2026 14:49:28 -0700 (PDT)
Received: from jjbox.local.ftr ([47.151.31.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbdc4eesm1662488eec.24.2026.07.01.14.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:49:27 -0700 (PDT)
From: John de la Garza <john@jjdev.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John de la Garza <john@jjdev.com>
Subject: [PATCH] tty: tty_jobctrl: use guard() in tiocgsid()
Date: Wed,  1 Jul 2026 14:49:25 -0700
Message-ID: <20260701214925.3966663-1-john@jjdev.com>
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

