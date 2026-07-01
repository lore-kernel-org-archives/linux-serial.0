Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C521B191
	for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2026 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876445; cv=none; b=dSVmrdbac2fXf1gONw7nGgSoEs4KClJV9CXD/zqqCVvJwQvLdEFlpraUeiKd3RzxDYPMhfANHQIJIIUFyxIwNKnOQRqq58pTW9uw3Mi6mKaVLK3iS8FspaXfmdXbZV/Gcu20KEsihzwdp6NNXCpZOh3tKWapk/Zy2P90aB/6GdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876445; c=relaxed/simple;
	bh=w6uJpggd2cqVnat417yYxDlhCQmorhAYHla7GWhjJbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJVILDIcpfYI7+fy2b+hPLNBs7invZGSxcUrgfqI8HJ6+j1IES57yYQ1PzsP1spJs36ut2zty3dghmocGGAxTpwSJNFA/FQEuekqFBUY58cN7ifU0XrcKAgbq44wNSqhb6VUfsBJgU/VS3yvo0SkPyMNUcpDbhpgepvMORv8Rxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjdev.com; spf=none smtp.mailfrom=jjdev.com; dkim=pass (2048-bit key) header.d=jjdev-com.20251104.gappssmtp.com header.i=@jjdev-com.20251104.gappssmtp.com header.b=CbK7iKla; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjdev.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jjdev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjdev-com.20251104.gappssmtp.com header.i=@jjdev-com.20251104.gappssmtp.com header.b="CbK7iKla"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13b35ec7767so71654c88.0
        for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 20:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jjdev-com.20251104.gappssmtp.com; s=20251104; t=1782876442; x=1783481242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dfP/9lqdx/Un8wwf/j5S0H3Zabu/Avogqk7M755vQso=;
        b=CbK7iKlaNt+WcTvN5Cbi0sVKozY0Fg6P3wk1RDSmcOsKaoh7OlzHXm2KZndijSpnP6
         ofZALjjbtlAUdlq3QKPeGePMMmvfldFphPS48tOZz105Tae7kVuW7bJx2gO3JEb+VAEs
         Wg7cTKxkkmXFqidTzkv6FAT8ci2qaRi/WYXN0b+Vf4b1z0EleUXn50vu6vtTaU4BGLda
         4PKV9GnT9CIb5J8dUUb/4DxkKujlTpizJYKmoR++t1mRm3yjK52HRAa4CNyBCEw5YptN
         3YoGGyFpEAbPK9jJeBxi+Ey+lxO4fqM3MaA0fLM3F1AOuwNwTW9jTZJLtVaZ/k4HHJJ9
         2zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782876442; x=1783481242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfP/9lqdx/Un8wwf/j5S0H3Zabu/Avogqk7M755vQso=;
        b=kgDuyJC+oi9RVlupf2V28dnjPElAJ+IaBfQxb1/CRLjHTfuootXlw5lTBDzmiW4WV3
         eN9I7WpmW6XBXUqSPh7j+e5dRwdwEwALoch/luMSUlJ+bIqVHQArLns5+EFOPFm2AXRe
         B9AEawSZfI3VksVXaFtL9IGCbF7mdshWl9gnr/K07WfT8+GSU57OXE5tvyRoYbzCO2+J
         WlJG29fsYS6NQqyzEBzy0smBg5eI13bWn+LWU91xV2h9mnl1WRAM35sCyjgUfba88JuL
         JXjJbJ0jnw+W464B7s8NkiFFvCOGXRO7fSyEgS4A9Cf1EKblb2L1/EoeNLB506TqHDJD
         DoJA==
X-Gm-Message-State: AOJu0YzOnviZ4SpJqgE9Buf3P6Whgr9ZmxUS5gYhig4SBUS4K1G7Z4Yo
	/czVSln6SJS980BJyhhNDW6f9V53yUTRBd/2xwfwWaSWZEUYcn70FfjtJZDaAGBDxwnXhvB5E1w
	7XhLV8A==
X-Gm-Gg: AfdE7cmrK1fWIDtGvsh4QW2CxMCglBxgWDNLEksfbqfMFxk0GtllA9v6Aj2yN/3ZaoC
	v9Vq6kF2t3enZJjV09cFpGgKYwQSD+yq27TGZbz6aPgnFAnB7Gb8uO3/HXhYA147el6RPUgkKcV
	BZFSeSMdGhFSSNO1TPu8xEPCI5BsFLKlY8Hz6QuForIQ4C6ySmvHaxfJGoRGIcy4J6TivhdvWwp
	MkhKP1nHfzDalyMc23WgPbJPwqRrdyABwBd5xHu7qAf6o+ePZH79eb4l9i2BI08uF/a9lLEd+pw
	0pO6Er4N/Io6UIJrfPRg/GZtyAfUBXz4JRIObSQrIVzKTXev9DNb4gJfCIElx3GeH/maqzhyaYg
	gcYVj96fJrEr3JeCjWimAEGxL+eJj6A7YLbYKIr7t0fDNF2HaY+2MT1cf1oy75GGGCJHaO6qQpp
	8NrvsFHYiL0A==
X-Received: by 2002:a05:7022:fa02:b0:139:eee5:792b with SMTP id a92af1059eb24-13b2e27fd6dmr3322030c88.9.1782876442422;
        Tue, 30 Jun 2026 20:27:22 -0700 (PDT)
Received: from jjbox.local.ftr ([47.151.31.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b309476e9sm6706762c88.8.2026.06.30.20.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 20:27:21 -0700 (PDT)
From: John de la Garza <john@jjdev.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john@jjdev.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tty: tty_jobctrl: use guard()s in tiocspgrp()
Date: Tue, 30 Jun 2026 20:27:17 -0700
Message-ID: <20260701030139.3189030-1-john@jjdev.com>
X-Mailer: git-send-email 2.54.0
Received: from jjbox.local.ftr ([47.151.31.186]) by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee324b197sm13240161eec.26.2026.06.30.20.01.42 for <john@jjdev.com> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Tue, 30 Jun 2026 20:01:43 -0700 (PDT)
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the manual spin_lock_irq()/rcu_read_lock() nesting in tiocspgrp()
to scoped guard()s. This drops the out_unlock and out_unlock_ctrl labels
and lets the error paths return directly.

No functional change intended.

Signed-off-by: John de la Garza <john@jjdev.com>
---
 drivers/tty/tty_jobctrl.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index ef8741c3e662..583e2412a47b 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -506,29 +506,23 @@ static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t
 	if (pgrp_nr < 0)
 		return -EINVAL;
 
-	spin_lock_irq(&real_tty->ctrl.lock);
+	guard(spinlock_irq)(&real_tty->ctrl.lock);
 	if (!current->signal->tty ||
 	    (current->signal->tty != real_tty) ||
-	    (real_tty->ctrl.session != task_session(current))) {
-		retval = -ENOTTY;
-		goto out_unlock_ctrl;
-	}
-	rcu_read_lock();
+	    (real_tty->ctrl.session != task_session(current)))
+		return -ENOTTY;
+
+	guard(rcu)();
 	pgrp = find_vpid(pgrp_nr);
-	retval = -ESRCH;
 	if (!pgrp)
-		goto out_unlock;
-	retval = -EPERM;
+		return -ESRCH;
 	if (session_of_pgrp(pgrp) != task_session(current))
-		goto out_unlock;
-	retval = 0;
+		return -EPERM;
+
 	put_pid(real_tty->ctrl.pgrp);
 	real_tty->ctrl.pgrp = get_pid(pgrp);
-out_unlock:
-	rcu_read_unlock();
-out_unlock_ctrl:
-	spin_unlock_irq(&real_tty->ctrl.lock);
-	return retval;
+
+	return 0;
 }
 
 /**
-- 
2.53.0


