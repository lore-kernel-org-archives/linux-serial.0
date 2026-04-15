Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2A3128C6
	for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221340; cv=none; b=pzJUMzeUfrc6aix8clj6IsqzbF8Cja7tiawt7909JSP/bvnhcPDrhpS8MMmSu4aUfsrMYqTycUMbeHCuWR6XAPrNexoe8X5C7onZuKYLccX5BiaFXUbDwOCDbqE2aPtl3Bft+bR9sKxc2RPiJdgXa9Alqpk0DVoEw32pBKycK+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221340; c=relaxed/simple;
	bh=G3xuL8FKw+jWISAi0R0MJNOxevV7rT62xf/okzXkd4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+wXkhF+clNJNbq8Lfy/uRRk+rX8+Z3Hh0M73idCD5MVFpFpvDb6uB+AWMBiOIeaGY1K9na2F1ZClvPElSMc7EP2zq/gTJoHAadUvZ1EdsJW7k+hQSr4mDfSFKy6KZNwz9C/kyBPW+ZjVF1d541hEgclYkYKi8tpFt3RXldZnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TamwuCTU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TamwuCTU"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so3634507a91.1
        for <linux-serial@vger.kernel.org>; Tue, 14 Apr 2026 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776221338; x=1776826138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ile0uMxJExfK9K7honJWpeyBlmJiO3c8q7kZ0+QNxMc=;
        b=TamwuCTU/YkDEkX3jnnr4esQh27hgWkI9bDInusSd+H6NVj2V2gZqR4F0ZS9aOaA2l
         f2EEogD0z65Os1BKV8ZJfCfmGQFwqpfSfR7lAw6+l3XQPRFA7cD3R0DUMW8Xgf9jPz2R
         MLKFlA2nZ7S5wIrF/2A7HkQxTGBCvbxHCj5P8rdR1FmAK7/uExnqW26y3r7T9Sve/a+L
         UUdepFdACgwgjmWl7OyKhI/1w6wiZqf9JjBIv5nsGHqCo20Ini3oGrAdZ2Re5opWDP37
         KOaH+eJeJcMgqQme5pzsvfidqrgqpoYzyd7XRmmHgFawfmi2bQGIYVp07eVKK4nuu9dX
         x53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776221338; x=1776826138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ile0uMxJExfK9K7honJWpeyBlmJiO3c8q7kZ0+QNxMc=;
        b=nsiwvjH5HPMIkDxGrnxkagSjQtMppYo3U0r2dI1TT1SzwieVMv9ZPfbRLAW+hEtZb2
         yQfcPIjGt5yjxULFLVJaZlJK0jHK3h1MCWcBLVBGffqYgt0CHiqJ7P7ifIBrqfK5cllS
         h6t/t6h4iaaQ2/rj26n9r9DmTzptk2WeGqW8Tl10+Ph0XgaogZlPM9RDD7+jP0gt8hqR
         iCSCIq+yOpNMjBsrayAHifD5xZtnxnIRctIdqiauLIsIOAe2NPCJWWPYYiC5eXIFczbi
         2/9U7NjYOngTx/Lepm6CB8xU6+bvREgpwDlkpIPQPOO0tYU9r/P52DNqzJCQE4iaLIit
         ZqfA==
X-Gm-Message-State: AOJu0YxbhtK8WWvS0UeozcXqNfZCZZsgkvJp89jI+WGFt96XsBSGjzNB
	+czTvSFX4qdTjw203EGWWMDpY2UQhMt96QncP1R0mooNVZ5FcfrTMev3gfghOEvPvmg=
X-Gm-Gg: AeBDietYTM4ZEnOPTboZlDElwAljLpaaRGWf1tmy5joZQ60yov/aSX363gwbL/THuBc
	Ec8rmwH9QzTxafS9WBHRoJngOuFF2otm3NIPwUhWRboyW+gb/sXJcFJgaxtGX4byhON4NrOPF4g
	spD+v6byqrcS5q6PyF8re44Br1YXfaOISMv2k/Oh6I4+bC14Wst/wqNaeRdCCK4Ir/cZtO3sD7Z
	SsIyoubAWM3GANbHigY3Gg1hG0pvyQqYnAmjlal8FCREgnxhV+t11W0vMsaK5aTDdAXhYTAdujX
	sJqPrINNlHVEGCX8v2qKmnpD2sxG4c8sY3NZv/Yr6KWDsr1RxS9KwmsD/LK4zr2NsCwMer29Nqz
	rNMD0Izd3LisswthgwDSRBLkKgVFkhaZDf/STojuC7LSx8kTUNN7aJk1O0s+bFpjlG8/nOQkymg
	2Jx6ildlma2HFffpmRAaTm5EDXrZzNE7LS
X-Received: by 2002:a17:90b:3c48:b0:35d:ac4d:3cb6 with SMTP id 98e67ed59e1d1-35e4254f8ffmr19960048a91.5.1776221338198;
        Tue, 14 Apr 2026 19:48:58 -0700 (PDT)
Received: from localhost.localdomain ([117.186.117.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd0830459sm285550a91.6.2026.04.14.19.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:48:57 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kito Xu (veritas501)" <hxzene@gmail.com>
Subject: [RFC] tty: n_gsm: fix use-after-free in gsmtty_install
Date: Wed, 15 Apr 2026 10:48:46 +0800
Message-ID: <20260415024846.2918702-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.43.0
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

