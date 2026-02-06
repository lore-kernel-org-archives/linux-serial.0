Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5863A2E7F25
	for <linux-serial@vger.kernel.org>; Fri,  6 Feb 2026 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358809; cv=none; b=WC0n9yYqV8Sr4XduYKOI1zfYTJDlgdPzLQtKm3fwkOv53bFpI9SS/RO7MKTppU45fqdrtLmA2jBrY+iDSDGx8DFQPH+O5KnfNB0GKPOh1VUi5/fj2bS4gKeqlfryhp+KMuw8nWXwJZfW8WrN61tIqROnqaoLgXkfaP43GPmYfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358809; c=relaxed/simple;
	bh=xIOMITzk6t7GBFmQGzTwzNYLousGKE0G8vJxVVPGw2s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uZfRVZIltz53uWh6n5+QmAo4rsd6XpAmYjSu9wfxdy8V9maz0hiOkhSGUg0zsfFP1M/y9WDSXgcE0EJQMW6ToSrJGInuTBgtzv9CX+9az0B/miL1HPX9XZ4Z4YL13RBCEjnSqM1gqqAQHtfKM09X7YWImiKnDpIskg8bNhFdYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWNFy18B; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWNFy18B"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65941c07fb4so2737406a12.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Feb 2026 22:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770358808; x=1770963608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z91AyLavQ9E+OzREQeugmqJzK6joS+ypk+HxCV0cQS0=;
        b=fWNFy18BwEyCuy7uCvLeURIv85h+6r6wWNU+5JMsebsj5TlgpZalkQwMgRatCG1F7S
         SrHQUmvPoEVhi88H2elMzUSYjKQIZYzSRcn2HsCyIdamz69tLWG9ZBJqB9902K0p8x65
         dQh7SB5pAAqsp2e9i5Ppnye63WGYiA3vB1MyYtTSRF0e9vYB1qsaG3bhQt3AMTZcc+sq
         bOnAcGMJhpO4KEubovmN/IDW6N1ojEpn5d/zoD3PD8fo070cEYG7rzfuul+vVC3Wa5XH
         2PVcPlKkhMwjZU1Rvb6qUXelfhUFa3SQCHH7WvWFktjOQmJzI+6Qh9UbB4Fa1zUydLAB
         +Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770358808; x=1770963608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z91AyLavQ9E+OzREQeugmqJzK6joS+ypk+HxCV0cQS0=;
        b=JXmAs5/R1yPYLEw0c3F7Uss1V36Xzd3YQ0rAY1hWQ+g/8Z96KUAg739qb3W4+JTvDL
         sKBFrSCgdmhaSEbgepF/xh/OYCbJwUGqfeCcO7hlNjX//F0S/U0BzqSsRTdd7CiWCCWP
         nxiv4NfLTNfMT2Mhu2FtN2zSBehF5k/Z2CgchbTDJ+dRHAZLafR7MXeMeNXnNcJahw3d
         KTL0ixkVVjBqRxL8XOl2QimZj2SJUklbAdn3BrS8DGNVlCfhWw2dYVZbEzlcEKnLe4og
         oyUnnulVTiEYjlvVefVuyuJJYwV/1f5Lyz7y+wPanduNRM0C/m29n9F+Qs1pcCEWb/m2
         Xp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzl62rKVtt5O65ucom9kd6dfTvknMeQDMAn9v8EhZLyH6vdrr8rAKJNLEKku9Q2++mPhaPhfgm1P4tmII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54en3JafrXHNx4dmYjw6tOfp+aPqWJReXRmu9PjA2yBAODl/5
	GOLGLFXmKb3qByZMHdAwlTbUWCXkLNZT8jtGRMkY64SRIJ7sWULuyhfD
X-Gm-Gg: AZuq6aKapVNav4Ax5F25V39LpUYZGD2cC+DIWEMZVrBTqXzBnOZacq1L30dOBPN/PNI
	c7Wyq5Vvh7sJ/OWHER9frcWB8zBydMbiLeyVakoN05uF0ph7BpixKeGuyEEY8nvzLSQ17/gT8c3
	5dDCMJzjR0N7kOZiUrO2s3ouqwTYvm7sFMkVzALV3ihHKW+LC2czUTScTHC0L1ulomOfICRbS2l
	oKH9xiexC6tKo9D9C661Jw/cLfsW8bgg00nEMQ4rUyKYiu76DzPmHwRwTg0NjXvcOdvkiL5itEr
	eaRQIuf4cAHhfO3ZOPXRm9CJt7V3u73WexSzXsh3ivboixbKCtklShW2GFfNVDsWD/CxzALZYZ7
	PXwMYiyLfP19zwWvyYDDP/+5yZYZA6Vmw5sERHGkd7aDIvKKpedmDEZRtJtZNtokZqEBK5braFw
	vfAw==
X-Received: by 2002:a17:907:2d86:b0:b8e:796a:fd5c with SMTP id a640c23a62f3a-b8edf1f0e52mr86321466b.27.1770358807540;
        Thu, 05 Feb 2026 22:20:07 -0800 (PST)
Received: from gmail.com ([2a09:bac5:4e27:270f::3e4:5d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edae6fa84sm52835066b.67.2026.02.05.22.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 22:20:07 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: constify tty_ldisc_ops
Date: Fri,  6 Feb 2026 14:20:03 +0800
Message-ID: <20260206062004.1273890-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_ldisc_ops is not modified once registered, so make it const.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 drivers/tty/tty_ldisc.c   | 16 ++++++++--------
 include/linux/tty_ldisc.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index d80e9d4c974b..470a47aca03e 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -44,7 +44,7 @@ enum {
 
 static DEFINE_RAW_SPINLOCK(tty_ldiscs_lock);
 /* Line disc dispatch table */
-static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
+static const struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
 
 /**
  * tty_register_ldisc	-	install a line discipline
@@ -55,7 +55,7 @@ static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
  *
  * Locking: takes %tty_ldiscs_lock to guard against ldisc races
  */
-int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc)
+int tty_register_ldisc(const struct tty_ldisc_ops *new_ldisc)
 {
 	unsigned long flags;
 
@@ -80,7 +80,7 @@ EXPORT_SYMBOL(tty_register_ldisc);
  * Locking: takes %tty_ldiscs_lock to guard against ldisc races
  */
 
-void tty_unregister_ldisc(struct tty_ldisc_ops *ldisc)
+void tty_unregister_ldisc(const struct tty_ldisc_ops *ldisc)
 {
 	unsigned long flags;
 
@@ -90,10 +90,10 @@ void tty_unregister_ldisc(struct tty_ldisc_ops *ldisc)
 }
 EXPORT_SYMBOL(tty_unregister_ldisc);
 
-static struct tty_ldisc_ops *get_ldops(int disc)
+static const struct tty_ldisc_ops *get_ldops(int disc)
 {
 	unsigned long flags;
-	struct tty_ldisc_ops *ldops, *ret;
+	const struct tty_ldisc_ops *ldops, *ret;
 
 	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
 	ret = ERR_PTR(-EINVAL);
@@ -107,7 +107,7 @@ static struct tty_ldisc_ops *get_ldops(int disc)
 	return ret;
 }
 
-static void put_ldops(struct tty_ldisc_ops *ldops)
+static void put_ldops(const struct tty_ldisc_ops *ldops)
 {
 	unsigned long flags;
 
@@ -139,7 +139,7 @@ int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 {
 	struct tty_ldisc *ld;
-	struct tty_ldisc_ops *ldops;
+	const struct tty_ldisc_ops *ldops;
 
 	if (disc < N_TTY || disc >= NR_LDISCS)
 		return ERR_PTR(-EINVAL);
@@ -202,7 +202,7 @@ static void tty_ldiscs_seq_stop(struct seq_file *m, void *v)
 static int tty_ldiscs_seq_show(struct seq_file *m, void *v)
 {
 	int i = *(loff_t *)v;
-	struct tty_ldisc_ops *ldops;
+	const struct tty_ldisc_ops *ldops;
 
 	ldops = get_ldops(i);
 	if (IS_ERR(ldops))
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index c5cccc3fc1e8..d227a58e3e49 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -266,7 +266,7 @@ struct tty_ldisc_ops {
 };
 
 struct tty_ldisc {
-	struct tty_ldisc_ops *ops;
+	const struct tty_ldisc_ops *ops;
 	struct tty_struct *tty;
 };
 
@@ -281,8 +281,8 @@ struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *);
 
 void tty_ldisc_flush(struct tty_struct *tty);
 
-int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc);
-void tty_unregister_ldisc(struct tty_ldisc_ops *ldisc);
+int tty_register_ldisc(const struct tty_ldisc_ops *new_ldisc);
+void tty_unregister_ldisc(const struct tty_ldisc_ops *ldisc);
 int tty_set_ldisc(struct tty_struct *tty, int disc);
 
 #endif /* _LINUX_TTY_LDISC_H */
-- 
2.43.0

