Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471146B5
	for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223075; cv=none; b=UCFZTrIyei0QBd8g1WTGjdDQe7kN6I5B+lhOh8eqgzQXcPqF5G2E9Ev8vRwK4o9blplgCwkgU8nUwMD7Lb89QJwlAUC1wZaDkjwFWmrKRGuxyPSg73d6dEfbzluGEhZwwNFtY8ID2VjROgY8qefL735O3S2/rZCUGPXKGRnSZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223075; c=relaxed/simple;
	bh=T4Ghe2c7fSFbmSl2w/hfc5FFF+awiXu3PdaD4faJT7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uCBuTgw0tX2vDKw9x7FDH+f5TxLEukA10iBcMd5g32AfX20yEq3/utvu4HJaTWF43/o4Y7GANvDyMrKMRYJlaJ7n/oD0hqRqtf5qOcUaNtqtagJncjxAXw6AxQ9CJu5qFnYrdwHXXtkoRzBJ77O9w6Bbxc0ooF6EBZMp21DPVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwDNx5so; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwDNx5so"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f22f6b0feso1743669b3a.0
        for <linux-serial@vger.kernel.org>; Tue, 14 Apr 2026 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776223072; x=1776827872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw6zrmhzVgl0erKx0cVU8q8Z5LVFJZ2NKhxP0jYrwQM=;
        b=MwDNx5soOkMqzlZ8mJ4VIyr3MeMR4FvG+wPhbXxHe68HaoIUwOsm4nlRj9tGJyNEb7
         qExgijPUS0ArpZISSHrXB+AxVlQHIe5npWnkJgXBvEwebkojISpdaAfULFWvXnsP8ZT1
         Uze1w5NWKc2RjSdY11UP7N8edY0UokgRRH32lXA64CghYAbm0gGipcnyw6NDdp4durxd
         HWz9hAxN87d9CvNYsy3EfqDFO36cudnhqKY14lVYOJBxMTcqjAELssovMCszwFuL4UNC
         /ZlHfWaFHoEjKtUifqA9Nzg3WogZZT8BoyUcyR0gVQkml6zCafEoK/oFTqdHQRPNOE5N
         wkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776223072; x=1776827872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bw6zrmhzVgl0erKx0cVU8q8Z5LVFJZ2NKhxP0jYrwQM=;
        b=S1bYVIm+saGgQDmR3rPRNtW5p9IvbpOMBO/s/o99CkZrppW/K5KC+37gfacdce9l2W
         YwfG2y5hWUMSjHhlbZRVOW+KHXekot95MLSJdzUsYP1rhbfZM0CfPC+3R0Hr5rur555t
         eOLvZLLE5vRoORZxbJYetrFj+admU8yDP5xjRpF7SESK0eSmwCW53/Buas7IHoxbhbjE
         dMXQdXzFMd3CrDoHExcFqU6hcrXK3BH7Q8a0EOu0lPf0Hb9sWgvSJQ14ha+tl7DgXch8
         7doDl5nTFS+SkJSnGWQ5UQ+1Wk0Yiarrlq+KHCnDcAahkQRBBa0sd4bBy5rEWUEYlqjL
         blKg==
X-Gm-Message-State: AOJu0Yz7rOw+D8E4tcGYtCsNCr+aKXHsVaOTrqrEOFG3sLNYRoKGFg78
	/BwKtH++e6LGk2RtLiOZjh485Gcp2WHRfrqy3d2J7OfoeL0S5FWFkocK
X-Gm-Gg: AeBDievJMkaoWc2rcXpBF0+8Oad60m4FACu0z69xTiT46adBitZXNSo9sM9m1EYa/FK
	bLDLr/kjihdYluLfpOupOI9ZyZQBH6cS+c9O7ZOP/n9bkwSu2xF0mUzy9x06Vstot1pPkP2CsT3
	DUsNDkqAAhzChdgL/cOA9AwKymye4Ed5UM5SNrk4+DLGkibE/xdMey030glfWLFXVaCDZuKqRIr
	XXHLE58dA4T6d1mOPvMV+ku3GogQ+hBI55W93F4b4J9+IDIuVR8UmvZcJB/ICasnLXBMEyVpoQC
	T4KihPSs/eKW1XS0N9huUb7G2IFGv1E3TVZ7pYm/X7UCearhiY5NuBAVDE+FZQp6hOHP0nhj06X
	o0fv4OtRQ6iy2pRxKuictsW/i2cnjO/Bih5khCVJyEPos2Svan1UgIgx06yKG9N5eFWw3MoOgKM
	2EAuDm9WbLg9sz/axJSVPTqJULILjMtcXuPV9Bsq4zCLWNq1Y=
X-Received: by 2002:a05:6a00:3e07:b0:82f:33ed:88a7 with SMTP id d2e1a72fcca58-82f33ed8a79mr12518419b3a.2.1776223072281;
        Tue, 14 Apr 2026 20:17:52 -0700 (PDT)
Received: from home-hyperv.mshome.net ([103.136.124.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f673e0ca3sm504273b3a.30.2026.04.14.20.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:17:51 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kito Xu (veritas501)" <hxzene@gmail.com>
Subject: [PATCH] tty: n_gsm: fix use-after-free in gsmtty_install
Date: Wed, 15 Apr 2026 11:17:31 +0800
Message-Id: <20260415031731.107667-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415024846.2918702-1-hxzene@gmail.com>
References: <20260415024846.2918702-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gsmtty_install() reads gsm_mux[] without holding gsm_mux_lock and
defers mux_get() about 40 lines later. A concurrent gsmld_close() can
free the mux through gsm_cleanup_mux() -> mux_put() -> kfree(gsm) in
that window, leading to a use-after-free when gsmtty_install() later
dereferences the stale pointer.

race condition:

         cpu 0                          |            cpu 1
    gsmtty_install()                    |   gsmld_close()
    gsm = gsm_mux[mux] // no lock      |
    // CFS preempts here                |   gsm_cleanup_mux(gsm)
                                        |   gsm->dead = true
                                        |   mux_put(gsm)
                                        |    -> kfree(gsm)
    gsm->dead           // UAF!        |
    mutex_lock(&gsm->mutex) // UAF!    |

KASAN report:

 BUG: KASAN: slab-use-after-free in gsmtty_install+0x6cf/0x830
 Read of size 1 at addr ffff88800fd440ac by task poc/170

 CPU: 0 UID: 0 PID: 170 Comm: poc Not tainted 7.0.0-rc7-next-20260410+ #20
 Call Trace:
  <TASK>
  dump_stack_lvl+0x64/0x80
  print_report+0xd0/0x5e0
  kasan_report+0xce/0x100
  gsmtty_install+0x6cf/0x830
  tty_init_dev.part.0+0x92/0x4a0
  tty_open+0x8ab/0x1050
  chrdev_open+0x1ec/0x5e0
  do_dentry_open+0x419/0x1260
  vfs_open+0x79/0x350
  path_openat+0x212c/0x3a70
  do_file_open+0x1d2/0x400
  do_sys_openat2+0xdc/0x170
  __x64_sys_openat+0x122/0x1e0
  do_syscall_64+0x64/0x680
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

 Allocated by task 169 on cpu 0 at 3.824684s:
 Freed by task 169 on cpu 0 at 3.892012s:

 The buggy address belongs to the object at ffff88800fd44000
  which belongs to the cache kmalloc-1k of size 1024
 The buggy address is located 172 bytes inside of
  freed 1024-byte region [ffff88800fd44000, ffff88800fd44400)

Acquire gsm_mux_lock before reading gsm_mux[] and take the refcount
via kref_get() while still holding the lock, so the mux cannot be
freed between lookup and refcount increment.

Fixes: 86176ed90545 ("TTY: n_gsm, use tty_port_install")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 drivers/tty/n_gsm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b..6519f1c92fc5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -4288,14 +4288,20 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	if (mux >= MAX_MUX)
 		return -ENXIO;
-	/* FIXME: we need to lock gsm_mux for lifetimes of ttys eventually */
-	if (gsm_mux[mux] == NULL)
-		return -EUNATCH;
 	if (line == 0 || line > 61)	/* 62/63 reserved */
 		return -ECHRNG;
+
+	/* Acquire gsm_mux_lock to prevent concurrent gsmld_close() from
+	 * freeing the mux between reading gsm_mux[] and taking a refcount.
+	 */
+	spin_lock(&gsm_mux_lock);
 	gsm = gsm_mux[mux];
-	if (gsm->dead)
-		return -EL2HLT;
+	if (!gsm || gsm->dead) {
+		spin_unlock(&gsm_mux_lock);
+		return gsm ? -EL2HLT : -EUNATCH;
+	}
+	kref_get(&gsm->ref);
+	spin_unlock(&gsm_mux_lock);
 	/* If DLCI 0 is not yet fully open return an error.
 	This is ok from a locking
 	perspective as we don't have to worry about this
@@ -4309,8 +4315,10 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 		if (dlci0->state == DLCI_OPENING)
 			wait_event(gsm->event, dlci0->state != DLCI_OPENING);
 
-		if (dlci0->state != DLCI_OPEN)
+		if (dlci0->state != DLCI_OPEN) {
+			mux_put(gsm);
 			return -EL2NSYNC;
+		}
 
 		mutex_lock(&gsm->mutex);
 	}
@@ -4322,6 +4330,7 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	}
 	if (dlci == NULL) {
 		mutex_unlock(&gsm->mutex);
+		mux_put(gsm);
 		return -ENOMEM;
 	}
 	ret = tty_port_install(&dlci->port, driver, tty);
@@ -4329,12 +4338,12 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 		if (alloc)
 			dlci_put(dlci);
 		mutex_unlock(&gsm->mutex);
+		mux_put(gsm);
 		return ret;
 	}
 
 	dlci_get(dlci);
 	dlci_get(gsm->dlci[0]);
-	mux_get(gsm);
 	tty->driver_data = dlci;
 	mutex_unlock(&gsm->mutex);
 
-- 
2.43.0

